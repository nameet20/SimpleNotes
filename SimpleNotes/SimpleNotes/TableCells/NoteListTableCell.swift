//
//  NoteListTableCell.swift
//  SimpleNotes
//
//  Created by Nameet Bhave on 4/8/18.
//  Copyright © 2018 Nameet. All rights reserved.
//

import UIKit

class NoteListTableCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setDataForCell(note: NoteDO) {
        self.titleLbl.text = note.title
        self.descriptionLbl.text = note.noteContent
    }

}
