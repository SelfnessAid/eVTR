//
//  TripTimeTableViewCell.swift
//  eVTR
//
//  Created by Derek Stock on 7/21/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit

class TripTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var hour1Button: UIButton!
    @IBOutlet weak var hour2Button: UIButton!
    @IBOutlet weak var hour3Button: UIButton!
    @IBOutlet weak var hour4Button: UIButton!
    @IBOutlet weak var hour5Button: UIButton!
    @IBOutlet weak var hour6Button: UIButton!
    @IBOutlet weak var hour7Button: UIButton!
    @IBOutlet weak var hour8Button: UIButton!
    @IBOutlet weak var hour9Button: UIButton!
    @IBOutlet weak var hour10Button: UIButton!
    @IBOutlet weak var hour11Button: UIButton!
    @IBOutlet weak var hour12Button: UIButton!
    
    @IBOutlet weak var min1Button: UIButton!
    @IBOutlet weak var min2Button: UIButton!
    @IBOutlet weak var min3Button: UIButton!
    @IBOutlet weak var min4Button: UIButton!
    
    @IBOutlet weak var amButton: UIButton!
    @IBOutlet weak var pmButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.layer.cornerRadius = Constants.ButtonCornorRadius
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = Constants.Colors.FieldBorder.CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func cellClickAction(sender: UIButton) {
        switch sender.tag {
        case 1:
            hour1Button.layer.cornerRadius = Constants.ButtonCornorRadius
            hour1Button.layer.borderColor = Constants.Colors.BluedBorder.CGColor
            hour1Button.layer.borderWidth = 1
            hour12Button.layer.borderWidth = 0; hour2Button.layer.borderWidth = 0; hour3Button.layer.borderWidth = 0; hour4Button.layer.borderWidth = 0; hour5Button.layer.borderWidth = 0; hour6Button.layer.borderWidth = 0; hour7Button.layer.borderWidth = 0; hour8Button.layer.borderWidth = 0; hour9Button.layer.borderWidth = 0; hour10Button.layer.borderWidth = 0; hour11Button.layer.borderWidth = 0;
            break
        case 2:
            hour2Button.layer.cornerRadius = Constants.ButtonCornorRadius
            hour2Button.layer.borderColor = Constants.Colors.BluedBorder.CGColor
            hour2Button.layer.borderWidth = 1
            hour1Button.layer.borderWidth = 0; hour12Button.layer.borderWidth = 0; hour3Button.layer.borderWidth = 0; hour4Button.layer.borderWidth = 0; hour5Button.layer.borderWidth = 0; hour6Button.layer.borderWidth = 0; hour7Button.layer.borderWidth = 0; hour8Button.layer.borderWidth = 0; hour9Button.layer.borderWidth = 0; hour10Button.layer.borderWidth = 0; hour11Button.layer.borderWidth = 0;
            break
        case 3:
            hour3Button.layer.cornerRadius = Constants.ButtonCornorRadius
            hour3Button.layer.borderColor = Constants.Colors.BluedBorder.CGColor
            hour3Button.layer.borderWidth = 1
            hour1Button.layer.borderWidth = 0; hour2Button.layer.borderWidth = 0; hour12Button.layer.borderWidth = 0; hour4Button.layer.borderWidth = 0; hour5Button.layer.borderWidth = 0; hour6Button.layer.borderWidth = 0; hour7Button.layer.borderWidth = 0; hour8Button.layer.borderWidth = 0; hour9Button.layer.borderWidth = 0; hour10Button.layer.borderWidth = 0; hour11Button.layer.borderWidth = 0;
            break
        case 4:
            hour4Button.layer.cornerRadius = Constants.ButtonCornorRadius
            hour4Button.layer.borderColor = Constants.Colors.BluedBorder.CGColor
            hour4Button.layer.borderWidth = 1
            hour1Button.layer.borderWidth = 0; hour2Button.layer.borderWidth = 0; hour3Button.layer.borderWidth = 0; hour12Button.layer.borderWidth = 0; hour5Button.layer.borderWidth = 0; hour6Button.layer.borderWidth = 0; hour7Button.layer.borderWidth = 0; hour8Button.layer.borderWidth = 0; hour9Button.layer.borderWidth = 0; hour10Button.layer.borderWidth = 0; hour11Button.layer.borderWidth = 0;
            break
        case 5:
            hour5Button.layer.cornerRadius = Constants.ButtonCornorRadius
            hour5Button.layer.borderColor = Constants.Colors.BluedBorder.CGColor
            hour5Button.layer.borderWidth = 1
            hour1Button.layer.borderWidth = 0; hour2Button.layer.borderWidth = 0; hour3Button.layer.borderWidth = 0; hour4Button.layer.borderWidth = 0; hour12Button.layer.borderWidth = 0; hour6Button.layer.borderWidth = 0; hour7Button.layer.borderWidth = 0; hour8Button.layer.borderWidth = 0; hour9Button.layer.borderWidth = 0; hour10Button.layer.borderWidth = 0; hour11Button.layer.borderWidth = 0;
            break
        case 6:
            hour6Button.layer.cornerRadius = Constants.ButtonCornorRadius
            hour6Button.layer.borderColor = Constants.Colors.BluedBorder.CGColor
            hour6Button.layer.borderWidth = 1
            hour1Button.layer.borderWidth = 0; hour2Button.layer.borderWidth = 0; hour3Button.layer.borderWidth = 0; hour4Button.layer.borderWidth = 0; hour5Button.layer.borderWidth = 0; hour12Button.layer.borderWidth = 0; hour7Button.layer.borderWidth = 0; hour8Button.layer.borderWidth = 0; hour9Button.layer.borderWidth = 0; hour10Button.layer.borderWidth = 0; hour11Button.layer.borderWidth = 0;
            break
        case 7:
            hour7Button.layer.cornerRadius = Constants.ButtonCornorRadius
            hour7Button.layer.borderColor = Constants.Colors.BluedBorder.CGColor
            hour7Button.layer.borderWidth = 1
            hour1Button.layer.borderWidth = 0; hour2Button.layer.borderWidth = 0; hour3Button.layer.borderWidth = 0; hour4Button.layer.borderWidth = 0; hour5Button.layer.borderWidth = 0; hour6Button.layer.borderWidth = 0; hour12Button.layer.borderWidth = 0; hour8Button.layer.borderWidth = 0; hour9Button.layer.borderWidth = 0; hour10Button.layer.borderWidth = 0; hour11Button.layer.borderWidth = 0;
            break
        case 8:
            hour8Button.layer.cornerRadius = Constants.ButtonCornorRadius
            hour8Button.layer.borderColor = Constants.Colors.BluedBorder.CGColor
            hour8Button.layer.borderWidth = 1
            hour1Button.layer.borderWidth = 0; hour2Button.layer.borderWidth = 0; hour3Button.layer.borderWidth = 0; hour4Button.layer.borderWidth = 0; hour5Button.layer.borderWidth = 0; hour6Button.layer.borderWidth = 0; hour7Button.layer.borderWidth = 0; hour12Button.layer.borderWidth = 0; hour9Button.layer.borderWidth = 0; hour10Button.layer.borderWidth = 0; hour11Button.layer.borderWidth = 0;
            break
        case 9:
            hour9Button.layer.cornerRadius = Constants.ButtonCornorRadius
            hour9Button.layer.borderColor = Constants.Colors.BluedBorder.CGColor
            hour9Button.layer.borderWidth = 1
            hour1Button.layer.borderWidth = 0; hour2Button.layer.borderWidth = 0; hour3Button.layer.borderWidth = 0; hour4Button.layer.borderWidth = 0; hour5Button.layer.borderWidth = 0; hour6Button.layer.borderWidth = 0; hour7Button.layer.borderWidth = 0; hour8Button.layer.borderWidth = 0; hour12Button.layer.borderWidth = 0; hour10Button.layer.borderWidth = 0; hour11Button.layer.borderWidth = 0;
            break
        case 10:
            hour10Button.layer.cornerRadius = Constants.ButtonCornorRadius
            hour10Button.layer.borderColor = Constants.Colors.BluedBorder.CGColor
            hour10Button.layer.borderWidth = 1
            hour1Button.layer.borderWidth = 0; hour2Button.layer.borderWidth = 0; hour3Button.layer.borderWidth = 0; hour4Button.layer.borderWidth = 0; hour5Button.layer.borderWidth = 0; hour6Button.layer.borderWidth = 0; hour7Button.layer.borderWidth = 0; hour8Button.layer.borderWidth = 0; hour9Button.layer.borderWidth = 0; hour12Button.layer.borderWidth = 0; hour11Button.layer.borderWidth = 0;
            break
        case 11:
            hour11Button.layer.cornerRadius = Constants.ButtonCornorRadius
            hour11Button.layer.borderColor = Constants.Colors.BluedBorder.CGColor
            hour11Button.layer.borderWidth = 1
            hour1Button.layer.borderWidth = 0; hour2Button.layer.borderWidth = 0; hour3Button.layer.borderWidth = 0; hour4Button.layer.borderWidth = 0; hour5Button.layer.borderWidth = 0; hour6Button.layer.borderWidth = 0; hour7Button.layer.borderWidth = 0; hour8Button.layer.borderWidth = 0; hour9Button.layer.borderWidth = 0; hour10Button.layer.borderWidth = 0; hour12Button.layer.borderWidth = 0;
            break
        case 12:
            hour12Button.layer.cornerRadius = Constants.ButtonCornorRadius
            hour12Button.layer.borderColor = Constants.Colors.BluedBorder.CGColor
            hour12Button.layer.borderWidth = 1
            hour1Button.layer.borderWidth = 0; hour2Button.layer.borderWidth = 0; hour3Button.layer.borderWidth = 0; hour4Button.layer.borderWidth = 0; hour5Button.layer.borderWidth = 0; hour6Button.layer.borderWidth = 0; hour7Button.layer.borderWidth = 0; hour8Button.layer.borderWidth = 0; hour9Button.layer.borderWidth = 0; hour10Button.layer.borderWidth = 0; hour11Button.layer.borderWidth = 0;
            break
        default:
            break
        }
    }
    
    @IBAction func minButtonClickAction(sender: UIButton) {
        
        switch sender.tag {
        case 14:
            min1Button.layer.cornerRadius = Constants.ButtonCornorRadius
            min1Button.layer.borderColor = Constants.Colors.BluedBorder.CGColor
            min1Button.layer.borderWidth = 1
            min2Button.layer.borderWidth = 0; min3Button.layer.borderWidth = 0; min4Button.layer.borderWidth = 0
            break
        case 15:
            min2Button.layer.cornerRadius = Constants.ButtonCornorRadius
            min2Button.layer.borderColor = Constants.Colors.BluedBorder.CGColor
            min2Button.layer.borderWidth = 1
            min1Button.layer.borderWidth = 0; min3Button.layer.borderWidth = 0; min4Button.layer.borderWidth = 0
            break
        case 30:
            min3Button.layer.cornerRadius = Constants.ButtonCornorRadius
            min3Button.layer.borderColor = Constants.Colors.BluedBorder.CGColor
            min3Button.layer.borderWidth = 1
            min1Button.layer.borderWidth = 0; min2Button.layer.borderWidth = 0; min4Button.layer.borderWidth = 0
            break
        case 45:
            min4Button.layer.cornerRadius = Constants.ButtonCornorRadius
            min4Button.layer.borderColor = Constants.Colors.BluedBorder.CGColor
            min4Button.layer.borderWidth = 1
            min1Button.layer.borderWidth = 0; min2Button.layer.borderWidth = 0; min3Button.layer.borderWidth = 0
            break
        default:
            break
        }
    }
    
    @IBAction func meridianButtonClickAction(sender: UIButton) {
        
        switch sender.tag {
        case 46:
            amButton.layer.cornerRadius = Constants.ButtonCornorRadius
            amButton.layer.borderColor = Constants.Colors.BluedBorder.CGColor
            amButton.layer.borderWidth = 1
            pmButton.layer.borderWidth = 0
            break
        case 47:
            pmButton.layer.cornerRadius = Constants.ButtonCornorRadius
            pmButton.layer.borderColor = Constants.Colors.BluedBorder.CGColor
            pmButton.layer.borderWidth = 1
            amButton.layer.borderWidth = 0
            break
        default:
            break
        }
    }
}
