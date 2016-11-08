//
//  DealersEntity.swift
//  eVTR
//
//  Created by Derek Stock on 8/25/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit

class DealersEntity: BaseManagedObject {

    @NSManaged var dealer_permit_number: Int16
    @NSManaged var dealer_name: String?
    
    static let entityName = "Dealers"
    
    func setData(data: [String: AnyObject]) -> Void {
        dealer_permit_number        = getInteger(data["DEALER_PERMIT_NUMBER"])
        dealer_name          = getString(data["DEALER_NAME"])
    }
}
