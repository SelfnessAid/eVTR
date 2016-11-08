//
//  SelectVesselViewController.swift
//  eVTR
//
//  Created by Derek Stock on 7/21/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit
import SCLAlertView

class SelectVesselViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var vesselCollectView: UICollectionView!
    @IBOutlet weak var searchResultView: UIView!
    @IBOutlet weak var searchResultTableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var noHistorLabel: UILabel!
    
    var arrVessel:                      [PermitsEntity] = []
    var arrVesselSearchResult:          [PermitsEntity] = []
    var arrVesselHistory:               [PermitsEntity] = []
    
    var arrSelectedIndexPath = NSMutableArray()
    
    var vesselNameLabel: String?
    var permits: PermitsEntity!

    var isSearch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startActivityAnimating(Constants.IndicatorSize, message: "Loading Data...", type: .BallRotateChase, color: UIColor.whiteColor(), padding: 0)

        self.initialViews()
        
        // Load Permits from Core Data
        performSelector(#selector(loadPermitsFromCoreData(_:)), withObject: nil, afterDelay: 0.5)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Initial Views Stack.
    func initialViews() {
        // Do any additional setup after loading the view.
        vesselCollectView.registerNib(UINib(nibName: "VesselCollectionViewCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "VesselCollectionViewCell")
        
        searchView.layer.masksToBounds = true
        searchView.layer.cornerRadius = Constants.ButtonCornorRadius
        searchView.layer.borderWidth = 0.5
        searchView.layer.borderColor = Constants.Colors.FieldBorder.CGColor
        searchView.backgroundColor = UIColor.whiteColor()
        
        searchResultTableView.layer.masksToBounds = true
        searchResultTableView.layer.cornerRadius = Constants.ButtonCornorRadius
        
        searchResultTableView.registerNib(UINib(nibName: "VesselItemTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "VesselItemTableViewCell")
    }
    
    // MARK: - Load Permits From Core Data
    func loadPermitsFromCoreData(sender: AnyObject) {
        let permits = RequestManager.sharedManager.getPermitsFromCoreData()
        
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: true
        )
        
        let alert = SCLAlertView(appearance: appearance)
        let alertViewIcon = UIImage(named: "alertViewIcon")
        
        self.stopActivityAnimating()
        if permits?.count > 0 {
            arrVessel = permits!
            if arrVesselHistory.count == 0 {
                noHistorLabel.hidden = false
            } else {
                noHistorLabel.hidden = true
            }
            vesselCollectView.reloadData()
            searchResultTableView.reloadData()
        } else  {
            alert.showCustom("Oops!", subTitle: "There is no data for Vessel.", color: Constants.Colors.BluedBorder, icon: alertViewIcon!, closeButtonTitle: "OK", duration: 3.0, colorStyle: 0xA429FF, colorTextButton: 0xFFFFFF, circleIconImage: alertViewIcon!, animationStyle: .TopToBottom)
        }
    }
    
    // MARK: - UIButtonAction.
    @IBAction func didTapNextStep(sender: AnyObject) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("SelectDateTimeForTripViewController")
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func didTapResetSearchField(sender: AnyObject) {
        
        self.isSearch = false
        searchTextField.text = ""
        arrVesselSearchResult = arrVessel
        arrSelectedIndexPath.removeAllObjects()
        
        vesselCollectView.reloadData()
        searchResultTableView.reloadData()
    }

    @IBAction func didTapCancelSearchResult(sender: AnyObject) {
        
        self.isSearch = false
        searchResultView.hidden = true
        searchTextField.text = ""
        searchTextField.resignFirstResponder()
        arrVesselSearchResult = arrVessel
        arrSelectedIndexPath.removeAllObjects()
        
        vesselCollectView.reloadData()
        searchResultTableView.reloadData()
    }
    
    @IBAction func didTapAddSelectedVessels(sender: AnyObject) {
        searchResultView.hidden = true
    }
    
    // MARK: UICollectionView Data Source.
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

        let itemWidth = collectionView.bounds.size.width
        
        return CGSize(width: itemWidth, height: 44)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrVesselHistory.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("VesselCollectionViewCell", forIndexPath: indexPath) as! VesselCollectionViewCell
        
        if arrVesselHistory.count > 0 && !isSearch {
            let permits = arrVesselHistory[indexPath.row]
            cell.nameLabel.text = permits.ves_name
            cell.permitNum.text = permits.pnum
        }
        
        return cell
    }
    
    // MARK: UITableView Data Source.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isSearch {
            return arrVessel.count
        } else {
            return arrVesselSearchResult.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("VesselItemTableViewCell", forIndexPath: indexPath) as! VesselItemTableViewCell
        
        if arrVessel.count > 0 && !isSearch {
            let permits = arrVessel[indexPath.row]
            cell.vesselNameLabel.text = permits.ves_name
            cell.vesselNumLabel.text = permits.pnum
            
            if arrSelectedIndexPath.containsObject(indexPath) {
                cell.checkBoxImage.image = UIImage(named: "blueCheckButton")
                let vesselName = cell.vesselNumLabel.text! + ", " + cell.vesselNameLabel.text!
                searchTextField.text = vesselName

            }else {
                cell.checkBoxImage.image = nil
            }
        }
        
        if arrVesselSearchResult.count > 0 && isSearch {
            let permits = arrVesselSearchResult[indexPath.row]
            cell.vesselNameLabel.text = permits.ves_name
            cell.vesselNumLabel.text = permits.pnum
            
            if arrSelectedIndexPath.containsObject(indexPath) {
                cell.checkBoxImage.image = UIImage(named: "blueCheckButton")
                let vesselName = cell.vesselNumLabel.text! + ", " + cell.vesselNameLabel.text!
                searchTextField.text = vesselName
                
            }else {
                cell.checkBoxImage.image = nil
            }

        }
        return cell
    }
    
    // MARK: UITableView Delegate.
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if arrSelectedIndexPath.containsObject(indexPath) {
            
            arrSelectedIndexPath.removeObject(indexPath)
        }else  {
            
            arrSelectedIndexPath.removeAllObjects()
            arrSelectedIndexPath.addObject(indexPath)
            
            if !isSearch {
                permits = arrVessel[indexPath.row]
            } else {
                permits = arrVesselSearchResult[indexPath.row]
            }
        }

        tableView .reloadData()
    }
    
    // MARK: UITextField Delegate.
    func textFieldDidBeginEditing(textField: UITextField) {
        searchResultView.hidden = false
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchResultView.hidden = true
        
        if self.permits != nil {
            self.arrVesselHistory.append(self.permits)
            if arrVesselHistory.count == 0 {
                noHistorLabel.hidden = false
            } else {
                noHistorLabel.hidden = true
            }
            
            vesselCollectView.reloadData()
            self.permits = nil
        }
        
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {

        let textFieldText: NSString = textField.text ?? ""
        let txtAfterUpdate = textFieldText.stringByReplacingCharactersInRange(range, withString: string)
        
        if txtAfterUpdate == "" {
            isSearch = false
            arrVesselSearchResult = arrVessel
        } else {
            isSearch = true
            self.arrVesselSearchResult = self.filterContentForSearchText(txtAfterUpdate, scope: "") as! [PermitsEntity]
        }

        searchResultTableView.reloadData()
        vesselCollectView.reloadData()
        
        return true
    }
    
    func filterContentForSearchText(searchText: String, scope: String) -> NSArray {
        let num = Int(searchText)
        let resultPredicate: NSPredicate?
        if num != nil {
            resultPredicate = NSPredicate(format: "pnum contains[c] %@", searchText)
        } else {
            resultPredicate = NSPredicate(format: "ves_name contains[c] %@", searchText)
        }
        let searchResultArray = (arrVessel as NSArray).filteredArrayUsingPredicate(resultPredicate!)
        
        return searchResultArray
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



