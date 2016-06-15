//
//  SubItemListViewController.swift
//  HungerBell
//
//  Created by pankaj.jha on 6/10/16.
//  Copyright © 2016 Times Internet Limited. All rights reserved.
//

import UIKit

class SubItemListViewController: UIViewController,ItemDetailViewControllerDelegate,SelectedItemListViewControllerDelegate {
    
    var categorylist:NSArray!
    var allDataArray:NSMutableArray!
    var tableDataArray:NSMutableArray!
    var segmentedControl:HMSegmentedControl!
    var selectedIndex:NSInteger!
    var selectedIndexPath:NSIndexPath!
    var cartView:CartView!
    var customNavBar:CustomNavigationBarView!
    var filterView:FilterView!
    var orderType:OrderType!
    var sortType:SortType!
    var selectedDate:NSDate!
    var item:FoodItem!
    var selectedItem:NSString!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var noDataFound: UILabel!
    @IBOutlet weak var subItemListTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialSetup()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        Constant.SharedAppDelegate.currentViewController = self;
        self.navigationItem.hidesBackButton = true;
        self.navigationController!.navigationBar.addSubview(self.customNavBar)
    }
    
    override func viewWillDisappear(animated: Bool) {
        if self.navigationController!.viewControllers.indexOf(self) == NSNotFound {
            // back button was pressed.  We know this is true because self is no longer
            // in the navigation stack.
            if Constant.SharedAppDelegate.globalKart.count > 0 {
                Constant.SharedAppDelegate.globalKart.removeAllObjects()
            }
        }
        self.customNavBar.removeFromSuperview()
        super.viewWillDisappear(animated)
    }
    
    
    func initialSetup() {
        self.subItemListTableView.registerNib(UINib(nibName: "FoodItemTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodItemTableViewCell")
        self.subItemListTableView.hidden = true
        self.loadingIndicator.startAnimating()
        self.noDataFound.hidden = true
        self.tableDataArray = NSMutableArray()
        self.allDataArray = NSMutableArray()
        //set navigation bar view
        self.customNavBar = NSBundle.mainBundle().loadNibNamed("CustomNavigationBarView", owner: self, options: nil)[0] as! CustomNavigationBarView
        self.customNavBar.frame = CGRectMake(0, 0, self.view.frame.size.width, self.customNavBar.frame.size.height)
        self.customNavBar.sortButton.addTarget(self, action: #selector(SubItemListViewController.sortButtonTapped(_:)), forControlEvents: .TouchUpInside)
        self.customNavBar.sortButton.userInteractionEnabled = false
        self.customNavBar.sortButton.alpha = 0.5
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd MMM yy"
        if (self.selectedDate != nil) {
            self.customNavBar.createViewForData("\(dateFormatter.stringFromDate(self.selectedDate))", controller: self)
        }
        else {
            self.customNavBar.createViewForData("\(dateFormatter.stringFromDate(NSDate()))", controller: self)
        }        //set Filter bar view
        self.filterView = NSBundle.mainBundle().loadNibNamed("FilterView", owner: self, options: nil)[0] as! FilterView
        self.filterView.frame = CGRectMake(0, -20, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))
        self.filterView.controller = self
        self.filterView.sortType = self.sortType
        self.getFoodItemListForItem(self.item.name as String)
        
    }
    
    func backButtonTapped(sender: UIButton) {
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    func getFoodItemListForItem(item: String) {
        
        DataFetchManager.sharedInstance.fetchFoodItemDataForOrderType(self.orderType, name: item) { (result, foodItems) in
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.hidden = true
            if result == true {
                self.allDataArray = NSMutableArray(array: foodItems!)
                self.tableDataArray = NSMutableArray(array: foodItems!)
                let predicate: NSPredicate = NSPredicate(format: "isNonVeg==%d", 1)
                let nonVegResult: NSArray = self.allDataArray.filteredArrayUsingPredicate(predicate)
                let predicateAnother: NSPredicate = NSPredicate(format: "isNonVeg==%d", 0)
                let vegResult: NSArray = self.allDataArray.filteredArrayUsingPredicate(predicateAnother)
                if self.sortType == .kSortTypeAll {
                    self.tableDataArray = self.allDataArray
                }
                else if self.sortType == .kSortTypeVeg {
                    self.tableDataArray =   NSMutableArray(array: vegResult)
                }
                else if self.sortType == .kSortTypeNonVeg {
                    self.tableDataArray =  NSMutableArray(array: nonVegResult)
                }
                
                if self.tableDataArray.count > 0 {
                    self.subItemListTableView.hidden = false
                    self.subItemListTableView.reloadData()
                }
                else {
                    self.noDataFound.hidden = false
                    self.subItemListTableView.hidden = true
                }
                
                self.customNavBar.sortButton.userInteractionEnabled = true;
                self.customNavBar.sortButton.alpha = 1.0;
                
            }
            else {
                self.subItemListTableView.hidden = true
                self.noDataFound.hidden = false
            }
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableDataArray.count;
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier: String = "FoodItemTableViewCell"
        //get table view cell
        let listCell: FoodItemTableViewCell? = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as? FoodItemTableViewCell
        listCell!.setDataOnCell(self.tableDataArray.objectAtIndex(indexPath.row), aIndexPath: indexPath, aTableView: tableView, controller: self)
        return listCell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //let foodItem: FoodItem = (self.tableDataArray[indexPath.row] as! FoodItem)
        self.selectedIndexPath = indexPath
        
        self.performSegueWithIdentifier("FoodItemSubListTOItemDetail", sender: self)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "FoodItemSubListTOItemDetail") {
            let detailViewController: ItemDetailViewController = (segue.destinationViewController as! ItemDetailViewController)
            let foodItem: FoodItem = (self.tableDataArray[self.selectedIndexPath.row] as! FoodItem)
            detailViewController.delegate = self
            detailViewController.foodDetail = foodItem
        }
        else if (segue.identifier == "subItemListToPlaceOrder") {
            let addItemViewController: SelectedItemListViewController = (segue.destinationViewController as! SelectedItemListViewController)
            addItemViewController.foodItemArray = Constant.SharedAppDelegate.globalKart
            addItemViewController.delegate = self
            addItemViewController.orderType = self.orderType
            addItemViewController.selectedDate = self.selectedDate
            Constant.SharedAppDelegate.cartView.hidden = true
        }
    }
    
    func setUpdatedCountOfItem(foodItem: FoodItem) {
        var tempArray = NSMutableArray()
        tempArray = self.tableDataArray
        let index: Int = tempArray.indexOfObject(foodItem)
        if index != NSNotFound {
            //[(NSMutableArray *)tempArray replaceObjectAtIndex:index withObject:foodItem];
            //[self.tableDataArray removeAllObjects];
            //self.tableDataArray =  tempArray;
            self.subItemListTableView.beginUpdates()
            self.subItemListTableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: .None)
            self.subItemListTableView.endUpdates()
            if Constant.SharedAppDelegate.globalKart.count > 0 {
                Constant.SharedAppDelegate.cartView.hidden = false
                let orderCount = self.getTotalOrderCount()
                Constant.SharedAppDelegate.cartView.cartButton.setTitle("\(orderCount)", forState: .Normal)
                Constant.SharedAppDelegate.cartView.cartButton.setTitle("\(orderCount)", forState: .Highlighted)
            }
        }
    }
    
    func getTotalOrderCount() -> NSInteger {
        var sum = 0
        for  index in 0...Constant.SharedAppDelegate.globalKart.count-1 {
            let foodItem = Constant.SharedAppDelegate.globalKart .objectAtIndex(index) as! FoodItem
            sum =  sum + foodItem.orderCount
        }
        return sum
    }
    
    func reloadDataWithSortType(sortType: SortType) {
        self.sortType = sortType
        let predicate: NSPredicate = NSPredicate(format: "isNonVeg==%d", 1)
        let nonVegResult: NSArray = self.allDataArray.filteredArrayUsingPredicate(predicate)
        let predicateAnother: NSPredicate = NSPredicate(format: "isNonVeg==%d", 0)
        let vegResult: NSArray = self.allDataArray.filteredArrayUsingPredicate(predicateAnother)
        if self.sortType == .kSortTypeAll && self.allDataArray.count > 0 {
            self.tableDataArray =  self.allDataArray as NSMutableArray
            self.subItemListTableView.hidden = false
            self.noDataFound.hidden = true
            self.subItemListTableView.reloadData()
        }
        else if self.sortType == .kSortTypeVeg && vegResult.count > 0 {
            self.tableDataArray = NSMutableArray(array: vegResult)
            self.subItemListTableView.hidden = false
            self.noDataFound.hidden = true
            self.subItemListTableView.reloadData()
        }
        else if self.sortType == .kSortTypeNonVeg && nonVegResult.count > 0 {
            self.tableDataArray = NSMutableArray(array: nonVegResult)
            self.subItemListTableView.hidden = false
            self.noDataFound.hidden = true
            self.subItemListTableView.reloadData()
        }
        else {
            self.subItemListTableView.hidden = true
            self.noDataFound.hidden = false
            self.subItemListTableView.reloadData()
        }
        
        self.filterView.removeFromSuperview()
    }
    
    
    func updateTable() {
        if Constant.SharedAppDelegate.globalKart.count > 0 {
            Constant.SharedAppDelegate.cartView.hidden = false
        }
        self.subItemListTableView.reloadData()
    }
    
    func sortButtonTapped(button: UIButton) {
        self.view!.addSubview(self.filterView)
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
