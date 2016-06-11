//
//  FoodItemCategoryTableViewCell.swift
//  HungerBell
//
//  Created by pankaj.jha on 6/10/16.
//  Copyright © 2016 Times Internet Limited. All rights reserved.
//

import UIKit

class FoodItemCategoryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var foodType: UIImageView!
    @IBOutlet weak var itemName: UILabel!    
    var tableView:UITableView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setDataOnCell(aData: AnyObject, onIndexPath aIndexPath: NSIndexPath, onTableView aTableView: UITableView, fromController controller: AnyObject) {
        let foodItem: FoodItem = (aData as! FoodItem)
        self.tableView = aTableView
        self.itemName.text = foodItem.name as String
        if foodItem.isNonVeg.boolValue {
            self.foodType.image = UIImage(named: "nonveg_icon.png")
        }
        else {
            self.foodType.image = UIImage(named: "vetg_icon.png")
        }
        self.itemImage.image = UIImage(named: "place_holder.png")
        let imageUrl: String = "https://s3-ap-southeast-1.amazonaws.com/eatkartimages/img/\(foodItem.name.stringByReplacingOccurrencesOfString(" ", withString: "+")).jpg"
        
        
        weak var weakSelf = self;
        
        self.itemImage.setImageWithURL(imageUrl, defaultUrl: imageUrl, downloadFlag: false, activityIndicatorStyle:.Gray, placeHolderImage: UIImage(named: "image_placeholder")) { (image:UIImage!, erro:NSError!) in
            if  image != nil {
                let localCell: FoodItemCategoryTableViewCell = (weakSelf!.tableView.cellForRowAtIndexPath(aIndexPath) as! FoodItemCategoryTableViewCell)
                    localCell.itemImage.layer.cornerRadius = 4.0
                    localCell.itemImage.clipsToBounds = true
            }
            else {
                let localCell: FoodItemCategoryTableViewCell = (weakSelf!.tableView.cellForRowAtIndexPath(aIndexPath) as! FoodItemCategoryTableViewCell)
                    localCell.itemImage.layer.cornerRadius = 4.0
                    localCell.itemImage.clipsToBounds = true
                    localCell.itemImage.image = UIImage(named: "place_holder.png")
            }
        }
        
        
        // self.price.text = [NSString stringWithFormat:@"%@",foodItem.price];
        //self.price.text = [NSString stringWithFormat:@"%@",foodItem.price];
    }
    

}
