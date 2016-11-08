//
//  SplashViewController.swift
//  eVTR
//
//  Created by Derek Stock on 8/17/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit
import Alamofire
import SCLAlertView

class SplashViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        gotoHomeScreen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Changing Status Bar
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        //LightContent
        return UIStatusBarStyle.LightContent
        
    }
    
    // MARK: - Checking Login Status
    func gotoHomeScreen() {

        let isRemember = Constants.UserDefault.Defaults.objectForKey(Constants.UserDefault.RememberMe) as? Bool
        
        if (isRemember == true) {
            
            signIn()
        } else {
            performSegueWithIdentifier("gotoLogin", sender: self)
        }
    }

    // MARK: - Go to the Home Screen
    func signIn() {
        let userName = Constants.UserDefault.Defaults.objectForKey(Constants.UserDefault.UserName)
        let password = Constants.UserDefault.Defaults.objectForKey(Constants.UserDefault.Password)
/*        
        let token = Constants.UserDefault.Defaults.objectForKey(Constants.UserDefault.Token)
        let status = Constants.UserDefault.Defaults.objectForKey(Constants.UserDefault.Status)
        let client_id = Constants.UserDefault.Defaults.objectForKey(Constants.UserDefault.ClientId)
*/
        print(userName)
        
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: true
        )
        
        let alert = SCLAlertView(appearance: appearance)
        let alertViewIcon = UIImage(named: "alertViewIcon")
        
        if userName != nil && password != nil {
            let currentTimeInterval = NSDate().timeIntervalSince1970
            var gearTimeInterval: Double
            var activityTimeInterval: Double
            var chartAreaTimeInterval: Double
            var dealersTimeInterval: Double
            var operatorsTimeInterval: Double
            var permitsTimeInterval: Double
            var speciesTimeInterval: Double
            var tripTypesTimeInterval: Double
            
            if Constants.UserDefault.Defaults.objectForKey(Constants.UserDefault.GearTimeStamp) != nil {
                gearTimeInterval = Constants.UserDefault.Defaults.doubleForKey(Constants.UserDefault.GearTimeStamp)
            } else {
                gearTimeInterval = currentTimeInterval
            }
            if Constants.UserDefault.Defaults.objectForKey(Constants.UserDefault.ActivityTimeStamp) != nil {
                activityTimeInterval = Constants.UserDefault.Defaults.doubleForKey(Constants.UserDefault.ActivityTimeStamp)
            } else {
                activityTimeInterval = currentTimeInterval
            }
            if Constants.UserDefault.Defaults.objectForKey(Constants.UserDefault.ChartAreaTimeStamp) != nil {
                chartAreaTimeInterval = Constants.UserDefault.Defaults.doubleForKey(Constants.UserDefault.ChartAreaTimeStamp)
            } else {
                chartAreaTimeInterval = currentTimeInterval
            }
            if Constants.UserDefault.Defaults.objectForKey(Constants.UserDefault.DealersTimeStamp) != nil {
                dealersTimeInterval = Constants.UserDefault.Defaults.doubleForKey(Constants.UserDefault.DealersTimeStamp)
            } else {
                dealersTimeInterval = currentTimeInterval
            }
            if Constants.UserDefault.Defaults.objectForKey(Constants.UserDefault.OperatorsTimeStamp) != nil {
                operatorsTimeInterval = Constants.UserDefault.Defaults.doubleForKey(Constants.UserDefault.OperatorsTimeStamp)
            } else {
                operatorsTimeInterval = currentTimeInterval
            }
            if Constants.UserDefault.Defaults.objectForKey(Constants.UserDefault.PermitsTimeStamp) != nil {
                permitsTimeInterval = Constants.UserDefault.Defaults.doubleForKey(Constants.UserDefault.PermitsTimeStamp)
            } else {
                permitsTimeInterval = currentTimeInterval
            }
            if Constants.UserDefault.Defaults.objectForKey(Constants.UserDefault.SpeciesTimeStamp) != nil {
                speciesTimeInterval = Constants.UserDefault.Defaults.doubleForKey(Constants.UserDefault.SpeciesTimeStamp)
            } else {
                speciesTimeInterval = currentTimeInterval
            }
            if Constants.UserDefault.Defaults.objectForKey(Constants.UserDefault.TripTypesTimeStamp) != nil {
                tripTypesTimeInterval = Constants.UserDefault.Defaults.doubleForKey(Constants.UserDefault.TripTypesTimeStamp)
            } else {
                tripTypesTimeInterval = currentTimeInterval
            }
            
            let params = [
                "authorization" : [
                    "username" : userName!,
                    "password" : password!
                ],
                "download_timestamps" : [
                    "Activity"  : activityTimeInterval,
                    "ChartArea" : chartAreaTimeInterval,
                    "Dealers"   : dealersTimeInterval,
                    "Gear"      : gearTimeInterval,
                    "Operators" : operatorsTimeInterval,
                    "Permits"   : permitsTimeInterval,
                    "Species"   : speciesTimeInterval,
                    "TripTypes" : tripTypesTimeInterval
                ]
            ]
            print(params)
            
            startActivityAnimating(Constants.IndicatorSize, message: nil, type: .BallRotateChase, color: UIColor.whiteColor(), padding: 0)
            let requestManger = RequestManager.sharedManager
            requestManger.loginRequest(params, complete: { (result: [String : AnyObject]?, error: NSError?) in
                
                self.stopActivityAnimating()
                if error == nil {
                    if result != nil {

                        let code = result!["Status"]
                        if code!.isEqualToString("Logged Out") {
                            alert.showCustom("Oops!", subTitle: "Username or Password is incorrect.", color: Constants.Colors.BluedBorder, icon: alertViewIcon!, closeButtonTitle: "OK", duration: 3.0, colorStyle: 0xA429FF, colorTextButton: 0xFFFFFF, circleIconImage: alertViewIcon!, animationStyle: .TopToBottom)
                        } else {
                            let token = result!["token"] as? String
                            Constants.User.token        = token
                            Constants.User.status       = result!["Status"] as? String
                            Constants.User.client_id    = result!["client_id"] as? String
                            
                            print("Current User Token ===== \(Constants.User.token) \n Current User Status ====== \(Constants.User.status) \n Current User ClientID ==== \(Constants.User.client_id)")
                            
                            // Go to HomeScreen
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("HomeViewController")
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                        }
                    }
                } else {
                    print (error!.localizedDescription)
                    
                    // Go to HomeScreen
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("HomeViewController")
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
            })
        } else {
            alert.showCustom("Oops!", subTitle: "Can't load Data from server.", color: Constants.Colors.BluedBorder, icon: alertViewIcon!, closeButtonTitle: "OK", duration: 3.0, colorStyle: 0xA429FF, colorTextButton: 0xFFFFFF, circleIconImage: alertViewIcon!, animationStyle: .TopToBottom)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
