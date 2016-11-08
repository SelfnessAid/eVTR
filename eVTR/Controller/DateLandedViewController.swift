//
//  DateLandedViewController.swift
//  eVTR
//
//  Created by Derek Stock on 8/2/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit

class DateLandedViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet var headerLabel: UILabel!
    
    var tableViewWidth : CGFloat!
    var selectedIndexPath: NSIndexPath?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mainTableView.registerNib(UINib(nibName: "TripDateTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TripDateTableViewCell")
        mainTableView.registerNib(UINib(nibName: "TripTimeTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TripTimeTableViewCell")
        
        mainTableView.tableHeaderView = headerLabel
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
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("SalesInfoViewController")
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    // MARK: - UITableView Data Source.
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifiers = ["TripDateTableViewCell", "TripTimeTableViewCell"]
        let cell = tableView.dequeueReusableCellWithIdentifier(identifiers[indexPath.section], forIndexPath: indexPath)
        
        if indexPath.section == 0 {
            let itemCell = cell as! TripDateTableViewCell
            itemCell.titleLabel.text = "Date Landed"
            itemCell.calendarView.frame = CGRect(x: 0, y: 0, width: tableViewWidth, height: itemCell.calendarView.bounds.size.height)
            itemCell.menuView.frame = CGRect(x: 0, y: 0, width: tableViewWidth, height: itemCell.menuView.bounds.size.height)
            itemCell.configure()
        } else if indexPath.section == 1 {
            let itemCell = cell as! TripTimeTableViewCell
            itemCell.titleLabel.text = "Time Landed"
        }
        
        return cell
    }
    
    // MARK: UITableView Delegate.
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 290
        }
        return 235
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
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
