//
//  TripCrewTableViewCell.swift
//  eVTR
//
//  Created by Derek Stock on 7/22/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit

class TripCrewTableViewCell: UITableViewCell {

    @IBOutlet weak var crewNumberField: UITextField!
    @IBOutlet weak var btnCrew2: UIButton!
    @IBOutlet weak var btnCrew6: UIButton!
    @IBOutlet weak var btnCrew10: UIButton!
    @IBOutlet weak var btnCrew24: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        crewNumberField.layer.borderWidth = 0.5
        crewNumberField.layer.cornerRadius = 5
        crewNumberField.layer.borderColor = UIColor(red:235/255, green:235/255, blue:235/255, alpha: 1.0).CGColor

        self.contentView.layer.cornerRadius = Constants.ButtonCornorRadius
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = Constants.Colors.FieldBorder.CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func crewClickAction(sender: UIButton) {
        
        switch sender.tag {
        case 2:
            btnCrew2.layer.cornerRadius = Constants.ButtonCornorRadius
            btnCrew2.layer.borderColor = Constants.Colors.BluedBorder.CGColor
            btnCrew2.layer.borderWidth = 1
            btnCrew6.layer.borderWidth = 0
            btnCrew10.layer.borderWidth = 0
            btnCrew24.layer.borderWidth = 0
            break
        case 6:
            btnCrew6.layer.cornerRadius = Constants.ButtonCornorRadius
            btnCrew6.layer.borderWidth = 1
            btnCrew6.layer.borderColor = Constants.Colors.BluedBorder.CGColor
            btnCrew2.layer.borderWidth = 0
            btnCrew10.layer.borderWidth = 0
            btnCrew24.layer.borderWidth = 0
            break
        case 10:
            btnCrew10.layer.cornerRadius = Constants.ButtonCornorRadius
            btnCrew10.layer.borderWidth = 1
            btnCrew10.layer.borderColor = Constants.Colors.BluedBorder.CGColor
            btnCrew2.layer.borderWidth = 0
            btnCrew6.layer.borderWidth = 0
            btnCrew24.layer.borderWidth = 0
            break
        case 24:
            btnCrew24.layer.cornerRadius = Constants.ButtonCornorRadius
            btnCrew24.layer.borderWidth = 1
            btnCrew24.layer.borderColor = Constants.Colors.BluedBorder.CGColor
            btnCrew2.layer.borderWidth = 0
            btnCrew6.layer.borderWidth = 0
            btnCrew10.layer.borderWidth = 0
            break
        default:
            break
        }
    }
}
