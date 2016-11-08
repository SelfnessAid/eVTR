//
//  AreaTableViewCell.swift
//  eVTR
//
//  Created by Derek Stock on 7/22/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit

class AreaTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var valueField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        valueField.layer.borderWidth = 0.5
        valueField.layer.borderColor = Constants.Colors.FieldBorder.CGColor
        valueField.layer.cornerRadius = Constants.ButtonCornorRadius
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
