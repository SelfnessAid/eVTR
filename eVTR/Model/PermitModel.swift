//
//  PermitModel.swift
//  eVTR
//
//  Created by Boris on 8/23/16.
//  Copyright © 2016 ninthcoast. All rights reserved.
//

import UIKit

class PermitModel: BaseModel {

    dynamic var PNUM: Int = 0
    dynamic var HULL_ID: Int = 0
    dynamic var VES_NAME: String?
    
    override func parseData(data: [String : AnyObject]) {
        super.parseData(data)
        self.PNUM       = getInteger(data["PNUM"])
        self.HULL_ID    = getInteger(data["HULL_ID"])
        self.VES_NAME   = getString(data["VES_NAME"])
    }
}
