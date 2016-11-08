//
//  NOAAUser.swift
//  eVTR
//
//  Created by Derek Stock on 8/9/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit

class NOAAUser: NSObject {

    var client_id: String?
    var operator_key: String?
    var status: String?
    var token: String?
    var vtr_preferences: String?
    
    convenience init(client_id: String?, operator_key: String?, status: String?, token: String?, vtr_preferences: String?) {
        self.init()
        self.client_id              = client_id
        self.operator_key           = operator_key
        self.status                 = status
        self.token                  = token
        self.vtr_preferences        = vtr_preferences
    }
    
}
