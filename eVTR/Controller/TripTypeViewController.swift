//
//  TripTypeViewController.swift
//  eVTR
//
//  Created by Derek Stock on 7/22/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit
import SCLAlertView

class TripTypeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,TripTypeTableViewCellDelegate {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var selectedIndexPath: NSIndexPath!
    var crewNumber: NSString!
    var anglerNumber: NSString!
    var arrTripTypes: [String] = []
    
    var isSelectedParty = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.registerNib(UINib(nibName: "TripTypeTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TripTypeTableViewCell")
        mainTableView.registerNib(UINib(nibName: "TripCrewTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TripCrewTableViewCell")
        mainTableView.registerNib(UINib(nibName: "TripAnglerTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TripAnglerTableViewCell")
        
        // Keyboard Manager
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TripTypeViewController.keyboardDidShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TripTypeViewController.keyboardDidDisappear(_:)), name: UIKeyboardWillHideNotification, object: nil)

        startActivityAnimating(Constants.IndicatorSize, message: "Loading Data...", type: .BallRotateChase, color: UIColor.whiteColor(), padding: 0)
        // Load Permits from Core Data
        performSelector(#selector(loadTripTypesFromCoreData(_:)), withObject: nil, afterDelay: 0.5)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
   
    // MARK: - Load TripType From Core Data
    func loadTripTypesFromCoreData(sender: AnyObject) {
        let tripType = RequestManager.sharedManager.getTripTypesFromCoreData()
        
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: true
        )
        
        let alert = SCLAlertView(appearance: appearance)
        let alertViewIcon = UIImage(named: "alertViewIcon")

        if tripType?.count > 0 {
            for row in tripType! {
                if let value = row.value {
                    arrTripTypes.append(value)
                }
            }
            mainTableView.reloadData()
            self.stopActivityAnimating()
        } else {
            self.stopActivityAnimating()
            alert.showCustom("Oops!", subTitle: "There is no data for Trip Type.", color: Constants.Colors.BluedBorder, icon: alertViewIcon!, closeButtonTitle: "OK", duration: 3.0, colorStyle: 0xA429FF, colorTextButton: 0xFFFFFF, circleIconImage: alertViewIcon!, animationStyle: .TopToBottom)
        }
    }
    
    // MARK: - KeyboardManager.
    func keyboardDidShow(notification : NSNotification) {
        
        let info = notification.userInfo! as NSDictionary
        
        let aValue = info.objectForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        
        var keyboardRect = aValue.CGRectValue()
        
        keyboardRect = self.view.convertRect(keyboardRect, fromView: nil)
        
        let keyboardTop = keyboardRect.origin.y
        
        UIView.animateWithDuration(0.25) { 
            self.mainTableView.contentInset =  UIEdgeInsetsMake(0, 0, keyboardTop * 0.6, 0)
        }
    }
    
    func keyboardDidDisappear(notification : NSNotification) {
        
        UIView.animateWithDuration(0.25) {
            self.mainTableView.contentInset =  UIEdgeInsetsMake(10, 0, 10, 0)
        }
    }
    
    // MARK: - UIButtonAction.
    @IBAction func didTapNextStep(sender: AnyObject) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("TripReviewViewController")
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    // MARK: - UITableView Data Source.
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifiers = ["TripTypeTableViewCell", "TripCrewTableViewCell", "TripAnglerTableViewCell"]
        let cell = tableView.dequeueReusableCellWithIdentifier(identifiers[indexPath.section], forIndexPath: indexPath)
        
        switch indexPath.section {
        case 0:
            if arrTripTypes.count > 0 {
                let pickerTableViewCell = cell as! TripTypeTableViewCell
                pickerTableViewCell.items = arrTripTypes
                pickerTableViewCell.delegate = self
            }
            break
        case 1:
            let tripCrewCell = cell as! TripCrewTableViewCell
            tripCrewCell.crewNumberField.delegate = self
            tripCrewCell.crewNumberField.tag = 100
            break
        case 2:
            let tripAnglerCell = cell as! TripAnglerTableViewCell
            if !isSelectedParty {
                tripAnglerCell.backgroundColor = UIColor.grayColor()
                tripAnglerCell.userInteractionEnabled = false
            } else {
                tripAnglerCell.numberOfAnglersField.delegate = self
                tripAnglerCell.numberOfAnglersField.tag = 200
                tripAnglerCell.backgroundColor = UIColor.whiteColor()
                tripAnglerCell.userInteractionEnabled = true
            }
            break
        default:
            break
        }
        
        return cell
    }
    
    // MARK: - UITableView Delegate.
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIndexPath = indexPath
        mainTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 205
        }
        if indexPath.section == 1 {
            return 168
        }
        return 168
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    // MARK: - UITextField Delegate.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if selectedIndexPath != nil {
            if selectedIndexPath!.row == 1 || textField.tag == 100 {
                crewNumber = textField.text
            } else if selectedIndexPath!.row == 2 || textField.tag == 200 {
                anglerNumber = textField.text
            }
            mainTableView.reloadData()
        }

        return true
    }
    
    // MARK: - TripTypeTableViewCellDelegate.
    func didSelectedPickerRow(selectedRowValue: String) {
        if selectedRowValue == "Party" || selectedRowValue == "Charter" {
            isSelectedParty = true
        } else {
            isSelectedParty = false
        }
        mainTableView.reloadData()
    }
}


