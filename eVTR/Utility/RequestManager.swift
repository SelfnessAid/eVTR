//
//  RequestManager.swift
//  eVTR
//
//  Created by Derek Stock on 8/22/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class RequestManager: NSObject {
    
    class var sharedManager: RequestManager {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: RequestManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = RequestManager()
        }
        return Static.instance!
    }
    
    private var contextManager: NSManagedObjectContext!
    
    override init() {
        super.init()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        contextManager = appDelegate.managedObjectContext
    }
    
    // MARK: - Login
    func loginRequest(userInfo: [String: AnyObject], complete: (([String: AnyObject]?, NSError?) -> Void)?) -> Void {
        Alamofire.request(.POST, Constants.NOAAAPIConfig.LoginRequest, parameters: userInfo, encoding: .JSON, headers: nil)
            .responseJSON { (response: Response<AnyObject, NSError>) in
                var loginResult: [String: AnyObject]?
                var error: NSError?
                switch response.result {
                case .Success(let data):
                    if let loginRst = data as? [String: AnyObject] {
                        if loginRst.count > 0 {
                            
                            loginResult = [:]
                            loginResult!["Status"]          = data["Status"]
                            loginResult!["token"]           = data["token"]
                            loginResult!["client_id"]       = data["client_id"]
                            loginResult!["operator_key"]    = data["operator_key"]
                            
                            if loginResult!["Status"]!.isEqualToString("Logged Out") {
                                if complete != nil {
                                    complete!(loginResult, nil)
                                    return
                                }
                            } else {
                                
/*                                // Remove all rows from Core Data Gear table
                                self.removeAllRows(GearEntity.entityName)
                                self.removeAllRows(ActivityEntity.entityName)
                                self.removeAllRows(ChartAreaEntity.entityName)
                                self.removeAllRows(OperatorsEntity.entityName)
                                self.removeAllRows(PermitsEntity.entityName)
                                self.removeAllRows(SpeciesEntity.entityName)
                                self.removeAllRows(TripTypesEntity.entityName)
                                self.removeAllRows(DealersEntity.entityName)
*/
                                
                                // Set all Gear in Core Data
                                if let gear = data["Gear"] as? [String: AnyObject] {
                                    if let updatedRows = gear["0"] as? [AnyObject] {
                                        let entity = NSEntityDescription.entityForName(GearEntity.entityName, inManagedObjectContext: self.contextManager)

                                        for r in updatedRows {
                                            if let row = r as? [String: AnyObject] {
                                                let gear = GearEntity(entity: entity!, insertIntoManagedObjectContext: self.contextManager)
                                                
                                                // Set all Gear in Core Data Gear table
                                                gear.setData(row)
                                                
                                                try! self.contextManager.save()
                                            }
                                        }
                                    }
                                    if let resultTimeStamp = gear["timestamp"] as? Double {
                                        Constants.UserDefault.Defaults.setDouble(resultTimeStamp, forKey: Constants.UserDefault.GearTimeStamp)
                                        Constants.UserDefault.Defaults.synchronize()
                                    }
                                }
                                
                                // Set all Activity in Core Data
                                if let activity = data["Activity"] as? [String: AnyObject] {
                                    if let updatedRows = activity["0"] as? [AnyObject] {
                                        let entity = NSEntityDescription.entityForName(ActivityEntity.entityName, inManagedObjectContext: self.contextManager)
                                        
                                        for r in updatedRows {
                                            if let row = r as? [String: AnyObject] {
                                                let activity = ActivityEntity(entity: entity!, insertIntoManagedObjectContext: self.contextManager)
                                                
                                                // Set all Activity in Core Data Gear table
                                                activity.setData(row)
                                                
                                                try! self.contextManager.save()
                                            }
                                        }
                                    }
                                    if let resultTimeStamp = activity["timestamp"] as? Double {
                                        Constants.UserDefault.Defaults.setDouble(resultTimeStamp, forKey: Constants.UserDefault.ActivityTimeStamp)
                                        Constants.UserDefault.Defaults.synchronize()
                                    }
                                }
                                
                                // Set all ChartArea in Core Data
                                if let chartArea = data["ChartArea"] as? [String: AnyObject] {
                                    if let updatedRows = chartArea["0"] as? [AnyObject] {
                                        let entity = NSEntityDescription.entityForName(ChartAreaEntity.entityName, inManagedObjectContext: self.contextManager)
                                        
                                        for r in updatedRows {
                                            if let row = r as? [String: AnyObject] {
                                                let chartArea = ChartAreaEntity(entity: entity!, insertIntoManagedObjectContext: self.contextManager)
                                                
                                                // Set all Activity in Core Data Gear table
                                                chartArea.setData(row)
                                                
                                                try! self.contextManager.save()
                                            }
                                        }
                                    }
                                    if let resultTimeStamp = chartArea["timestamp"] as? Double {
                                        Constants.UserDefault.Defaults.setDouble(resultTimeStamp, forKey: Constants.UserDefault.ChartAreaTimeStamp)
                                        Constants.UserDefault.Defaults.synchronize()
                                    }
                                }
                                
                                // Set all Operators in Core Data
                                if let operators = data["Operators"] as? [String: AnyObject] {
                                    if let updatedRows = operators["0"] as? [AnyObject] {
                                        let entity = NSEntityDescription.entityForName(OperatorsEntity.entityName, inManagedObjectContext: self.contextManager)
                                        
                                        for r in updatedRows {
                                            if let row = r as? [String: AnyObject] {
                                                let operators = OperatorsEntity(entity: entity!, insertIntoManagedObjectContext: self.contextManager)
                                                
                                                // Set all Activity in Core Data Gear table
                                                operators.setData(row)
                                                
                                                try! self.contextManager.save()
                                            }
                                        }
                                    }
                                    if let resultTimeStamp = operators["timestamp"] as? Double {
                                        Constants.UserDefault.Defaults.setDouble(resultTimeStamp, forKey: Constants.UserDefault.OperatorsTimeStamp)
                                        Constants.UserDefault.Defaults.synchronize()
                                    }
                                }
                                
                                // Set all Permits in Core Data
                                if let permits = data["Permits"] as? [String: AnyObject] {
                                    if let updatedRows = permits["0"] as? [AnyObject] {
                                        let entity = NSEntityDescription.entityForName(PermitsEntity.entityName, inManagedObjectContext: self.contextManager)
                                        
                                        for r in updatedRows {
                                            if let row = r as? [String: AnyObject] {
                                                let permits = PermitsEntity(entity: entity!, insertIntoManagedObjectContext: self.contextManager)
                                                
                                                // Set all Activity in Core Data Gear table
                                                permits.setData(row)
                                                
                                                try! self.contextManager.save()
                                            }
                                        }
                                    }
                                    if let resultTimeStamp = permits["timestamp"] as? Double {
                                        Constants.UserDefault.Defaults.setDouble(resultTimeStamp, forKey: Constants.UserDefault.PermitsTimeStamp)
                                        Constants.UserDefault.Defaults.synchronize()
                                    }
                                }
                                
                                // Set all Species in Core Data
                                if let species = data["Species"] as? [String: AnyObject] {
                                    if let updatedRows = species["0"] as? [AnyObject] {
                                        let entity = NSEntityDescription.entityForName(SpeciesEntity.entityName, inManagedObjectContext: self.contextManager)
                                        
                                        for r in updatedRows {
                                            if let row = r as? [String: AnyObject] {
                                                let species = SpeciesEntity(entity: entity!, insertIntoManagedObjectContext: self.contextManager)
                                                
                                                // Set all Activity in Core Data Gear table
                                                species.setData(row)
                                                
                                                try! self.contextManager.save()
                                            }
                                        }
                                    }
                                    if let resultTimeStamp = species["timestamp"] as? Double {
                                        Constants.UserDefault.Defaults.setDouble(resultTimeStamp, forKey: Constants.UserDefault.SpeciesTimeStamp)
                                        Constants.UserDefault.Defaults.synchronize()
                                    }
                                }
                                
                                // Set all Dealers in Core Data
                                if let dealers = data["Dealers"] as? [String: AnyObject] {
                                    if let updatedRows = dealers["0"] as? [AnyObject] {
                                        let entity = NSEntityDescription.entityForName(DealersEntity.entityName, inManagedObjectContext: self.contextManager)
                                        
                                        for r in updatedRows {
                                            if let row = r as? [String: AnyObject] {
                                                let dealers = DealersEntity(entity: entity!, insertIntoManagedObjectContext: self.contextManager)
                                                
                                                // Set all Activity in Core Data Gear table
                                                dealers.setData(row)
                                                
                                                try! self.contextManager.save()
                                            }
                                        }
                                    }
                                    if let resultTimeStamp = dealers["timestamp"] as? Double {
                                        Constants.UserDefault.Defaults.setDouble(resultTimeStamp, forKey: Constants.UserDefault.DealersTimeStamp)
                                        Constants.UserDefault.Defaults.synchronize()
                                    }
                                }
                                
                                // Set all TripTypes in Core Data
                                if let tripTypes = data["TripTypes"] as? [String: AnyObject] {
                                    if let updatedRows = tripTypes["0"] as? [AnyObject] {
                                        let entity = NSEntityDescription.entityForName(TripTypesEntity.entityName, inManagedObjectContext: self.contextManager)
                                        
                                        for r in updatedRows {
                                            if let row = r as? [String: AnyObject] {
                                                let tripTypes = TripTypesEntity(entity: entity!, insertIntoManagedObjectContext: self.contextManager)
                                                
                                                // Set all Activity in Core Data Gear table
                                                tripTypes.setData(row)
                                                
                                                try! self.contextManager.save()
                                            }
                                        }
                                    }
                                    if let resultTimeStamp = tripTypes["timestamp"] as? Double {
                                        Constants.UserDefault.Defaults.setDouble(resultTimeStamp, forKey: Constants.UserDefault.TripTypesTimeStamp)
                                        Constants.UserDefault.Defaults.synchronize()
                                    }
                                }
                            }
                        } else {
                            if complete != nil {
                                complete!(nil, nil)
                            }
                        }
                    }
                    break
                case .Failure(let err):
                    error = err
                    break
                }
                if complete != nil {
                    complete!(loginResult, error)
                }
        }
    }
    
    func getGearsFromCoreData() -> [GearEntity]? {
        let result = self.getRowsFromLocal(GearEntity.entityName) as? [GearEntity]
        print("Gear ==== \(result?.count)")
        return result
    }

    func getActivityFromCoreData() -> [ActivityEntity]? {
        let result = self.getRowsFromLocal(ActivityEntity.entityName) as? [ActivityEntity]
        print("Activity ==== \(result?.count)")
        return result
    }
    
    func getChartAreaFromCoreData() -> [ChartAreaEntity]? {
        let result = self.getRowsFromLocal(ChartAreaEntity.entityName) as? [ChartAreaEntity]
        print("ChartArea ==== \(result?.count)")
        return result
    }
    
    func getOperatorsFromCoreData() -> [OperatorsEntity]? {
        let result = self.getRowsFromLocal(OperatorsEntity.entityName) as? [OperatorsEntity]
        print("Operators ==== \(result?.count)")
        return result
    }
    
    func getPermitsFromCoreData() -> [PermitsEntity]? {
        let result = self.getRowsFromLocal(PermitsEntity.entityName) as? [PermitsEntity]
        print("Permits ==== \(result?.count)")
        return result
    }
    
    func getSpeciesFromCoreData() -> [SpeciesEntity]? {
        let result = self.getRowsFromLocal(SpeciesEntity.entityName) as? [SpeciesEntity]
        print("Species ==== \(result?.count)")
        return result
    }
    
    func getDealersFromCoreData() -> [DealersEntity]? {
        let result = self.getRowsFromLocal(DealersEntity.entityName) as? [DealersEntity]
        print("Dealers ==== \(result?.count)")
        return result
    }
    
    func getTripTypesFromCoreData() -> [TripTypesEntity]? {
        let result = self.getRowsFromLocal(TripTypesEntity.entityName) as? [TripTypesEntity]
        print("TripTypes ==== \(result?.count)")
        return result
    }
    
    private func getRowsFromLocal(entityName: String) -> [NSManagedObject]? {
        let fetchRequest = NSFetchRequest(entityName: entityName)
        do {
            let result = try contextManager.executeFetchRequest(fetchRequest)
            return result as? [NSManagedObject]
        } catch {
            return nil
        }
    }
    
    private func removeAllRows(entityName: String) -> Bool {
        if let result = getRowsFromLocal(entityName) {
            for row in result {
                contextManager.deleteObject(row)
            }
            do {
                try contextManager.save()
                return true
            } catch {
                return false
            }
        } else {
            return false
        }
    }
    
}
