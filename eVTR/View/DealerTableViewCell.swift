//
//  DealerTableViewCell.swift
//  eVTR
//
//  Created by Derek Stock on 7/29/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit

class DealerTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var picker: UIPickerView!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var checkButton: UIButton!
    
    var isChecked: Bool = true
    
    var items = ["Choice Name A Goes Here", "Choice Name B Goes Here", "Choice Name C Goes Here", "Choice Name D Goes Here"]

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.contentView.layer.cornerRadius = Constants.ButtonCornorRadius
        self.contentView.layer.borderWidth = 0.8
        self.contentView.layer.borderColor = Constants.Colors.FieldBorder.CGColor
    
        valueField.layer.borderWidth = 0.5
        valueField.layer.cornerRadius = Constants.ButtonCornorRadius
        valueField.layer.borderColor = Constants.Colors.FieldBorder.CGColor
        checkButton.layer.borderWidth = 0.5
        checkButton.layer.cornerRadius = Constants.ButtonCornorRadius
        checkButton.layer.borderColor = Constants.Colors.FieldBorder.CGColor
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: UIPicker Datasource.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row]
    }

    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        var label = view as! UILabel!
        if label == nil {
            label = UILabel()
        }
        
        let pickerData = items[row]
        let title = NSAttributedString(string: pickerData, attributes: [NSFontAttributeName: UIFont(name: Constants.Fonts.OpenSans_Regular, size: 17)!])
        label.attributedText = title
        label.textAlignment = .Center
        
        return label
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 26
    }
    
    // MARK: UIButton Action.
    @IBAction func didTapCheckButton(sender: AnyObject) {
        
        isChecked = !isChecked
        if isChecked == true {
            checkButton.setImage(UIImage(named: "checkmark"), forState: .Normal)
        } else {
            checkButton.setImage(UIImage(named: "checkmark_none"), forState: .Normal)
        }
    }
    
}





