//
//  EffortReviewViewController.swift
//  eVTR
//
//  Created by Derek Stock on 7/25/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit

class EffortReviewViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var footerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        mainTableView.registerNib(UINib(nibName: "GearInfoTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "GearInfoTableViewCell")
        mainTableView.registerNib(UINib(nibName: "AreaInfoTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "AreaInfoTableViewCell")
        mainTableView.registerNib(UINib(nibName: "CatchInfoTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "CatchInfoTableViewCell")
        
        mainTableView.tableFooterView = footerView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UIButton Action.
    @IBAction func didTapNextStep(sender: AnyObject) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("DateLandedViewController")
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }

    // MARK: UITableView Data Source.
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifiers = ["GearInfoTableViewCell", "AreaInfoTableViewCell", "CatchInfoTableViewCell"]
        let cell = tableView.dequeueReusableCellWithIdentifier(identifiers[indexPath.section], forIndexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return GearInfoTableViewCell.getHeight()
        }
        else if indexPath.section == 1 {
            return AreaInfoTableViewCell.getHeight()
        }
        else if indexPath.section == 2 {
            return CatchInfoTableViewCell.getHeight()
        }
        
         return 95
    }

}
