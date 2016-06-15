//
//  FoodItemTableViewCell.swift
//  HungerBell
//
//  Created by pankaj.jha on 6/10/16.
//  Copyright © 2016 Times Internet Limited. All rights reserved.
//

import UIKit

class FoodItemTableViewCell: UITableViewCell {

    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var calory: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var foodType: UIImageView!
    @IBOutlet weak var itemQuantity: UILabel!
    @IBOutlet weak var increseQuantity: UIButton!
    @IBOutlet weak var decreaseQuantity: UIButton!
    @IBOutlet weak var itemName: UILabel!
    
    
    weak var tableView :UITableView!
    weak var viewController:UIViewController!
    var foodItem:FoodItem!
    var indexPath:NSIndexPath!

    
    func setDataOnCell(aData:AnyObject, aIndexPath:NSIndexPath, aTableView:UITableView, controller:AnyObject) {
        self.foodItem = (aData as! FoodItem)
        self.tableView = aTableView
        self.itemName.text = self.foodItem.name as String
        self.viewController = (controller as! UIViewController)
        self.indexPath = aIndexPath
        if   Constant.SharedAppDelegate.globalKart.count > 0 {
            let predicate: NSPredicate = NSPredicate(format: "itemId==%@", self.foodItem.itemId)
            let results: NSArray =   Constant.SharedAppDelegate.globalKart.filteredArrayUsingPredicate(predicate)
            if results.count > 0 {
                self.foodItem.orderCount = (results.firstObject as! FoodItem).orderCount
            }
        }
        //self.foodItem.orderCount = self.foodItem.orderCount
        self.itemQuantity.text = "\(UInt(self.foodItem.orderCount))"
        self.calory.text = "\(self.foodItem.calory.intValue > 0 ? self.foodItem.calory : 0) Kcal" as String
        self.price.text = "₹ \(self.foodItem.price)"
        if self.foodItem.isNonVeg.boolValue {
            self.foodType.image = UIImage(named: "nonveg_icon.png")
        }
        else {
            self.foodType.image = UIImage(named: "vetg_icon.png")
        }
        self.itemImage.image = UIImage(named: "place_holder.png")
        let imageUrl: String = "https://s3-ap-southeast-1.amazonaws.com/eatkartimages/img/\(self.foodItem.name.stringByReplacingOccurrencesOfString(" ", withString: "+")).jpg"
        
        weak var weakSelf = self;
        
        self.itemImage.setImageWithURL(imageUrl, defaultUrl: imageUrl, downloadFlag: false, activityIndicatorStyle:.Gray, placeHolderImage: UIImage(named: "image_placeholder")) { (image:UIImage!, erro:NSError!) in
            if  image != nil {
                let localCell: FoodItemTableViewCell = (weakSelf!.tableView.cellForRowAtIndexPath(aIndexPath) as! FoodItemTableViewCell)
                localCell.itemImage.layer.cornerRadius = 4.0
                localCell.itemImage.clipsToBounds = true
            }
            else {
                let localCell: FoodItemTableViewCell = (weakSelf!.tableView.cellForRowAtIndexPath(aIndexPath) as! FoodItemTableViewCell)
                localCell.itemImage.layer.cornerRadius = 4.0
                localCell.itemImage.clipsToBounds = true
                localCell.itemImage.image = UIImage(named: "place_holder.png")
            }
        }
    }
    
