//
//  PermitsEntity.swift
//  eVTR
//
//  Created by Derek Stock on 8/25/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit

class PermitsEntity: BaseManagedObject {

    @NSManaged var pnum: String?
    @NSManaged var ves_name: String?
    @NSManaged var hull_id: String?
    
    static let entityName = "Permits"
    
    func setData(data: [String: AnyObject]) -> Void {
        pnum            = getString(data["PNUM"])
        ves_name        = getString(data["VES_NAME"])
        hull_id         = getString(data["HULL_ID"])
    }
}
