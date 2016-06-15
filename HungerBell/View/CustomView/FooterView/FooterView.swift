//
//  FooterView.swift
//  HungerBell
//
//  Created by pankaj.jha on 6/10/16.
//  Copyright © 2016 Times Internet Limited. All rights reserved.
//

import UIKit

class FooterView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
     
    
    @IBOutlet weak var totalPrice:UILabel!
    @IBOutlet weak var placeOrderButton:UIButton!
    
    func updatePrice(price:NSInteger, section:NSInteger, tableView:UITableView,controller:AnyObject) {
        self.totalPrice.text = "\(Int(price))"
    }
    
    
}
