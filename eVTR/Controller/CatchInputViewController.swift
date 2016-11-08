//
//  CatchInputViewController.swift
//  eVTR
//
//  Created by Derek Stock on 7/25/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit
import SCLAlertView

class CatchInputViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var searchResultTableView: UITableView!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchResultView: UIView!
    
    var selectedIndexPath: NSIndexPath?
    
    var speciesCode: String!
    
    var arrSpecies: [SpeciesEntity] = []
    var arrSearchResult: [SpeciesEntity] = []
    
    var isSearch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startActivityAnimating(Constants.IndicatorSize, message: "Loading Data...", type: .BallRotateChase, color: UIColor.whiteColor(), padding: 0)
        
        self.initialViews()
        
        // Load Permits from Core Data
        performSelector(#selector(loadSpeciesFromCoreData(_:)), withObject: nil, afterDelay: 0.5)
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
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CatchInputViewController.keyboardDidShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CatchInputViewController.keyboardDidDisappear(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        searchView.layer.masksToBounds = true
        searchView.layer.cornerRadius = Constants.ButtonCornorRadius
        searchResultTableView.layer.masksToBounds = true
        searchResultTableView.layer.cornerRadius = Constants.ButtonCornorRadius
    }
    
    // MARK: - Load Permits From Core Data
    func loadSpeciesFromCoreData(sender: AnyObject) {
        let species = RequestManager.sharedManager.getSpeciesFromCoreData()
        
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: true
        )
        
        let alert = SCLAlertView(appearance: appearance)
        let alertViewIcon = UIImage(named: "alertViewIcon")
        
        self.stopActivityAnimating()
        if species?.count > 0 {
            arrSpecies = species!
            searchResultTableView.reloadData()
        } else  {
            alert.showCustom("Oops!", subTitle: "There is no data for Species Code.", color: Constants.Colors.BluedBorder, icon: alertViewIcon!, closeButtonTitle: "OK", duration: 3.0, colorStyle: 0xA429FF, colorTextButton: 0xFFFFFF, circleIconImage: alertViewIcon!, animationStyle: .TopToBottom)
        }
    }
    
    // MARK: - KeyboardManager
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
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("EffortReviewViewController")
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func didTapCancelSearchResult(sender: AnyObject) {
        searchResultView.hidden = true
        searchTextField.resignFirstResponder()
        searchTextField.text = ""
        arrSearchResult = arrSpecies
        selectedIndexPath = nil
        searchResultTableView.reloadData()
    }
    
    @IBAction func didTapResetSearchField(sender: AnyObject) {
        searchTextField.text = ""
        selectedIndexPath = nil
        arrSearchResult = arrSpecies
        searchResultTableView.reloadData()
    }
    
    @IBAction func didTapAddSelectedVessels(sender: AnyObject) {
        textFieldShouldReturn(searchTextField)
    }

    // MARK: - UITableView Data Source.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 2 {
            if !isSearch {
                return arrSpecies.count
            } else {
                return arrSearchResult.count
            }
        }
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if tableView.tag == 1 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("AreaTableViewCell", forIndexPath: indexPath) as! AreaTableViewCell
            cell.valueField.delegate = self

            if indexPath.row == 0 {
                cell.titleLabel.text = "Species Code"
                cell.valueField.placeholder = "Search by name or code"
                cell.valueField.returnKeyType = UIReturnKeyType.Next
                cell.valueField.text = speciesCode
                cell.valueField.tag = 100
            }
            else if indexPath.row == 1 {
                cell.titleLabel.text = "Kept"
                cell.valueField.placeholder = "Enter LB"
                cell.valueField.returnKeyType = UIReturnKeyType.Next
                cell.valueField.tag = 200
            }
            else if indexPath.row == 2 {
                cell.titleLabel.text = "Discarded"
                cell.valueField.placeholder = "Enter LB"
                cell.valueField.returnKeyType = UIReturnKeyType.Done
                cell.valueField.tag = 300
            }

            return cell
            
        } else {
            
            let searchTableViewCell = tableView.dequeueReusableCellWithIdentifier("VesselItemTableViewCell", forIndexPath: indexPath) as! VesselItemTableViewCell
            
            if arrSpecies.count > 0 && !isSearch {
                let species = arrSpecies[indexPath.row]
                searchTableViewCell.vesselNumLabel.text = species.code
                searchTableViewCell.vesselNameLabel.text = species.name
            }
            if arrSearchResult.count > 0 && isSearch {
                let species = arrSearchResult[indexPath.row]
                searchTableViewCell.vesselNumLabel.text = species.code
                searchTableViewCell.vesselNameLabel.text = species.name
                
                if selectedIndexPath != nil {
                    if speciesCode == species.name {
                        searchTableViewCell.checkBoxImage.image = UIImage(named: "blueCheckButton")
                        let speciesName = searchTableViewCell.vesselNumLabel.text! + ", " + searchTableViewCell.vesselNameLabel.text!
                        
                        searchTextField.text = speciesName
                        speciesCode = speciesName
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
            let species: AnyObject
            if !isSearch {
                species = arrSpecies[selectedIndexPath!.row]
            } else {
                species = arrSearchResult[selectedIndexPath!.row]
            }
            speciesCode = species.name
            isSearch = true
            self.arrSearchResult = self.filterContentForSearchText(speciesCode!, scope: "") as! [SpeciesEntity]
            
            tableView .reloadData()
        }
    }
    
    // MARK: - UITextfield delegate.
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {

        selectedIndexPath = nil
        searchTextField.text = ""
        searchResultTableView.reloadData()

        if textField.tag == 100 {

            searchResultView.hidden = false
            searchTextField.becomeFirstResponder()
            let indexpath = NSIndexPath(forItem: (textField.tag / 100) - 1, inSection: 0)
            selectedIndexPath = indexpath
            searchTextField.text = speciesCode
        }
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if textField.tag == 100 {
            searchResultView.hidden = false
            searchTextField.becomeFirstResponder()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        searchResultView.hidden = true
        
        if textField.tag == 500 {
            if selectedIndexPath != nil {
                if selectedIndexPath!.row == 0 || textField.tag == 100 {
                    speciesCode = searchTextField.text
                }
            }
            mainTableView.reloadData()
            searchResultTableView.reloadData()
        }
        return true
    }

    func filterContentForSearchText(searchText: String, scope: String) -> NSArray {
        let resultPredicate = NSPredicate(format: "code contains[c] %@ or name contains[c] %@",searchText, searchText)
        let searchResultArray = (arrSpecies as NSArray).filteredArrayUsingPredicate(resultPredicate)
        
        return searchResultArray
    }
    
}

