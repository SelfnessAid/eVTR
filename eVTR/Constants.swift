//
//  Constants.swift
//  Dolphin
//
//  Created by Derek Stock on 3/11/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import Foundation
import UIKit
import SCLAlertView

class Constants {
    
    static let ButtonCornorRadius: CGFloat          = 5.0
    
    struct NOAAAPIConfig {
        static let LoginRequest: String         = "https://www.greateratlantic.fisheries.noaa.gov/apps/fol/base_api_dev/"
    }
    
    struct Colors {
        static let FieldBorder: UIColor             = UIColor(red: 227.0/255.0, green: 227.0/255.0, blue: 227.0/255.0, alpha: 1.0)
        static let BluedBorder: UIColor             = UIColor(red: 22.0/255.0, green: 149.0/255.0, blue: 206.0/255.0, alpha: 1.0)
    }
    
    struct Messages {
        
        static let UnsupportedUserNameTitle: String     = "Could Not Send Email"
        static let UnsupportedUserName: String          = "Your device could not send e-mail.  Please check e-mail configuration and try again."
        static let UnsupportedSMSTitle: String          = "Could Not Send SMS"
        static let UnsupportedSMS: String               = "Your device could not send SMS.  Please check SMS configuration and try again."
        static let Error_Report: String                 = "Can't report this post."
        
        //Login & Sign up
        static let UsernameErrortitle: String           = "Username error"
        static let UsernameErrorMsg: String             = "Username empty"
        static let PasswordErrorTitle: String           = "Password error"
        static let PasswordErrorMsg: String             = "Password should be at least 5 characters long"
    }
    
    struct UserDefault {
        static let Defaults                         = NSUserDefaults.standardUserDefaults()
        static let RememberMe: String               = "RememberMe"
        static let UserName: String                 = "UserName"
        static let Password: String                 = "Password"
        static let Status : String                  = "Status"
        static let Token : String                   = "token"
        static let ClientId : String                = "client_id"
        static let OperatorKey : String             = "operator_key"
        static let GearTimeStamp : String           = "GearTimeStamp"
        static let ActivityTimeStamp : String       = "ActivityTimeStamp"
        static let ChartAreaTimeStamp : String      = "ChartAreaTimeStamp"
        static let OperatorsTimeStamp : String      = "OperatorsTimeStamp"
        static let PermitsTimeStamp : String        = "PermitsTimeStamp"
        static let SpeciesTimeStamp : String        = "SpeciesTimeStamp"
        static let DealersTimeStamp : String        = "DealersTimeStamp"
        static let TripTypesTimeStamp : String      = "TripTypesTimeStamp"

    }
    
    struct Fonts {
        static let Raleway_Regular: String          = "Raleway-Regular"
        static let Raleway_Bold: String             = "Raleway-Bold"
        static let OpenSans_Regular: String         = "OpenSans"
    }
    
    static let IndicatorSize: CGSize                = CGSize(width: 40, height: 40)
    
    static let User: NOAAUser                       = NOAAUser()
    
}



