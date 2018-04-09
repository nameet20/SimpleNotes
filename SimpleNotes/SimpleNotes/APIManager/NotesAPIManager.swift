//
//  NotesAPIManager.swift
//  SimpleNotes
//
//  Created by Nameet Bhave on 4/8/18.
//  Copyright © 2018 Nameet. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class NotesAPIManager: NSObject {
    func getNotesRequest(completionHandler: @escaping (Bool, NoteDO?, String?) -> Swift.Void) {

        ConnectionManager.sharedInstance.getRequest(path: GET_NOTES_URL, parameters: [:] ) { (responseData: DataResponse<Any>?) in

//            print(responseData?.result.value as Any)
            if (responseData?.result.isFailure)! {
                completionHandler(false, nil, responseData?.result.error?.localizedDescription)
            }
            else {
                let noteList = Mapper<NoteDO>().map(JSONObject: responseData?.result.value)
                completionHandler(true, noteList, nil)
            }
        }
    }
}
