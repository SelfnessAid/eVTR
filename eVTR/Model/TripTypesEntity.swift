//
//  TripTypesEntity.swift
//  eVTR
//
//  Created by Derek Stock on 8/25/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit

class TripTypesEntity: BaseManagedObject {

    @NSManaged var value: String?
    
    static let entityName = "TripTypes"
    
    func setData(data: [String: AnyObject]) -> Void {
        value            = getString1(data["VALUE"])
    }
}
