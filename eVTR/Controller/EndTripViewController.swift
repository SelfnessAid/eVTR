//
//  EndTripViewController.swift
//  eVTR
//
//  Created by Derek Stock on 7/28/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit

class EndTripViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var searchResultTableView: UITableView!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchResultView: UIView!
    @IBOutlet weak var searchViewTitle: UILabel!
    @IBOutlet weak var addSelectedButton: UIButton!
    
    @IBOutlet var footerView: UIView!
    @IBOutlet var headerLabel: UILabel!
    
    var tableViewWidth : CGFloat!
    
    var selectedIndexPath: NSIndexPath?
    var selectedSearchIndexPath: NSIndexPath?
    var speciesCode: String!
    var dealerName: String!
    var portCity: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.registerNib(UINib(nibName: "CheckBoxTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "CheckBoxTableViewCell")
        mainTableView.registerNib(UINib(nibName: "AreaTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "AreaTableViewCell")
        mainTableView.registerNib(UINib(nibName: "TripDateTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TripDateTableViewCell")
        mainTableView.registerNib(UINib(nibName: "PortCityTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "PortCityTableViewCell")
        searchResultTableView.registerNib(UINib(nibName: "VesselItemTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "VesselItemTableViewCell")
        
        mainTableView.tableHeaderView = headerLabel
        mainTableView.tableFooterView = footerView
        
        searchView.layer.masksToBounds = true
        searchView.layer.cornerRadius = Constants.ButtonCornorRadius
        searchResultTableView.layer.masksToBounds = true
        searchResultTableView.layer.cornerRadius = Constants.ButtonCornorRadius

        // Keyboard Manager
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EndTripViewController.keyboardDidShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EndTripViewController.keyboardDidDisappear(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableViewWidth = mainTableView.bounds.size.width
    }
    
    // MARK: - Keyboard Manager.
    func keyboardDidShow(notification: NSNotification) {

        let info = notification.userInfo! as NSDictionary
        let aValue = info.objectForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        var keyboardRect = aValue.CGRectValue()
        keyboardRect = self.view.convertRect(keyboardRect, fromView: nil)
        let keyboardTop = keyboardRect.origin.y
        
        UIView.animateWithDuration(0.25) {
            self.mainTableView.contentInset =  UIEdgeInsetsMake(0, 0, keyboardTop * 0.55, 0)
        }
    }
    
    func keyboardDidDisappear(notification: NSNotification) {
        
        UIView.animateWithDuration(0.25) {
            self.mainTableView.contentInset =  UIEdgeInsetsMake(10, 0, 10, 0)
        }
    }
    
    // MARK: - UIButtonAction.
    @IBAction func didTapNextStep(sender: AnyObject) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("EndTripReviewViewController")
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }

    @IBAction func didAddSale(sender: AnyObject) {
        didTapNextStep(self)
    }
    
    @IBAction func didTapCancelSearchResult(sender: AnyObject) {
        
        searchResultView.hidden = true
        searchTextField.resignFirstResponder()
        selectedSearchIndexPath = nil
        searchResultTableView.reloadData()
    }
    
    @IBAction func didTapResetSearchField(sender: AnyObject) {
        
        searchTextField.text = ""
    }
    
    @IBAction func didTapAddSelectedVessels(sender: AnyObject) {
        
        textFieldShouldReturn(searchTextField)
    }
    
    // MARK: - UITableView Data Source.
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        if tableView.tag == 1 {
            return 6
        }
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 1 {
            return 1
        }
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView.tag == 1 {
            
            let identifiers = ["CheckBoxTableViewCell", "AreaTableViewCell", "AreaTableViewCell", "PortCityTableViewCell", "TripDateTableViewCell",  "PortCityTableViewCell"]
            let cell = tableView.dequeueReusableCellWithIdentifier(identifiers[indexPath.section], forIndexPath: indexPath)
            
            if indexPath.section == 1 {
                let itemCell = cell as! AreaTableViewCell
                itemCell.titleLabel.text = "Species Code"
                itemCell.valueField.placeholder = "Search by name or code"
                itemCell.valueField.text = speciesCode
                itemCell.valueField.returnKeyType = UIReturnKeyType.Next
                itemCell.valueField.tag = 100
                itemCell.valueField.delegate = self
            } else if indexPath.section == 2 {
                let itemCell = cell as! AreaTableViewCell
                itemCell.titleLabel.text = "LB"
                itemCell.valueField.placeholder = "Enter poundage"
                itemCell.valueField.returnKeyType = UIReturnKeyType.Next
                itemCell.valueField.tag = 200
                itemCell.valueField.delegate = self
            } else if indexPath.section == 3 {                      // Dealer Search Cell //
                let itemCell = cell as! PortCityTableViewCell
                itemCell.titleLabel.text = "Dealer"
                itemCell.commentLabel.text = "Select a Dealer"
                itemCell.portCityField.placeholder = "Search by dealer name or Permit Number"
                itemCell.portCityField.text = dealerName
                itemCell.portCityField.tag = 300
                itemCell.portCityField.delegate = self
            } else if indexPath.section == 4 {
                let itemCell = cell as! TripDateTableViewCell
                itemCell.titleLabel.text = "Date Sold"
                itemCell.menuView.frame = CGRect(x: 0, y: 37, width: tableViewWidth, height: itemCell.menuView.bounds.size.height)
                itemCell.calendarView.frame = CGRect(x: 0, y: 67, width: tableViewWidth, height: itemCell.calendarView.bounds.size.height)
                itemCell.configure()
            } else if indexPath.section == 5 {                      // Port City and State Search Cell //
                let itemCell = cell as! PortCityTableViewCell
                itemCell.titleLabel.text = "Port City / State"
                itemCell.commentLabel.text = "Select a Port"
                itemCell.portCityField.text = "Search by Port City and State"
                itemCell.portCityField.text = portCity
                itemCell.portCityField.tag = 500
                itemCell.portCityField.delegate = self
            }
            
            return cell
        } else {
            
            let searchTableViewCell = tableView.dequeueReusableCellWithIdentifier("VesselItemTableViewCell", forIndexPath: indexPath) as! VesselItemTableViewCell
            
            if selectedSearchIndexPath != nil {
                if indexPath.row == selectedSearchIndexPath!.row {
                    searchTableViewCell.checkBoxImage.image = UIImage(named: "blueCheckButton")
                    let vesselName = searchTableViewCell.vesselNumLabel.text! + ", " + searchTableViewCell.vesselNameLabel.text!
                    
                    searchTextField.text = vesselName
                } else {
                    searchTableViewCell.checkBoxImage.image = nil
                }
            } else {
                searchTableViewCell.checkBoxImage.image = nil
            }
            
            return searchTableViewCell
        }
    }
    
    // MARK: - UITableView Delegate.
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if tableView.tag == 1 {
            if indexPath.section == 0 {
                return 44
            } else if indexPath.section == 1 {
                return 95
            } else if indexPath.section == 2 {
                return 95
            } else if indexPath.section == 3 {
                return 230
            } else if indexPath.section == 4 {
                return 290
            }
            
            return 230
        }
        return 44
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if tableView.tag == 2 {
            selectedSearchIndexPath = indexPath
            tableView .reloadData()
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.01
    }
    
    // MARK: - UITextfield delegate.
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        selectedSearchIndexPath = nil
        searchResultTableView.reloadData()
        
        if textField.tag == 100 {
            let indexpath = NSIndexPath(forItem: (textField.tag / 100), inSection: 1)
            selectedIndexPath = indexpath
            searchResultView.hidden = false
            searchViewTitle.text = "Species Code Search"
            searchTextField.placeholder = "Search by Name or Code"
            searchTextField.text = speciesCode
            searchTextField.becomeFirstResponder()
        }
        if textField.tag == 300 {
            let indexpath = NSIndexPath(forItem: (textField.tag / 100), inSection: 3)
            selectedIndexPath = indexpath
            searchResultView.hidden = false
            searchViewTitle.text = "Dealer Search"
            searchTextField.placeholder = "Search by Dealer Name or Permit Number"
            searchTextField.text = dealerName
            searchTextField.becomeFirstResponder()
        }
        if textField.tag == 500 {
            let indexpath = NSIndexPath(forItem: (textField.tag / 100), inSection: 5)
            selectedIndexPath = indexpath
            searchResultView.hidden = false
            searchViewTitle.text = "Port Search"
            searchTextField.placeholder = "Search by Port City or State"
            searchTextField.text = portCity
            searchTextField.becomeFirstResponder()
        }

        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if textField.tag == 100 || textField.tag == 300 || textField.tag == 500 {
            searchResultView.hidden = false
            searchTextField.becomeFirstResponder()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        if textField.tag == 1000 {
            if selectedIndexPath != nil {
                if selectedIndexPath!.section == 1 || textField.tag == 100 {
                    speciesCode = searchTextField.text
                }
                if selectedIndexPath!.section == 3 || textField.tag == 300 {
                    dealerName = searchTextField.text
                }
                if selectedIndexPath!.section == 5 || textField.tag == 500 {
                    portCity = searchTextField.text
                }
            }
            searchResultView.hidden = true
            selectedSearchIndexPath = nil
            mainTableView.reloadData()
            searchResultTableView.reloadData()
        }
        return true
    }
    
}


