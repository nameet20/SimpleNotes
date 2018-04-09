//
//  Validations.swift
//  SimpleNotes
//
//  Created by Nameet Bhave on 4/8/18.
//  Copyright © 2018 Nameet. All rights reserved.
//

import Foundation

class Validations {

    static func validateNote(title: String, noteText: String, completionHandler: @escaping (Bool, String?) -> Swift.Void) {

        if (title.trimmingCharacters(in: .whitespaces).isEmpty) {
            completionHandler(false, NSLocalizedString("enter.title", comment: ""))
        }
        else if (noteText.trimmingCharacters(in: .whitespaces).isEmpty) {
            completionHandler(false, NSLocalizedString("enter.content", comment: ""))
        }
        else {
            completionHandler(true, "valid" )
        }
    }

}
