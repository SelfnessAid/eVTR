//
//  TripAnglerTableViewCell.swift
//  eVTR
//
//  Created by Derek Stock on 7/22/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit

class TripAnglerTableViewCell: UITableViewCell {

    @IBOutlet weak var numberOfAnglersField: UITextField!
    @IBOutlet weak var btnAnglers1: UIButton!
    @IBOutlet weak var btnAnglers2: UIButton!
    @IBOutlet weak var btnAnglers10: UIButton!
    @IBOutlet weak var btnAnglers20: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        numberOfAnglersField.layer.borderWidth = 0.5
        numberOfAnglersField.layer.cornerRadius = 5
        numberOfAnglersField.layer.borderColor = UIColor(red:235/255, green:235/255, blue:235/255, alpha: 1.0).CGColor

        self.contentView.layer.cornerRadius = Constants.ButtonCornorRadius
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = Constants.Colors.FieldBorder.CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func anglersClickAction(sender: UIButton) {
        
        switch sender.tag {
        case 1:
            btnAnglers1.layer.cornerRadius = Constants.ButtonCornorRadius
            btnAnglers1.layer.borderWidth = 1
            btnAnglers1.layer.borderColor = Constants.Colors.BluedBorder.CGColor
            btnAnglers2.layer.borderWidth = 0
            btnAnglers10.layer.borderWidth = 0
            btnAnglers20.layer.borderWidth = 0
            break
        case 2:
            btnAnglers2.layer.cornerRadius = Constants.ButtonCornorRadius
            btnAnglers2.layer.borderWidth = 1
            btnAnglers2.layer.borderColor = Constants.Colors.BluedBorder.CGColor
            btnAnglers1.layer.borderWidth = 0
            btnAnglers10.layer.borderWidth = 0
            btnAnglers20.layer.borderWidth = 0
            break
        case 10:
            btnAnglers10.layer.cornerRadius = Constants.ButtonCornorRadius
            btnAnglers10.layer.borderWidth = 1
            btnAnglers10.layer.borderColor = Constants.Colors.BluedBorder.CGColor
            btnAnglers1.layer.borderWidth = 0
            btnAnglers2.layer.borderWidth = 0
            btnAnglers20.layer.borderWidth = 0
            break
        case 20:
            btnAnglers20.layer.cornerRadius = Constants.ButtonCornorRadius
            btnAnglers20.layer.borderWidth = 1
            btnAnglers20.layer.borderColor = Constants.Colors.BluedBorder.CGColor
            btnAnglers1.layer.borderWidth = 0
            btnAnglers2.layer.borderWidth = 0
            btnAnglers10.layer.borderWidth = 0
            break
        default:
            break
        }
    }
}
