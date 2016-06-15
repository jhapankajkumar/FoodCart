//
//  PaymentSummeryTableViewCell.swift
//  HungerBell
//
//  Created by pankaj.jha on 6/10/16.
//  Copyright © 2016 Times Internet Limited. All rights reserved.
//

import UIKit

class PaymentSummeryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var subtotalTitle:UILabel!
    @IBOutlet weak var shippingTitle:UILabel!
    @IBOutlet weak var orderTotalTitle:UILabel!
    @IBOutlet weak var subTotal:UILabel!
    @IBOutlet weak var shipping:UILabel!
    
    @IBOutlet weak var orderTotal:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
