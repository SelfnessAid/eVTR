//
//  GearModel.swift
//  eVTR
//
//  Created by Boris on 8/23/16.
//  Copyright © 2016 ninthcoast. All rights reserved.
//

import UIKit
import RealmSwift

class GearModel: BaseModel {
    
    dynamic var CODE: String?
    dynamic var NAME: String?
    dynamic var HAULS_MAXIMUM: Int = 0
    dynamic var HAULS_MINIMUM: Int = 0
    dynamic var MESH_MAXIMUM: Int = 0
    dynamic var MESH_MINIMUM: Int = 0
    dynamic var QUANITY_MAXIMUM: Int = 0
    dynamic var QUANTITY_MINIMUM: Int = 0
    dynamic var SIZE_MAXIMUM: Int = 0
    dynamic var SIZE_MINIMUM: Int = 0
    dynamic var SOAK_MAXIMUM: Int = 0
    dynamic var SOAK_MINIMUM: Int = 0
    
    override func parseData(data: [String : AnyObject]) {
        super.parseData(data)
        self.CODE               = getString(data["CODE"])
        self.NAME               = getString(data["NAME"])
        self.HAULS_MAXIMUM      = getInteger(data["HAULS_MAXIMUM"])
        self.HAULS_MINIMUM      = getInteger(data["HAULS_MINIMUM"])
        self.MESH_MAXIMUM       = getInteger(data["MESH_MAXIMUM"])
        self.MESH_MINIMUM       = getInteger(data["MESH_MINIMUM"])
        self.QUANITY_MAXIMUM    = getInteger(data["QUANITY_MAXIMUM"])
        self.QUANTITY_MINIMUM   = getInteger(data["QUANTITY_MINIMUM"])
        self.SIZE_MAXIMUM       = getInteger(data["SIZE_MAXIMUM"])
        self.SIZE_MINIMUM       = getInteger(data["SIZE_MINIMUM"])
        self.SOAK_MAXIMUM       = getInteger(data["SOAK_MAXIMUM"])
        self.SOAK_MINIMUM       = getInteger(data["SOAK_MINIMUM"])
    }
    
}
