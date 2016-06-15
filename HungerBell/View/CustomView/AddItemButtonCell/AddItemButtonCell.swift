//
//  AddItemButtonCell.swift
//  HungerBell
//
//  Created by pankaj.jha on 6/10/16.
//  Copyright © 2016 Times Internet Limited. All rights reserved.
//

import UIKit

class AddItemButtonCell: UITableViewCell {

    
    @IBOutlet weak var  containerView:UIView!
    @IBOutlet weak var  addButton:UIButton!
    @IBOutlet weak var  priceLabel:UILabel!
    @IBOutlet weak var  caloryLabel:UILabel!

    func createDataOnIndexPath(indexPath:NSIndexPath, tableView:UITableView, controller:AnyObject, data:AnyObject) {
        let dataArray:NSMutableArray = data as! NSMutableArray
        var totalsum: Int = 0
        var calorySum: Int = 0
        for i in 0 ..< dataArray.count {
            let fooditem: FoodItem = (dataArray[i] as! FoodItem)
            totalsum = totalsum + fooditem.price.integerValue * fooditem.orderCount
            calorySum = calorySum + fooditem.calory.integerValue * fooditem.orderCount
        }
        if dataArray.count > 0 {
            self.priceLabel.text = "₹ \(totalsum)"
            self.caloryLabel.text = "\(calorySum) Kcal"
        }
        else {
            self.caloryLabel.hidden = true
            self.priceLabel.text = "Click + to Add"
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
