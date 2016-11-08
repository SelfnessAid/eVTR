//
//  OperatorModel.swift
//  eVTR
//
//  Created by Boris on 8/23/16.
//  Copyright © 2016 ninthcoast. All rights reserved.
//

import UIKit

class OperatorModel: BaseModel {

    dynamic var OPERATOR_KEY: Int = 0
    dynamic var NAME_FIRST: String?
    dynamic var NAME_MIDDLE: String?
    dynamic var NAME_LAST: String?
    
    override func parseData(data: [String : AnyObject]) {
        super.parseData(data)
        self.OPERATOR_KEY = getInteger(data["OPERATOR_KEY"])
        self.NAME_FIRST   = getString(data["NAME_FIRST"])
        self.NAME_MIDDLE  = getString(data["NAME_MIDDLE"])
        self.NAME_LAST    = getString(data["NAME_LAST"])
    }
}
