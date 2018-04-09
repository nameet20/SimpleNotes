//
//  DataStore.swift
//  SimpleNotes
//
//  Created by Nameet Bhave on 4/9/18.
//  Copyright © 2018 Nameet. All rights reserved.
//

import Foundation

class DataStore: NSObject {

    var notesArray = [NoteDO]()

    class var sharedInstance: DataStore {
        struct Singleton {
            static let instance = DataStore()
        }
        return Singleton.instance
    }

    func saveNote(note: NoteDO) {
        notesArray.insert(note, at: 0)
    }

    func updateNote(note: NoteDO) {

        for index in 0..<self.notesArray.count {
            let noteElement = self.notesArray[index]
            if noteElement.noteId == note.noteId {
                self.notesArray[index] = note
                break
            }
        }
    }

}
