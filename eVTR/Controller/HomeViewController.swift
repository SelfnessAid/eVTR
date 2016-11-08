//
//  HomeViewController.swift
//  eVTR
//
//  Created by Derek Stock on 7/21/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit
import Alamofire
import SCLAlertView
import CoreData

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tripTableView: UITableView!
    @IBOutlet weak var testTextView: UITextView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var alertView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tripTableView.registerNib(UINib(nibName: "TripItemTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TripItemTableViewCell")

        alertView.layer.cornerRadius = 5
        
        self.alertView.hidden = true
//        startActivityAnimating(Constants.IndicatorSize, message: "Loading Data...", type: .BallRotateChase, color: UIColor.whiteColor(), padding: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        // Load all data from Core Data
        loadDataFromLocalDatabase()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    @IBAction func fetchingDataFromCoreData(sender: AnyObject) {
        
        testTextView.text = ""
        self.alertView.hidden = true
    }

    // MARK: Load data stack.
    func loadDataFromLocalDatabase() {
        
        self.testTextView.text = ""
        
/*        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: true
        )
        
        let alert = SCLAlertView(appearance: appearance)
        let alertViewIcon = UIImage(named: "alertViewIcon")
        
        let gear = RequestManager.sharedManager.getGearsFromCoreData()
        let str = self.testTextView.text + "Updated Gear " + String(gear?.count) + "\n\n"
        self.testTextView.text = str
        if gear?.count > 0 {
            self.alertView.hidden = false
            for row in gear! {
                let keys = Array(row.entity.attributesByName.keys)
                print(row.dictionaryWithValuesForKeys(keys))

                let dict = row.dictionaryWithValuesForKeys(keys)
                let text = self.testTextView.text + "Gear\n" + String(dict) + "\n\n--------------------------\n\n"
                self.testTextView.text = text
            }
            //                alert.showCustom("Congratulations!", subTitle: "Data was loaded successfully.", color: Constants.Colors.BluedBorder, icon: alertViewIcon!, closeButtonTitle: "OK", duration: 3.0, colorStyle: 0xA429FF, colorTextButton: 0xFFFFFF, circleIconImage: alertViewIcon!, animationStyle: .TopToBottom)
        } else  {
            
            //                alert.showCustom("Oops!", subTitle: "There is no Data.", color: Constants.Colors.BluedBorder, icon: alertViewIcon!, closeButtonTitle: "OK", duration: 3.0, colorStyle: 0xA429FF, colorTextButton: 0xFFFFFF, circleIconImage: alertViewIcon!, animationStyle: .TopToBottom)
        }
        
        let activity = RequestManager.sharedManager.getActivityFromCoreData()
        let strAct = self.testTextView.text + "Updated Activity " + String(activity?.count) + "\n\n"
        self.testTextView.text = strAct
        if activity?.count > 0 {

            for row in activity! {
                let keys = Array(row.entity.attributesByName.keys)
                print(row.dictionaryWithValuesForKeys(keys))

                let dict = row.dictionaryWithValuesForKeys(keys)
                let text = self.testTextView.text + "Activity\n" + String(dict) + "\n\n--------------------------\n\n"
                self.testTextView.text = text
            }
            //                alert.showCustom("Congratulations!", subTitle: "Data was loaded successfully.", color: Constants.Colors.BluedBorder, icon: alertViewIcon!, closeButtonTitle: "OK", duration: 3.0, colorStyle: 0xA429FF, colorTextButton: 0xFFFFFF, circleIconImage: alertViewIcon!, animationStyle: .TopToBottom)
        } else  {
            
            //            alert.showCustom("Oops!", subTitle: "There is no Data.", color: Constants.Colors.BluedBorder, icon: alertViewIcon!, closeButtonTitle: "OK", duration: 3.0, colorStyle: 0xA429FF, colorTextButton: 0xFFFFFF, circleIconImage: alertViewIcon!, animationStyle: .TopToBottom)
        }
        
        let chartArea = RequestManager.sharedManager.getChartAreaFromCoreData()
        let strChart = self.testTextView.text + "Updated ChartArea " + String(chartArea?.count) + "\n\n"
        self.testTextView.text = strChart
        if chartArea?.count > 0 {

            for row in chartArea! {
                let keys = Array(row.entity.attributesByName.keys)
                print(row.dictionaryWithValuesForKeys(keys))

                let dict = row.dictionaryWithValuesForKeys(keys)
                let text = self.testTextView.text + "ChartArea\n" + String(dict) + "\n\n--------------------------\n\n"
                self.testTextView.text = text
            }
            //                alert.showCustom("Congratulations!", subTitle: "Data was loaded successfully.", color: Constants.Colors.BluedBorder, icon: alertViewIcon!, closeButtonTitle: "OK", duration: 3.0, colorStyle: 0xA429FF, colorTextButton: 0xFFFFFF, circleIconImage: alertViewIcon!, animationStyle: .TopToBottom)
        } else  {
            
            //            alert.showCustom("Oops!", subTitle: "There is no Data.", color: Constants.Colors.BluedBorder, icon: alertViewIcon!, closeButtonTitle: "OK", duration: 3.0, colorStyle: 0xA429FF, colorTextButton: 0xFFFFFF, circleIconImage: alertViewIcon!, animationStyle: .TopToBottom)
        }
        
        let operators = RequestManager.sharedManager.getOperatorsFromCoreData()
        let strOperaor = self.testTextView.text + "Updated Operators " + String(operators?.count) + "\n\n"
        self.testTextView.text = strOperaor
        if operators?.count > 0 {

            for row in operators! {
                let keys = Array(row.entity.attributesByName.keys)
                print(row.dictionaryWithValuesForKeys(keys))

                let dict = row.dictionaryWithValuesForKeys(keys)
                let text = self.testTextView.text + "Operators\n" + String(dict) + "\n\n--------------------------\n\n"
                self.testTextView.text = text
            }
            self.stopActivityAnimating()
            //                alert.showCustom("Congratulations!", subTitle: "Data was loaded successfully.", color: Constants.Colors.BluedBorder, icon: alertViewIcon!, closeButtonTitle: "OK", duration: 3.0, colorStyle: 0xA429FF, colorTextButton: 0xFFFFFF, circleIconImage: alertViewIcon!, animationStyle: .TopToBottom)
        } else  {
            
            //            alert.showCustom("Oops!", subTitle: "There is no Data.", color: Constants.Colors.BluedBorder, icon: alertViewIcon!, closeButtonTitle: "OK", duration: 3.0, colorStyle: 0xA429FF, colorTextButton: 0xFFFFFF, circleIconImage: alertViewIcon!, animationStyle: .TopToBottom)
        }

        let permits = RequestManager.sharedManager.getPermitsFromCoreData()
        let strPermits = self.testTextView.text + "Updated Permits " + String(permits?.count) + "\n\n"
        self.testTextView.text = strPermits
        if permits?.count > 0 {

            self.alertView.hidden = false

            for row in permits! {
                let keys = Array(row.entity.attributesByName.keys)
                print(row.dictionaryWithValuesForKeys(keys))

                let dict = row.dictionaryWithValuesForKeys(keys)
                let text = self.testTextView.text + "Permits\n" + String(dict) + "\n\n--------------------------\n\n"
                self.testTextView.text = text
            }
            self.stopActivityAnimating()
            //                alert.showCustom("Congratulations!", subTitle: "Data was loaded successfully.", color: Constants.Colors.BluedBorder, icon: alertViewIcon!, closeButtonTitle: "OK", duration: 3.0, colorStyle: 0xA429FF, colorTextButton: 0xFFFFFF, circleIconImage: alertViewIcon!, animationStyle: .TopToBottom)
        } else  {
            
            //            alert.showCustom("Oops!", subTitle: "There is no Data.", color: Constants.Colors.BluedBorder, icon: alertViewIcon!, closeButtonTitle: "OK", duration: 3.0, colorStyle: 0xA429FF, colorTextButton: 0xFFFFFF, circleIconImage: alertViewIcon!, animationStyle: .TopToBottom)
        }
        
        let species = RequestManager.sharedManager.getSpeciesFromCoreData()
        let strSpecies = self.testTextView.text + "Updated Species " + String(species?.count) + "\n\n"
        self.testTextView.text = strSpecies
        if species?.count > 0 {

            for row in species! {
                let keys = Array(row.entity.attributesByName.keys)
                print(row.dictionaryWithValuesForKeys(keys))

                let dict = row.dictionaryWithValuesForKeys(keys)
                let text = self.testTextView.text + "Species\n" + String(dict) + "\n\n--------------------------\n\n"
                self.testTextView.text = text
            }
            //                alert.showCustom("Congratulations!", subTitle: "Data was loaded successfully.", color: Constants.Colors.BluedBorder, icon: alertViewIcon!, closeButtonTitle: "OK", duration: 3.0, colorStyle: 0xA429FF, colorTextButton: 0xFFFFFF, circleIconImage: alertViewIcon!, animationStyle: .TopToBottom)
        } else  {
            
            //            alert.showCustom("Oops!", subTitle: "There is no Data.", color: Constants.Colors.BluedBorder, icon: alertViewIcon!, closeButtonTitle: "OK", duration: 3.0, colorStyle: 0xA429FF, colorTextButton: 0xFFFFFF, circleIconImage: alertViewIcon!, animationStyle: .TopToBottom)
        }
        
        let dealers = RequestManager.sharedManager.getDealersFromCoreData()
        let strDealers = self.testTextView.text + "Updated Dealers " + String(dealers?.count) + "\n\n"
        self.testTextView.text = strDealers
        if dealers?.count > 0 {

            for row in dealers! {
                let keys = Array(row.entity.attributesByName.keys)
                print(row.dictionaryWithValuesForKeys(keys))

                let dict = row.dictionaryWithValuesForKeys(keys)
                let text = self.testTextView.text + "Dealers\n" + String(dict) + "\n\n--------------------------\n\n"
                self.testTextView.text = text
            }
            //                alert.showCustom("Congratulations!", subTitle: "Data was loaded successfully.", color: Constants.Colors.BluedBorder, icon: alertViewIcon!, closeButtonTitle: "OK", duration: 3.0, colorStyle: 0xA429FF, colorTextButton: 0xFFFFFF, circleIconImage: alertViewIcon!, animationStyle: .TopToBottom)
        } else  {
            
            //            alert.showCustom("Oops!", subTitle: "There is no Data.", color: Constants.Colors.BluedBorder, icon: alertViewIcon!, closeButtonTitle: "OK", duration: 3.0, colorStyle: 0xA429FF, colorTextButton: 0xFFFFFF, circleIconImage: alertViewIcon!, animationStyle: .TopToBottom)
        }
        
        let tripTypes = RequestManager.sharedManager.getTripTypesFromCoreData()
        let strTripTypes = self.testTextView.text + "Updated TripTypes " + String(tripTypes?.count) + "\n\n"
        self.testTextView.text = strTripTypes
        if tripTypes?.count > 0 {
            self.alertView.hidden = false
            for row in tripTypes! {
                let keys = Array(row.entity.attributesByName.keys)
                print("final--------\(row.dictionaryWithValuesForKeys(keys))")
                let dict = row.dictionaryWithValuesForKeys(keys)
                let text = self.testTextView.text + "TripTypes\n" + String(dict) + "\n\n--------------------------\n\n"
                self.testTextView.text = text
            }
            //                alert.showCustom("Congratulations!", subTitle: "Data was loaded successfully.", color: Constants.Colors.BluedBorder, icon: alertViewIcon!, closeButtonTitle: "OK", duration: 3.0, colorStyle: 0xA429FF, colorTextButton: 0xFFFFFF, circleIconImage: alertViewIcon!, animationStyle: .TopToBottom)
        } else  {
            
            //            alert.showCustom("Oops!", subTitle: "There is no Data.", color: Constants.Colors.BluedBorder, icon: alertViewIcon!, closeButtonTitle: "OK", duration: 3.0, colorStyle: 0xA429FF, colorTextButton: 0xFFFFFF, circleIconImage: alertViewIcon!, animationStyle: .TopToBottom)
        }
*/
}

    // MARK: UIButton Action.
    @IBAction func didTapStartNewTrip(sender: AnyObject) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("SelectVesselViewController")
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    // MARK: - UITableView Data Source.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }
    
    // MARK: - UITableView Delegate.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TripItemTableViewCell", forIndexPath: indexPath)
        return cell
    }
    
}
