//
//  TripTypeTableViewCell.swift
//  eVTR
//
//  Created by Derek Stock on 7/22/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit


@objc protocol TripTypeTableViewCellDelegate {
    
    func didSelectedPickerRow(selectedRowValue: String);
}

class TripTypeTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var picker: UIPickerView!
    private var _items: [String]!
    
    var delegate:TripTypeTableViewCellDelegate!
    var items: [String] {
        get {
            if _items == nil {
                _items = [String]()
            }
            return _items
        }
        set (newValue) {
            _items = newValue
            picker.reloadAllComponents()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        self.contentView.layer.cornerRadius = Constants.ButtonCornorRadius
        self.contentView.layer.borderWidth = 0.8
        self.contentView.layer.borderColor = Constants.Colors.FieldBorder.CGColor
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
    
    // MARK: - Delegate.
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (self.delegate != nil) {
            self.delegate.didSelectedPickerRow(self.items[row])
        }
    }
}


