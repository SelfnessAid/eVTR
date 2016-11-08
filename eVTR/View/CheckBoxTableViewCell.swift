//
//  CheckBoxTableViewCell.swift
//  eVTR
//
//  Created by Derek Stock on 8/3/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit

class CheckBoxTableViewCell: UITableViewCell {

    @IBOutlet weak var checkButton: UIButton!

    var isChecked: Bool = true

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        checkButton.layer.borderWidth = 0.5
        checkButton.layer.cornerRadius = Constants.ButtonCornorRadius
        checkButton.layer.borderColor = Constants.Colors.FieldBorder.CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didTapCheckButton(sender: AnyObject) {
        
        isChecked = !isChecked
        if isChecked == true {
            checkButton.setImage(UIImage(named: "checkmark"), forState: .Normal)
        } else {
            checkButton.setImage(UIImage(named: "checkmark_none"), forState: .Normal)
        }
    }
}
