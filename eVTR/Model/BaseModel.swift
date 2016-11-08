//
//  BaseModel.swift
//  eVTR
//
//  Created by Boris on 8/23/16.
//  Copyright © 2016 ninthcoast. All rights reserved.
//

import UIKit
import RealmSwift

class BaseModel: Object {

    dynamic var ID: Int = 0
    dynamic var isSynced: Bool = true

    override static func primaryKey() -> String? {
        return "ID"
    }

    func parseData(data: [String: AnyObject]) -> Void {
        if let id = data["ID"] as? String {
            self.ID = Int(id)!
        }
    }
    
    internal func getInteger(data: AnyObject?) -> Int {
        if data != nil {
            if let string = data as? String {
                if let number = Int(string) {
                    return number
                }
            } else if let number = data as? Int {
                return number
            }
        }
        return 0
    }
    
    internal func getString(data: AnyObject?) -> String? {
        if data != nil {
            if let string = data as? String {
                return string
            }
        }
        return nil
    }
    
    internal func getFloat(data: AnyObject?) -> Float {
        if data != nil {
            if let string = data as? String {
                if let number = Float(string) {
                    return number
                }
            } else if let number = data as? Float {
                return number
            }
        }
        return 0
    }
}
