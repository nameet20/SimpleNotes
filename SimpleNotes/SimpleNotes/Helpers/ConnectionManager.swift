//
//  ConnectionManager.swift
//  SimpleNotes
//
//  Created by Nameet Bhave on 4/8/18.
//  Copyright © 2018 Nameet. All rights reserved.
//

import Foundation
import Alamofire

class ConnectionManager: NSObject {

    class var sharedInstance: ConnectionManager {
        struct Singleton {
            static let instance = ConnectionManager()
        }
        return Singleton.instance
    }

    /**
     HTTP GET method
     */
    func getRequest(path:String!, parameters:[String : Any], completionHandler: @escaping (DataResponse<Any>?) -> Swift.Void) {

        Alamofire.request(URL(string: path)!, parameters: parameters, encoding: URLEncoding.default, headers: [:]).responseJSON { (response) in

            guard response.result.isSuccess else {
                print("Error get method: \(String(describing: response.result.error?.localizedDescription))")
                completionHandler(response)
                return
            }
            completionHandler(response)
        }
    }

    /**
     HTTP POST method
     */
    func postRequest(path:String!, parameters:[String : Any], completionHandler: @escaping (DataResponse<Any>?) -> Swift.Void) {

        Alamofire.request(URL(string: path)!, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: [:]).responseJSON { (response) in

            guard response.result.isSuccess else {
                print("Error post method: \(String(describing: response.result.error?.localizedDescription))")
                completionHandler(response)
                return
            }
            completionHandler(response)
        }
    }
}
