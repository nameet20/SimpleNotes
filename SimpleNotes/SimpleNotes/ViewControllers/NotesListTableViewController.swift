//
//  NotesListTableViewController.swift
//  SimpleNotes
//
//  Created by Nameet Bhave on 4/8/18.
//  Copyright © 2018 Nameet. All rights reserved.
//

import UIKit

class NotesListTableViewController: UITableViewController {

    @IBOutlet weak var noDataMsgLbl: UILabel!

    var notesArray: [NoteDO]!
    var isAddingNewNote = false
    var selectedNote: NoteDO?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = true
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.tableFooterView = UIView()

        // Configure the add ('+') button
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addNewNote))
        addButton.tintColor = APP_ORANGE_COLOR
        navigationItem.rightBarButtonItem = addButton

        self.notesArray = DataStore.sharedInstance.notesArray
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.notesArray = DataStore.sharedInstance.notesArray
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func addNewNote() {
        isAddingNewNote = true
        performSegue(withIdentifier: "navToNoteDetail", sender: nil)
    }

    // MARK: - Table view data source and delegate

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowCount = self.notesArray?.count ?? 0
        self.noDataMsgLbl.isHidden = !(rowCount == 0)
        if self.noDataMsgLbl.isHidden {
            self.noDataMsgLbl.frame.size.height = 0
        }
        else {
            self.noDataMsgLbl.frame.size.height = 40
        }
        return rowCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NoteListTableCell! = tableView.dequeueReusableCell(withIdentifier: "NoteListCell") as! NoteListTableCell

        // Configure the cell...
        cell.setDataForCell(note: self.notesArray[indexPath.row])

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedNote = self.notesArray[indexPath.row]
        self.isAddingNewNote = false
        performSegue(withIdentifier: "navToNoteDetail", sender: nil)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "navToNoteDetail" && !self.isAddingNewNote {
            let destination = segue.destination as! NoteViewController
            destination.existingNote = self.selectedNote
        }
    }

}
