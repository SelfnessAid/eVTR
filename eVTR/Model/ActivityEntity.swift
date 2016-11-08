//
//  ActivityEntity.swift
//  eVTR
//
//  Created by Derek Stock on 8/23/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//
import Foundation

@objc class ActivityEntity: BaseManagedObject {

    @NSManaged var value: String?
    
    static let entityName = "Activity"
    
    func setData(data: [String: AnyObject]) -> Void {
        value = getString(data["VALUE"])
    }
}
