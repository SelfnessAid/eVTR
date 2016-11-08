//
//  VesselItemTableViewCell.swift
//  eVTR
//
//  Created by Derek Stock on 7/21/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit

class VesselItemTableViewCell: UITableViewCell {

    @IBOutlet weak var checkBoxImage: UIImageView!
    @IBOutlet weak var vesselNameLabel: UILabel!
    @IBOutlet weak var vesselNumLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
