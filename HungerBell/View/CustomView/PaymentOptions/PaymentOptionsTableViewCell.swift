//
//  PaymentOptionsTableViewCell.swift
//  HungerBell
//
//  Created by pankaj.jha on 6/10/16.
//  Copyright © 2016 Times Internet Limited. All rights reserved.
//

import UIKit

class PaymentOptionsTableViewCell: UITableViewCell {
   
    
    @IBOutlet weak var selectCashOnDeliveryOption:UIButton!
    @IBOutlet weak var makeOnlinePaymentButton:UIButton!
    @IBOutlet weak var cashOnDeliveryView:UIView!
    @IBOutlet weak var onlinePaymentView:UIView!
    @IBOutlet weak var cashDeliveryCaption:UILabel!
    @IBOutlet weak var onlinePaymentCaption:UILabel!
    weak var viewController:PlaceOrderViewController!

    
    
    
    override func awakeFromNib() {
        // Initialization code
        self.onlinePaymentView.layer.cornerRadius = 5.0
        self.onlinePaymentView.layer.borderColor = Constant.THEME_COLOR().CGColor
        self.onlinePaymentView.layer.borderWidth = 2.0
        self.cashOnDeliveryView.layer.cornerRadius = 5.0
        self.cashOnDeliveryView.layer.borderColor = Constant.THEME_COLOR().CGColor
        self.cashOnDeliveryView.layer.borderWidth = 2.0
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func cashOnDeliverySelected(sender: AnyObject) {
        self.selectCashOnDeliveryOption.selected = true
        self.makeOnlinePaymentButton.selected = false
        //self.viewController.isCachOnDelivery = true
    }
    
    @IBAction func onlineOptionSelected(sender: AnyObject) {
        self.selectCashOnDeliveryOption.selected = false
        self.makeOnlinePaymentButton.selected = true
        //self.viewController.isCachOnDelivery = false
    }

}
