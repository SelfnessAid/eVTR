//
//  ChartAreaModel.swift
//  eVTR
//
//  Created by Boris on 8/23/16.
//  Copyright © 2016 ninthcoast. All rights reserved.
//

import UIKit

class ChartAreaModel: BaseModel {

    dynamic var AREA: Int = 0
    dynamic var LATITUDE: Float = 0
    dynamic var LONGITUDE: Float = 0
    dynamic var TEN_MINUTE_SQUARE: Int = 0
    
    override func parseData(data: [String : AnyObject]) {
        super.parseData(data)
        self.AREA = getInteger(data["AREA"])
        self.LATITUDE = getFloat(data["LATITUDE"])
        self.LONGITUDE = getFloat(data["LONGITUDE"])
        self.TEN_MINUTE_SQUARE = getInteger(data["TEN_MINUTE_SQUARE"])
    }
}
