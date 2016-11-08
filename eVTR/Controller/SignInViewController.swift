//
//  SignInViewController.swift
//  eVTR
//
//  Created by Derek Stock on 7/21/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit
import Alamofire
import SCLAlertView

class SignInViewController: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberButton: UIButton!
    
    var isRemember: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        usernameView.layer.masksToBounds = true
        usernameView.layer.cornerRadius = Constants.ButtonCornorRadius
        usernameView.layer.borderWidth = 0.5
        usernameView.layer.borderColor = UIColor.whiteColor().CGColor
        
        passwordView.layer.masksToBounds = true
        passwordView.layer.cornerRadius = Constants.ButtonCornorRadius
        passwordView.layer.borderWidth = 0.5
        passwordView.layer.borderColor = UIColor.whiteColor().CGColor
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UIButton Action.
    @IBAction func didTapRememberMe(sender: AnyObject) {
        isRemember = !isRemember
        if isRemember == true {
            rememberButton.setImage(UIImage(named: "checkmark"), forState: .Normal)
        } else {
            rememberButton.setImage(UIImage(named: "checkmark_none"), forState: .Normal)
        }
    }
    
    // MARK: - Remember User Info in NSUserDefaults
    func rememberUserInfo(isRemember: Bool) {

        Constants.UserDefault.Defaults.setBool(isRemember, forKey: Constants.UserDefault.RememberMe)
    }
    
    // MARK: - Login stack.
    @IBAction func didTapSignIn(sender: AnyObject) {
        let userName = usernameTextField.text
        let password = passwordTextField.text
        
        if isRemember {
            rememberUserInfo(true)
            Constants.UserDefault.Defaults.setObject(usernameTextField.text, forKey: Constants.UserDefault.UserName)
            Constants.UserDefault.Defaults.setObject(passwordTextField.text, forKey: Constants.UserDefault.Password)
        } else {
            rememberUserInfo(false)
        }
        
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: true
        )
        
        let alert = SCLAlertView(appearance: appearance)
        let alertViewIcon = UIImage(named: "alertViewIcon")

        if userName != "" && password != "" && userName != nil && password != nil {

            let timeStamp = 0
            let params = [
                "authorization" : [
                    "username" : userName!,
                    "password" : password!
                ],
                "download_timestamps" : [
                    "Activity"  : timeStamp,
                    "ChartArea" : timeStamp,
                    "Dealers"   : timeStamp,
                    "Gear"      : timeStamp,
                    "Operators" : timeStamp,
                    "Permits"   : timeStamp,
                    "Species"   : timeStamp,
                    "TripTypes" : timeStamp
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
                            // Set User Info
                            self.setUserInfo(result!)
                            
                            // Go to HomeScreen
                            self.gotoHomeScreen()
                        }
                    }
                } else {
                    print (error!.localizedDescription)

                    // Go to HomeScreen
                    self.gotoHomeScreen()
                }
            })
        } else {
            alert.showCustom("Oops!", subTitle: "Username or Password Empty.", color: Constants.Colors.BluedBorder, icon: alertViewIcon!, closeButtonTitle: "OK", duration: 3.0, colorStyle: 0xA429FF, colorTextButton: 0xFFFFFF, circleIconImage: alertViewIcon!, animationStyle: .TopToBottom)
        }
    }
    
    @IBAction func didTapForgetPassword(sender: AnyObject) {
        
    }
    
    // MARK: - Go to HomeScreen
    func gotoHomeScreen() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("HomeViewController")
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    // MARK: - Set User Info
    func setUserInfo(data: AnyObject) {
        
        let token = data.objectForKey("token") as? String
        let status = data.objectForKey("Status") as? String
        let client_id = data.objectForKey("client_id") as? String
        let operator_key = data.objectForKey("operator_key") as? String
        
        Constants.User.token        = token
        Constants.User.status       = status
        Constants.User.client_id    = client_id
        Constants.User.operator_key = operator_key
        
        // Set User Info in NSUserDefault
        Constants.UserDefault.Defaults .setObject(token, forKey: Constants.UserDefault.Token)
        Constants.UserDefault.Defaults .setObject(status, forKey: Constants.UserDefault.Status)
        Constants.UserDefault.Defaults .setObject(client_id, forKey: Constants.UserDefault.ClientId)
        Constants.UserDefault.Defaults .setObject(operator_key, forKey: Constants.UserDefault.OperatorKey)
        
        print("Current User Token ===== \(Constants.User.token) \n Current User Status ====== \(Constants.User.status) \n Current User ClientID ==== \(Constants.User.client_id)")
    }
    
    // MARK: Check Value.
    func checkValidUserName() -> Bool {
        return true
    }
    
    func checkValidPassword() -> Bool {
        return true
    }
    
    // MARK: UITextField Delegate.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
            didTapSignIn(self)
        }
        return true
    }
}





