//
//  ActivityModel.swift
//  eVTR
//
//  Created by Boris on 8/23/16.
//  Copyright © 2016 ninthcoast. All rights reserved.
//

import UIKit

class ActivityModel: BaseModel {

    dynamic var VALUE: String?
    
    override func parseData(data: [String : AnyObject]) {
        super.parseData(data)
        self.VALUE = getString(data["VALUE"])
    }

}
