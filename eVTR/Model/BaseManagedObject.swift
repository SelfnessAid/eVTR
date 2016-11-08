//
//  BaseManagedObject.swift
//  eVTR
//
//  Created by Derek Stock on 8/23/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import CoreData

class BaseManagedObject: NSManagedObject {

    internal func getInteger(data: AnyObject?) -> Int16 {
        if data != nil {
            if let string = data as? String {
                if let number = Int16(string) {
                    return number
                }
            } else if let number = data as? Int16 {
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
    
    internal func getString1(data: AnyObject?) -> String? {
        if data != nil {
            let str = data as! NSString
            return str as String
        }
        return nil
    }
    
    internal func getDouble(data: AnyObject?) -> Double {
        if data != nil {
            if let string = data as? String {
                if let number = Double(string) {
                    return number
                }
            } else if let number = data as? Double {
                return number
            }
        }
        return 0
    }

}
