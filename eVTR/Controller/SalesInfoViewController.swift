//
//  SalesInfoViewController.swift
//  eVTR
//
//  Created by Derek Stock on 8/2/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit

class SalesInfoViewController: BaseViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var searchResultTableView: UITableView!

    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchResultView: UIView!
    @IBOutlet weak var searchViewTitle: UILabel!
    @IBOutlet weak var addSelectedButton: UIButton!
    
    @IBOutlet var headerLabel: UILabel!
    
    var tableViewWidth : CGFloat!
    
    var selectedIndexPath: NSIndexPath?
    var selectedSearchIndexPath: NSIndexPath?
    var dealerName: String!
    var portCity: String!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mainTableView.registerNib(UINib(nibName: "CheckBoxTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "CheckBoxTableViewCell")
        mainTableView.registerNib(UINib(nibName: "EndTripDealerTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "EndTripDealerTableViewCell")
        mainTableView.registerNib(UINib(nibName: "TripDateTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TripDateTableViewCell")
        mainTableView.registerNib(UINib(nibName: "PortCityTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "PortCityTableViewCell")
        searchResultTableView.registerNib(UINib(nibName: "VesselItemTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "VesselItemTableViewCell")
       
        mainTableView.tableHeaderView = headerLabel
        
        searchView.layer.masksToBounds = true
        searchView.layer.cornerRadius = Constants.ButtonCornorRadius
        searchResultTableView.layer.masksToBounds = true
        searchResultTableView.layer.cornerRadius = Constants.ButtonCornorRadius
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableViewWidth = mainTableView.bounds.size.width
    }
    
    // MARK: - UIButtonAction.
    @IBAction func didTapNextStep(sender: AnyObject) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("EndTripViewController")
        self.navigationController?.pushViewController(nextViewController, animated: true)
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
            return 4
        }
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 1 {
            return 1
        }
        return 8
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView.tag == 1 {
            
            let identifiers = ["CheckBoxTableViewCell", "EndTripDealerTableViewCell", "TripDateTableViewCell", "PortCityTableViewCell"]
            let cell = tableView.dequeueReusableCellWithIdentifier(identifiers[indexPath.section], forIndexPath: indexPath)
            
            if indexPath.section == 1 {                             // Dealer Search Cell //
                let itemCell = cell as! EndTripDealerTableViewCell
                itemCell.valueField.text = dealerName
                itemCell.valueField.tag = 100
                itemCell.valueField.delegate = self
            } else if indexPath.section == 2 {                      // Date Sold Cell //
                let itemCell = cell as! TripDateTableViewCell
                itemCell.titleLabel.text = "Date Landed"
                itemCell.menuView.frame = CGRect(x: 0, y: 37, width: tableViewWidth, height: itemCell.menuView.bounds.size.height)
                itemCell.calendarView.frame = CGRect(x: 0, y: 67, width: tableViewWidth, height: itemCell.calendarView.bounds.size.height)
                itemCell.configure()
            } else if indexPath.section == 3 {                      // Port City and State Search Cell //
                let itemCell = cell as! PortCityTableViewCell
                itemCell.portCityField.text = portCity
                itemCell.commentLabel.text = "Slect a Port"
                itemCell.portCityField.tag = 200
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
                return 230
            } else if indexPath.section == 2 {
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
            searchViewTitle.text = "Dealer Search"
            searchTextField.placeholder = "Search by Dealer Name or Permit Number"
            searchTextField.text = dealerName
            searchTextField.becomeFirstResponder()
        } else if textField.tag == 200 {
            let indexpath = NSIndexPath(forItem: (textField.tag / 100), inSection: 3)
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
        
        if textField.tag == 100 || textField.tag == 200 {
            searchResultView.hidden = false
            searchTextField.becomeFirstResponder()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        if textField.tag == 1000 {
            if selectedIndexPath != nil {
                if selectedIndexPath!.section == 1 || textField.tag == 100 {
                    dealerName = searchTextField.text
                }
                if selectedIndexPath!.section == 3 || textField.tag == 200 {
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

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
