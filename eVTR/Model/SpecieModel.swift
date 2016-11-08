//
//  SpecieModel.swift
//  eVTR
//
//  Created by Boris on 8/23/16.
//  Copyright © 2016 ninthcoast. All rights reserved.
//

import UIKit

class SpecieModel: BaseModel {
    
    dynamic var SYN: String?
    dynamic var CODE: String?
    dynamic var NAME: String?
    
    override func parseData(data: [String : AnyObject]) {
        super.parseData(data)
        self.SYN = getString(data["SYN"])
        self.CODE = getString(data["CODE"])
        self.NAME = getString(data["NAME"])
    }
}
