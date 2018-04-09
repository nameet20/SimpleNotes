//
//  NoteDO.swift
//  SimpleNotes
//
//  Created by Nameet Bhave on 4/8/18.
//  Copyright © 2018 Nameet. All rights reserved.
//

//import UIKit
import ObjectMapper

struct NoteDO: Mappable {
    var noteId: Int?
    var title: String?
    var noteContent: String?

    init() {

    }

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        noteId <- map["id"]
        title <- map["title"]
        noteContent <- map["noteContent"]

    }
}

