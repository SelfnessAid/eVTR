//
//  EndTripReviewViewController.swift
//  eVTR
//
//  Created by Derek Stock on 7/28/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit

class EndTripReviewViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet var footerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.registerNib(UINib(nibName: "SaleInfoTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "SaleInfoTableViewCell")
        
        mainTableView.tableFooterView = footerView
   }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: UIButton Action.
    @IBAction func didTapNextStep(sender: AnyObject) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("SignSubmitViewController")
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func didAddSale(sender: AnyObject) {
        
        didTapNextStep(self)
    }
    
    // MARK: UITableView Data Source.
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifiers = ["SaleInfoTableViewCell", "SaleInfoTableViewCell", "SaleInfoTableViewCell"]
        let cell = tableView.dequeueReusableCellWithIdentifier(identifiers[indexPath.section], forIndexPath: indexPath)
        if indexPath.section == 0 {
            let itemCell = cell as! SaleInfoTableViewCell
            itemCell.titleLabel.text = "Sale 1"
        } else if indexPath.section == 1 {
            let itemCell = cell as! SaleInfoTableViewCell
            itemCell.titleLabel.text = "Sale 2"
        } else if indexPath.section == 2 {
            let itemCell = cell as! SaleInfoTableViewCell
            itemCell.titleLabel.text = "Sale 3"
        }
        return cell
    }
    
    // MARK: UITableView Delegate.
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 235
        }
        else if indexPath.section == 1 {
            return 235
        }
        return 235
    }
    
}


