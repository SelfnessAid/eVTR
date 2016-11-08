//
//  SpeciesEntity.swift
//  eVTR
//
//  Created by Derek Stock on 8/25/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit

class SpeciesEntity: BaseManagedObject {

    @NSManaged var syn: String?
    @NSManaged var code: String?
    @NSManaged var name: String?
    
    static let entityName = "Species"
    
    func setData(data: [String: AnyObject]) -> Void {
        syn             = getString(data["SYN"])
        code            = getString(data["CODE"])
        name            = getString1(data["NAME"])
    }
}
