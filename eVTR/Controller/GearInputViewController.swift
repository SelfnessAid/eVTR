//
//  GearInputViewController.swift
//  eVTR
//
//  Created by Derek Stock on 7/25/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit
import SCLAlertView

class GearInputViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var searchResultTableView: UITableView!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchResultView: UIView!

    var selectedIndexPath: NSIndexPath?
    
    var gearNameLabel: String?
    
    var arrGears: [GearEntity] = []
    var arrSearchResult: [GearEntity] = []
    
    var isSearch = false

    override func viewDidLoad() {
        super.viewDidLoad()

        startActivityAnimating(Constants.IndicatorSize, message: "Loading Data...", type: .BallRotateChase, color: UIColor.whiteColor(), padding: 0)

        self.initialViews()
        
        // Load Permits from Core Data
        performSelector(#selector(loadGearFromCoreData(_:)), withObject: nil, afterDelay: 0.5)
   }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Initial Views Stack.
    func initialViews() {
        // Do any additional setup after loading the view.
        mainTableView.registerNib(UINib(nibName: "AreaTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "AreaTableViewCell")
        searchResultTableView.registerNib(UINib(nibName: "VesselItemTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "VesselItemTableViewCell")
        
        NSNotificationCenter.defaultCenter() .addObserver(self, selector: #selector(GearInputViewController.keyboardDidShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GearInputViewController.keyboardDidDisappear(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        searchView.layer.masksToBounds = true
        searchView.layer.cornerRadius = Constants.ButtonCornorRadius
        searchResultTableView.layer.masksToBounds = true
        searchResultTableView.layer.cornerRadius = Constants.ButtonCornorRadius
    }
    
    // MARK: - Load Permits From Core Data
    func loadGearFromCoreData(sender: AnyObject) {
        let gears = RequestManager.sharedManager.getGearsFromCoreData()
        
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: true
        )
        
        let alert = SCLAlertView(appearance: appearance)
        let alertViewIcon = UIImage(named: "alertViewIcon")
        
        self.stopActivityAnimating()
        if gears?.count > 0 {
            arrGears = gears!
            searchResultTableView.reloadData()
        } else  {
            alert.showCustom("Oops!", subTitle: "There is no data for Gear Code.", color: Constants.Colors.BluedBorder, icon: alertViewIcon!, closeButtonTitle: "OK", duration: 3.0, colorStyle: 0xA429FF, colorTextButton: 0xFFFFFF, circleIconImage: alertViewIcon!, animationStyle: .TopToBottom)
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
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("CatchInputViewController")
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func didTapCancelSearchResult(sender: AnyObject) {
        searchResultView.hidden = true
        searchTextField.resignFirstResponder()
        searchTextField.text = ""
        arrSearchResult = arrGears
        selectedIndexPath = nil
        searchResultTableView.reloadData()
    }
    
    @IBAction func didTapResetSearchField(sender: AnyObject) {
        searchTextField.text = ""
        selectedIndexPath = nil
        arrSearchResult = arrGears
        searchResultTableView.reloadData()
    }
    
    @IBAction func didTapAddSelectedVessels(sender: AnyObject) {
        textFieldShouldReturn(searchTextField)
    }
    
    // MARK: UITableView Data Source.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 2 {
            if !isSearch {
                return arrGears.count
            } else {
                return arrSearchResult.count
            }
        }
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView.tag == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("AreaTableViewCell", forIndexPath: indexPath) as! AreaTableViewCell
            cell.valueField.delegate = self
            
            if indexPath.row == 0 {
                cell.titleLabel.text = "Gear Code"
                cell.valueField.placeholder = "Search by code or name"
                cell.valueField.text = gearNameLabel
                cell.valueField.tag = 100
            }
            else if indexPath.row == 1 {
                cell.titleLabel.text = "Gear Quantity"
                cell.valueField.returnKeyType = UIReturnKeyType.Next
                cell.valueField.tag = 200
            }
            else if indexPath.row == 2 {
                cell.titleLabel.text = "Gear Size"
                cell.valueField.returnKeyType = UIReturnKeyType.Next
                cell.valueField.tag = 300
            }
            else if indexPath.row == 3 {
                cell.titleLabel.text = "Mesh / Ring Size"
                cell.valueField.returnKeyType = UIReturnKeyType.Done
                cell.valueField.tag = 400
            }
            
            return cell
            
        } else {
            let searchTableViewCell = tableView.dequeueReusableCellWithIdentifier("VesselItemTableViewCell", forIndexPath: indexPath) as! VesselItemTableViewCell
            
            if arrGears.count > 0 && !isSearch {
                let gears = arrGears[indexPath.row]
                searchTableViewCell.vesselNumLabel.text = gears.code
                searchTableViewCell.vesselNameLabel.text = gears.name
            }
            if arrSearchResult.count > 0 && isSearch {
                let gears = arrSearchResult[indexPath.row]
                searchTableViewCell.vesselNumLabel.text = gears.code
                searchTableViewCell.vesselNameLabel.text = gears.name

                if selectedIndexPath != nil {
                    if gearNameLabel == gears.name {
                        searchTableViewCell.checkBoxImage.image = UIImage(named: "blueCheckButton")
                        let gearName = searchTableViewCell.vesselNumLabel.text! + ", " + searchTableViewCell.vesselNameLabel.text!
                        
                        searchTextField.text = gearName
                        gearNameLabel = gearName
                    } else {
                        searchTableViewCell.checkBoxImage.image = nil
                    }
                } else {
                    searchTableViewCell.checkBoxImage.image = nil
                }
            }
            
            return searchTableViewCell
        }
    }
    
    // MARK: - UITableView Delegate.
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if tableView.tag == 1 {
            return 95
        }
        return 44
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView.tag == 2 {
            selectedIndexPath = indexPath
            let gears: AnyObject
            if !isSearch {
                gears = arrGears[selectedIndexPath!.row]
            } else {
                gears = arrSearchResult[selectedIndexPath!.row]
            }
            gearNameLabel = gears.name
            isSearch = true
            self.arrSearchResult = self.filterContentForSearchText(gearNameLabel!, scope: "") as! [GearEntity]
            
            tableView .reloadData()
        }
    }
    
    // MARK: - UITextfield delegate.
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.tag == 100 {
            searchResultView.hidden = false
            searchTextField.becomeFirstResponder()
        }
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        selectedIndexPath = nil
        searchTextField.text = ""
        searchResultTableView.reloadData()

        if textField.tag == 100 {

            searchResultView.hidden = false
            searchTextField.becomeFirstResponder()
            let indexpath = NSIndexPath(forItem: (textField.tag / 100) - 1, inSection: 0)
            selectedIndexPath = indexpath
            searchResultTableView.reloadData()
        }
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        searchResultView.hidden = true
        
        if textField.tag == 500 {
            if selectedIndexPath != nil {
                if selectedIndexPath!.row == 0 || textField.tag == 100 {
                    gearNameLabel = searchTextField.text
                }
            }
            mainTableView.reloadData()
            searchResultTableView.reloadData()
        }
        return true
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let textFieldText: NSString = textField.text ?? ""
        let txtAfterUpdate = textFieldText.stringByReplacingCharactersInRange(range, withString: string)
        
        if txtAfterUpdate == "" {
            isSearch = false
            arrSearchResult = arrGears
        } else {
            isSearch = true
            self.arrSearchResult = self.filterContentForSearchText(txtAfterUpdate, scope: "") as! [GearEntity]
        }
        
        searchResultTableView.reloadData()
        
        return true
    }
    
    func filterContentForSearchText(searchText: String, scope: String) -> NSArray {
        let resultPredicate = NSPredicate(format: "name contains[c] %@ or code contains[c] %@",searchText, searchText)
        let searchResultArray = (arrGears as NSArray).filteredArrayUsingPredicate(resultPredicate)
        
        return searchResultArray
    }
    
}
