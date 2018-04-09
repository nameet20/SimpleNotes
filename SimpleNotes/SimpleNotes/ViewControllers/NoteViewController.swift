//
//  NoteViewController.swift
//  SimpleNotes
//
//  Created by Nameet Bhave on 4/8/18.
//  Copyright © 2018 Nameet. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {

    let NOTE_CHAR_LIMIT = 300
    let TITLE_CHAR_LIMIT = 50

    @IBOutlet weak var scrollView: TPKeyboardAvoidingScrollView!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var noteTxt: UITextView!

    var existingNote: NoteDO?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Note"
        self.navigationController?.navigationBar.tintColor = APP_ORANGE_COLOR

        self.noteTxt.addDoneButtonOnKeyboard()

        self.titleTF.layer.borderWidth = 1.5
        self.titleTF.layer.borderColor = APP_ORANGE_COLOR.cgColor
        self.titleTF.layer.cornerRadius = 3
        self.titleTF.leftViewMode = .always
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        self.titleTF.leftView = paddingView

        self.noteTxt.layer.borderWidth = 1.5
        self.noteTxt.layer.borderColor = APP_ORANGE_COLOR.cgColor
        self.noteTxt.layer.cornerRadius = 5

        if self.existingNote != nil {
            self.titleTF.text = self.existingNote?.title
            self.noteTxt.text = self.existingNote?.noteContent
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.layoutIfNeeded()
    }

    func setScrollHeight() {
        var contentRect = CGRect.zero
        for view: UIView in self.scrollView.subviews {
            contentRect = contentRect.union(view.frame)
        }

        self.scrollView.contentSize = CGSize(width: CGFloat(self.scrollView.frame.size.width), height: CGFloat(contentRect.size.height))
    }

    // MARK:- IBAction
    
    @IBAction func saveBtnClicked(_ sender: UIButton) {
        // Validate
        Validations.validateNote(title: self.titleTF.text!.trimmingCharacters(in: .whitespaces), noteText: self.noteTxt.text.trimmingCharacters(in: .whitespacesAndNewlines)) {
            (isValid, errorMsg) in
            if isValid {
                // Save and return to previous screen
                if self.existingNote != nil {
                    self.existingNote?.title = self.titleTF.text
                    self.existingNote?.noteContent = self.noteTxt.text
                    DataStore.sharedInstance.updateNote(note: self.existingNote!)
                }
                else {
                    var note: NoteDO = NoteDO()
                    note.noteId = DataStore.sharedInstance.notesArray.count + 1
                    note.title = self.titleTF.text
                    note.noteContent = self.noteTxt.text
                    // Using singleton class for storage for now.
                    DataStore.sharedInstance.saveNote(note: note)
                }
                self.navigationController?.popViewController(animated: true)
            }
            else {
                let alert = UIAlertController(title: "", message: errorMsg ?? "", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: "ok"), style: UIAlertActionStyle.cancel, handler: nil))
                alert.view.tintColor = APP_ORANGE_COLOR

                self.present(alert, animated: true, completion: nil)
            }
        }

        self.view.endEditing(true)
    }

}

extension NoteViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        // Save title
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= TITLE_CHAR_LIMIT
    }
}

extension NoteViewController: UITextViewDelegate {

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if text == "\n" {
//            textView.resignFirstResponder()
//            return false
//        }
        guard let textViewText = textView.text else { return true }
        let newLength = textViewText.count + text.count - range.length
        return newLength <= NOTE_CHAR_LIMIT
    }

}

extension UITextView {
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        doneToolbar.barStyle = .default

        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(UITextView.doneButtonAction))
        done.tintColor = APP_ORANGE_COLOR

        doneToolbar.sizeToFit()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        doneToolbar.setItems([spaceButton, done], animated: false)
        self.inputAccessoryView = doneToolbar

    }

    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }

}