    @IBAction func increaseItemQuantity(sender: AnyObject) {
       
        if self.foodItem.orderCount < 20 {
            let predicate: NSPredicate = NSPredicate(format: "itemId==%@", self.foodItem.itemId)
            let results: NSArray =   Constant.SharedAppDelegate.globalKart.filteredArrayUsingPredicate(predicate)
            if results.count > 0 {
                let item: FoodItem = (results.firstObject as! FoodItem)
                item.orderCount = item.orderCount + 1
                self.foodItem = item
                self.itemQuantity.text = "\(self.foodItem.orderCount)"
                //[  Constant.SharedAppDelegate.globalKart removeObject:[results firstObject]];
                //[  Constant.SharedAppDelegate.globalKart addObject:item];
                if   Constant.SharedAppDelegate.globalKart.count > 0 {
                    if !(self.viewController is SelectedItemListViewController ) {
                          Constant.SharedAppDelegate.cartView.hidden = false
                    }
                    else if (self.viewController is SelectedItemListViewController) {
                        let controller: SelectedItemListViewController = (self.viewController as! SelectedItemListViewController)
                        controller.updateMenuItemCountForItem(self.foodItem, atIndexPath: self.indexPath)
                    }
                    
                      let orderCount = self.getTotalOrderCount()
                      Constant.SharedAppDelegate.cartView.cartButton.setTitle("\(orderCount)", forState: .Normal)
                      Constant.SharedAppDelegate.cartView.cartButton.setTitle("\(orderCount)", forState: .Highlighted)
                }
            }
            else {
                  Constant.SharedAppDelegate.globalKart.addObject(self.foodItem)
                self.foodItem.orderCount = self.foodItem.orderCount + 1;
                self.itemQuantity.text = "\(self.foodItem.orderCount)"
                if   Constant.SharedAppDelegate.globalKart.count > 0 {
                    if !(self.viewController is SelectedItemListViewController) {
                          Constant.SharedAppDelegate.cartView.hidden = false
                    }
                    else if (self.viewController is SelectedItemListViewController) {
                        let controller: SelectedItemListViewController = (self.viewController as! SelectedItemListViewController)
                        controller.updateMenuItemCountForItem(self.foodItem, atIndexPath: self.indexPath)
                    }

                    let orderCount = self.getTotalOrderCount()
                    Constant.SharedAppDelegate.cartView.cartButton.setTitle("\(orderCount)", forState: .Normal)
                    Constant.SharedAppDelegate.cartView.cartButton.setTitle("\(orderCount)", forState: .Highlighted)
                }
            }
        }
        
    }
    
    @IBAction func decreaseItemQuantity(sender: AnyObject) {
        if self.foodItem.orderCount > 0 {
            let predicate: NSPredicate = NSPredicate(format: "itemId==%@", self.foodItem.itemId)
            let results: NSArray =   Constant.SharedAppDelegate.globalKart.filteredArrayUsingPredicate(predicate)
            if results.count > 0 {
                let item: FoodItem = (results.lastObject as! FoodItem)
                item.orderCount = item.orderCount - 1
                self.foodItem = item
                self.itemQuantity.text = "\(self.foodItem.orderCount)"
                //[  Constant.SharedAppDelegate.globalKart removeObject:[results lastObject]];
                //[  Constant.SharedAppDelegate.globalKart addObject:item];
                if item.orderCount == 0 {
                      Constant.SharedAppDelegate.globalKart.removeObject(results.firstObject!)
                }
                //if (  Constant.SharedAppDelegate.globalKart.count >= 0) {
                if !(self.viewController is SelectedItemListViewController) {
                      Constant.SharedAppDelegate.cartView.hidden = false
                }
                else if (self.viewController is SelectedItemListViewController) {
                    let controller: SelectedItemListViewController = (self.viewController as! SelectedItemListViewController)
                    controller.updateMenuItemCountForItem(self.foodItem, atIndexPath: self.indexPath)
                }
                
                let orderCount = self.getTotalOrderCount()
                Constant.SharedAppDelegate.cartView.cartButton.setTitle("\(orderCount)", forState: .Normal)
                Constant.SharedAppDelegate.cartView.cartButton.setTitle("\(orderCount)", forState: .Highlighted)
            }
            //}
        }
        if   Constant.SharedAppDelegate.globalKart.count <= 0 {
              Constant.SharedAppDelegate.cartView.hidden = true
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
    
    
    func getTotalOrderCount() -> NSInteger {
        var sum = 0
        for  index in 0..<Constant.SharedAppDelegate.globalKart.count {
            let foodItem = Constant.SharedAppDelegate.globalKart .objectAtIndex(index) as! FoodItem
            sum =  sum + foodItem.orderCount
        }
        return sum
    }
   
    

}
