//
//  AreaInputViewController.swift
//  eVTR
//
//  Created by Derek Stock on 7/22/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit
import SCLAlertView

class AreaInputViewController: BaseViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var searchResultTableView: UITableView!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchResultView: UIView!
    
    var selectedIndexPath: NSIndexPath?
    var selectedSearchIndexPath: NSIndexPath?
    
    var chartArea: String!
    var latitude: String!
    var longitude: String!
    var numberOfHauls: String!
    var towSoak: String!
    var fishingDebth: String!
    
    var arrChartArea: [ChartAreaEntity] = []
    var arrSearchResult: [ChartAreaEntity] = []

    var isSearch = false

    override func viewDidLoad() {
        super.viewDidLoad()

        startActivityAnimating(Constants.IndicatorSize, message: "Loading Data...", type: .BallRotateChase, color: UIColor.whiteColor(), padding: 0)
        
        self.initialViews()
        
        // Load Permits from Core Data
        performSelector(#selector(loadChartAreaFromCoreData(_:)), withObject: nil, afterDelay: 0.5)
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
        
        // Keyboard Manager
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AreaInputViewController.keyboardDidShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AreaInputViewController.keyboardDidDisappear(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        searchView.layer.masksToBounds = true
        searchView.layer.cornerRadius = Constants.ButtonCornorRadius
        searchResultTableView.layer.masksToBounds = true
        searchResultTableView.layer.cornerRadius = Constants.ButtonCornorRadius
    }

    // MARK: - Load Permits From Core Data
    func loadChartAreaFromCoreData(sender: AnyObject) {
        let chartArea = RequestManager.sharedManager.getChartAreaFromCoreData()
        
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: true
        )
        
        let alert = SCLAlertView(appearance: appearance)
        let alertViewIcon = UIImage(named: "alertViewIcon")
        
        self.stopActivityAnimating()
        if chartArea?.count > 0 {
            arrChartArea = chartArea!
            searchResultTableView.reloadData()
        } else  {
            alert.showCustom("Oops!", subTitle: "There is no data for Chart Area.", color: Constants.Colors.BluedBorder, icon: alertViewIcon!, closeButtonTitle: "OK", duration: 3.0, colorStyle: 0xA429FF, colorTextButton: 0xFFFFFF, circleIconImage: alertViewIcon!, animationStyle: .TopToBottom)
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
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("GearInputViewController")
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
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 2 {
            if !isSearch {
                return arrChartArea.count
            } else {
                return arrSearchResult.count
            }
        }
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if tableView.tag == 1 {

            // MainTableViewCell
            
            let cell = tableView.dequeueReusableCellWithIdentifier("AreaTableViewCell", forIndexPath: indexPath) as! AreaTableViewCell
            cell.valueField.delegate = self
            
            if indexPath.row == 0 {
                cell.titleLabel.text = "Chart Area"
                cell.valueField.placeholder = "Search by number"
                cell.valueField.text = chartArea
                
                cell.valueField.tag = 100
            }
            else if indexPath.row == 1 {
                cell.titleLabel.text = "Latitude"
                cell.valueField.placeholder = "dd.dddd"
                cell.valueField.text = latitude
                cell.valueField.keyboardType = .NumbersAndPunctuation
                cell.valueField.returnKeyType = UIReturnKeyType.Next
                
                cell.valueField.tag = 200
            }
            else if indexPath.row == 2 {
                cell.titleLabel.text = "Longitude"
                cell.valueField.placeholder = "dd.dddd"
                cell.valueField.text = longitude
                cell.valueField.keyboardType = .NumbersAndPunctuation
                cell.valueField.returnKeyType = UIReturnKeyType.Next
                
                cell.valueField.tag = 300
            }
            else if indexPath.row == 3 {
                cell.titleLabel.text = "Number of Hauls"
                cell.valueField.placeholder = "Number"
                cell.valueField.text = numberOfHauls
                cell.valueField.keyboardType = .NumbersAndPunctuation
                cell.valueField.returnKeyType = UIReturnKeyType.Next
                
                cell.valueField.tag = 400
            }
            else if indexPath.row == 4 {
                cell.titleLabel.text = "Tow/ Soak Time"
                cell.valueField.placeholder = "hh:mm"
                cell.valueField.text = towSoak
                cell.valueField.keyboardType = .NumbersAndPunctuation
                cell.valueField.returnKeyType = UIReturnKeyType.Next
                
                cell.valueField.tag = 500
            }
            else if indexPath.row == 5 {
                cell.titleLabel.text = "Fishing Debth"
                cell.valueField.placeholder = "Number"
                cell.valueField.text = fishingDebth
                cell.valueField.keyboardType = .NumbersAndPunctuation
                cell.valueField.returnKeyType = UIReturnKeyType.Done
                
                cell.valueField.tag = 600
            }
            
            return cell
        } else {
            
            // SearchTableViewCell
            
            let searchTableViewCell = tableView.dequeueReusableCellWithIdentifier("VesselItemTableViewCell", forIndexPath: indexPath) as! VesselItemTableViewCell
            
            if arrChartArea.count > 0 && !isSearch {
                
            }
            if arrSearchResult.count > 0 && isSearch {
                
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
            selectedSearchIndexPath = indexPath
            tableView .reloadData()
        }
    }

    // MARK: - UITextfield delegate.
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        selectedSearchIndexPath = nil
        searchResultTableView.reloadData()

        if textField.tag == 100 {

            searchResultView.hidden = false
            searchTextField.becomeFirstResponder()
            let indexpath = NSIndexPath(forItem: (textField.tag / 100) - 1, inSection: 0)
            selectedIndexPath = indexpath
            searchTextField.text = chartArea
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
        
        if textField.tag == 700 {
            if selectedIndexPath != nil {
                if selectedIndexPath!.row == 0 || textField.tag == 100 {
                    chartArea = searchTextField.text
                }
            }
            selectedSearchIndexPath = nil
            mainTableView.reloadData()
            searchResultTableView.reloadData()
        }
        return true
    }
}






