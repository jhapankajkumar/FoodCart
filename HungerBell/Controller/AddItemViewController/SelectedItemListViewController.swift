//
//  AddItemViewController.swift
//  HungerBell
//
//  Created by pankaj.jha on 6/10/16.
//  Copyright © 2016 Times Internet Limited. All rights reserved.
//

import UIKit
import MBProgressHUD


@objc  protocol SelectedItemListViewControllerDelegate {
    
  optional  func updateTable()
}

class SelectedItemListViewController: UIViewController,ItemDetailViewControllerDelegate {
    
    @IBOutlet weak var listTabelVeiw:UITableView!
    var customNavigationBarView:CustomNavigationBarView!;
    var footerView:FooterView!
    var dateFormatter:NSDateFormatter!
    
    var foodItemArray:NSMutableArray!
    weak var delegate:SelectedItemListViewControllerDelegate?
    var orderType:OrderType!
    var selectedDate:NSDate!
    var selectedIndexPath:NSIndexPath!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        footerView = NSBundle.mainBundle().loadNibNamed("FooterView", owner: self, options: nil)[0] as! FooterView
        //[self.listTabelVeiw registerNib:[UINib nibWithNibName:@"FoodItemCategoryTableViewCell" bundle:nil] forCellReuseIdentifier:@"FoodItemCategoryTableViewCell"];
        self.listTabelVeiw.registerNib(UINib(nibName: "FoodItemTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodItemTableViewCell")
        self.listTabelVeiw.rowHeight = UITableViewAutomaticDimension
        self.listTabelVeiw.estimatedRowHeight = 100
        dateFormatter = NSDateFormatter()
        self.foodItemArray = Constant.SharedAppDelegate.globalKart
        self.navigationItem.hidesBackButton = true
        //[dateFormatter setDateFormat:@"dd MMM yy"];
        self.customNavigationBarView = NSBundle.mainBundle().loadNibNamed("CustomNavigationBarView", owner: self, options: nil)[0] as! CustomNavigationBarView
        self.customNavigationBarView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.customNavigationBarView.frame.size.height)
        self.customNavigationBarView.createViewForData("Eatkart", controller: self)
        self.customNavigationBarView.sortButton.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        var foundViewController = false
        if let viewControllers = navigationController?.viewControllers {
            for viewController in viewControllers {
                // some process
                if viewController.isKindOfClass(SelectedItemListViewController) {
                    foundViewController = true
                }
            } 
        }
        if foundViewController == false {
            if let delegate = self.delegate {
                delegate.updateTable!()
            }
        }
        
