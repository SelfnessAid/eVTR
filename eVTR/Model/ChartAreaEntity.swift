//
//  ChartAreaEntity.swift
//  eVTR
//
//  Created by Derek Stock  on 8/25/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit

class ChartAreaEntity: BaseManagedObject {

    @NSManaged var latitude: Int16
    @NSManaged var longitude: Int16
    @NSManaged var tem_minute_square: Int16
    @NSManaged var area: Int16
    
    static let entityName = "ChartArea"
    
    func setData(data: [String: AnyObject]) -> Void {
        latitude                = getInteger(data["LATITUDE"])
        longitude               = getInteger(data["LONGITUDE"])
        tem_minute_square       = getInteger(data["TEN_MINUTE_SQUARE"])
        area                    = getInteger(data["AREA"])
    }
}
