//
//  OperatorsEntity.swift
//  eVTR
//
//  Created by Derek Stock on 8/25/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit

class OperatorsEntity: BaseManagedObject {

    @NSManaged var operator_key: Int16
    @NSManaged var name_first: String?
    @NSManaged var name_middle: String?
    @NSManaged var name_last: String?
    
    static let entityName = "Operators"
    
    func setData(data: [String: AnyObject]) -> Void {
        operator_key        = getInteger(data["OPERATOR_KEY"])
        name_first          = getString(data["NAME_FIRST"])
        name_middle         = getString(data["NAME_MIDDLE"])
        name_last           = getString(data["NAME_LAST"])
    }
}