        self.customNavigationBarView.removeFromSuperview()
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController!.navigationBar.addSubview(self.customNavigationBarView)
    }
    

    
    
    func tableView(tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.foodItemArray.count + 1
            //return  self.tableDataArray.count;
    }
    //
    //
    func tableView(tableView:UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
            if indexPath.row == self.foodItemArray.count {
               let identifier: String = "AddItemButtonCell"
                    //get table view cell
                let listCell: AddItemButtonCell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! AddItemButtonCell
                listCell.createDataOnIndexPath(indexPath, tableView: tableView, controller: self, data: self.foodItemArray)
                listCell.addButton.addTarget(self, action: #selector(SelectedItemListViewController.addMoreItem(_:)), forControlEvents: .TouchUpInside)
                return listCell
            }
            else {
               let identifier: String = "FoodItemTableViewCell"
                    //get table view cell
                let listCell: FoodItemTableViewCell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! FoodItemTableViewCell
                listCell.setDataOnCell(self.foodItemArray[indexPath.row], aIndexPath: indexPath, aTableView: tableView, controller: self)
                return listCell
            }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row != self.foodItemArray.count {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            self.selectedIndexPath = indexPath;
            self.performSegueWithIdentifier("AddItemViewToItemDetail", sender: self)
            
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView {
        let headerView: HeaderView = NSBundle.mainBundle().loadNibNamed("HeaderView", owner: self, options: nil)[0] as! HeaderView
        dateFormatter.dateFormat = "dd MMM yy"
        headerView.dateLabel.text = "\(dateFormatter.stringFromDate(NSDate(timeIntervalSinceNow: 0 * 3600 * 24)))" as String
        return headerView
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView {
        var sum: Int = 0
        for i in 0 ..< self.foodItemArray.count {
            let fooditem: FoodItem = (self.foodItemArray[i] as! FoodItem)
            sum = sum + fooditem.price.integerValue * fooditem.orderCount
        }
        footerView.updatePrice(sum, section: section, tableView: tableView, controller: self)
        footerView.placeOrderButton.addTarget(self, action: #selector(SelectedItemListViewController.placeOrder(_:)), forControlEvents: .TouchUpInside)
        return footerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 110
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "listToPlaceOrderView") {
//            var placeOrder: PlaceOrderViewController = (segue.destinationViewController as! PlaceOrderViewController)
//            var paymentInformation: PaymentInformation = (objc_getAssociatedObject(self, "payment") as! PaymentInformation)
//            objc_setAssociatedObject(self, "payment", nil, 1)
//            placeOrder.paymentInformation = paymentInformation
//            placeOrder.orderType = self.orderType
//            placeOrder.selectedDate = self.selectedDate
//            SharedAppDelegate.cartView.hidden = true
        }
        else if (segue.identifier == "AddItemViewToItemDetail") {
            let detailViewController: ItemDetailViewController = (segue.destinationViewController as! ItemDetailViewController)
            detailViewController.foodDetail = self.foodItemArray.objectAtIndex(self.selectedIndexPath.row) as! FoodItem
            detailViewController.delegate = self
            Constant.SharedAppDelegate.cartView.hidden = true
        }
        
    }
    
    func updateMenuItemCountForItem(foodItem: FoodItem, atIndexPath indexPath: NSIndexPath) {
        let tempArray = self.foodItemArray.mutableCopy()
        var sum: Int = 0
        if self.foodItemArray.count > 0 {
            for i in 0 ..< tempArray.count {
                let fooditem: FoodItem = (tempArray[i] as! FoodItem)
                sum = sum + fooditem.price.integerValue * fooditem.orderCount
            }
        }
        self.listTabelVeiw.reloadData()
        footerView.updatePrice(sum, section: 0, tableView: self.listTabelVeiw, controller: self)
        if self.foodItemArray.count <= 0 {
            footerView.placeOrderButton.alpha = 0.6
            footerView.placeOrderButton.userInteractionEnabled = false
        }
        else {
            footerView.placeOrderButton.alpha = 1.0
            footerView.placeOrderButton.userInteractionEnabled = true
        }
    }
    
    func placeOrder(button: UIButton) {
        self.performSegueWithIdentifier("listToPlaceOrderView", sender: self)
//        MBProgressHUD.showHUDAddedTo(self.view!, animated: true)
//        DataFetchManager.sharedInstance().getPaymentInformationWithCompletionBlock({(cacheData: CacheData, error: NSError) -> Void in
//            MBProgressHUD.hideAllHUDsForView(self.view!, animated: true)
//            if error == nil {
//                if (cacheData.cachedData is PaymentInformation.self) {
//                    var paymentInformation: PaymentInformation = (cacheData.cachedData as! PaymentInformation)
//                    if paymentInformation.isOnlinePaymentAvailable.boolValue || paymentInformation.isCashOnDeliveryAvailable.boolValue {
//                        objc_setAssociatedObject(self, "payment", paymentInformation, 1)
//                        self.performSegueWithIdentifier("listToPlaceOrderView", sender: self)
//                    }
//                    else {
//                        //TODO: show alert
//                    }
//                }
//            }
//        })
    }
    
    func addMoreItem(sender: AnyObject) {
        self.navigationController!.popViewControllerAnimated(false)
    }
    
    func setUpdatedCountOfItem(foodItem: FoodItem) {
        let index: Int = self.foodItemArray.indexOfObject(foodItem)
        self.foodItemArray[index] = foodItem
        self.updateMenuItemCountForItem(foodItem, atIndexPath: NSIndexPath(forRow: index, inSection: 0))
        if Constant.SharedAppDelegate.globalKart.count > 0 {
            let orderCount = self.getTotalOrderCount()
            Constant.SharedAppDelegate.cartView.cartButton.setTitle("\(orderCount)", forState: .Normal)
            Constant.SharedAppDelegate.cartView.cartButton.setTitle("\(orderCount)", forState: .Highlighted)
        }
    }
    
    
    func getTotalOrderCount() -> NSInteger {
        var sum = 0
        for  index in 0..<Constant.SharedAppDelegate.globalKart.count {
            let foodItem = Constant.SharedAppDelegate.globalKart .objectAtIndex(index) as! FoodItem
            sum =  sum + foodItem.orderCount
        }
        return sum
    }
    
    
    func backButtonTapped(sender: UIButton) {
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
