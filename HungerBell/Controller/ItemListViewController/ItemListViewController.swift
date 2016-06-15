//
//  ItemListViewController.swift
//  HungerBell
//
//  Created by pankaj.jha on 6/10/16.
//  Copyright © 2016 Times Internet Limited. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController, UITableViewDataSource,UITableViewDelegate,ItemDetailViewControllerDelegate,SelectedItemListViewControllerDelegate {

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
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var itemListTableView: UITableView!
    @IBOutlet weak var segmentedSectionView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initialSetup()
        self .getCategoryData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        Constant.SharedAppDelegate.currentViewController = self;
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
        //self.navigationItem.hidesBackButton = YES;
        self.itemListTableView.registerNib(UINib(nibName: "FoodItemCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodItemCategoryTableViewCell")
        self.itemListTableView.registerNib(UINib(nibName: "FoodItemTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodItemTableViewCell")
        self.navigationItem.hidesBackButton = true
        self.tableDataArray = NSMutableArray()
        self.allDataArray = NSMutableArray()
        self.categorylist = NSMutableArray()
        //set navigation bar view
        self.customNavBar = NSBundle.mainBundle().loadNibNamed("CustomNavigationBarView", owner: self, options: nil)[0] as! CustomNavigationBarView
        self.customNavBar.frame = CGRectMake(0, 0, self.view.frame.size.width, self.customNavBar.frame.size.height)
        self.customNavBar.sortButton.addTarget(self, action: #selector(ItemListViewController.sortButtonTapped(_:)), forControlEvents: .TouchUpInside)
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd MMM yy"
        if (self.selectedDate != nil) {
            self.customNavBar.createViewForData("\(dateFormatter.stringFromDate(self.selectedDate))", controller: self)
        }
        else {
            self.customNavBar.createViewForData("\(dateFormatter.stringFromDate(NSDate()))", controller: self)
        }
        //set Filter bar view
        self.filterView = NSBundle.mainBundle().loadNibNamed("FilterView", owner: self, options: nil)[0] as! FilterView
        self.filterView.frame = CGRectMake(0, CGRectGetMaxY(self.customNavBar.frame), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))
        self.filterView.controller = self
        self.sortType = .kSortTypeAll
    }
    
    func backButtonTapped(sender: UIButton) {
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    func getCategoryData() {
        self.itemListTableView.hidden = true
        self.loadingIndicator.startAnimating()
        self.noDataLabel.hidden = true
        
        DataFetchManager.sharedInstance.fetchFoodCategoryOfOrderType(self.orderType) { (result, categories) in
            if result == true {
                
                self.categorylist = NSMutableArray(array: categories!)
                self.addSectionSegments()
                self.getFoodItemListForItem(self.segmentedControl.sectionTitles[0] as! String)
            }
            else {
                self.loadingIndicator.stopAnimating()
                self.loadingIndicator.hidden = true
                self.itemListTableView.hidden = true
                self.noDataLabel.hidden = false
                NSLog("got the error")
            }
        }
        

    }
    
    func addSectionSegments() {
        if self.segmentedControl == nil {
            // Tying up the segmented control to a scroll view
            self.segmentedControl = HMSegmentedControl(frame: CGRectMake(0, 2, Constant.SCREENSIZE.width, 44))
            
            let titlesArray = NSMutableArray()
            
            for  index in 0...self.categorylist.count-1 {
                let foodCategory = self.categorylist .objectAtIndex(index) as! FoodCategory
                titlesArray.addObject(foodCategory.name)
            }
            
            
            self.segmentedControl.sectionTitles = titlesArray as [AnyObject];
            self.segmentedControl.backgroundColor = Constant.STANDARD_BACKGROUND_COLOR()
            self.segmentedControl.titleTextAttributes = [NSForegroundColorAttributeName: Constant.LIGHT_THEME_COLOR(), NSFontAttributeName: Constant.Avenir_Regular(16)]
            self.segmentedControl.selectedTitleTextAttributes = [NSForegroundColorAttributeName: Constant.THEME_COLOR(), NSFontAttributeName: Constant.Avenir_Bold(16)]
            self.segmentedControl.selectionIndicatorColor = Constant.THEME_COLOR()
            self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe
            self.segmentedControl.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
            self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown
            self.segmentedControl.selectionIndicatorBoxOpacity = 0.0
            self.segmentedControl.selectionIndicatorHeight = 3.0
            self.segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleFixed
            self.segmentedControl.tag = 40320
            self.segmentedControl.isAccessibilityElement = true
            self.segmentedSectionView.addSubview(self.segmentedControl)
            self.selectedIndex = 0
        }
        weak var weakself = self
        self.segmentedControl.indexChangeBlock = {(index: Int) -> Void in
            weakself!.segmentChangedWithIndex(index)
            weakself!.selectedIndex = index
        }
        self.segmentedControl.selectedSegmentIndex = self.selectedIndex
    }
    
    func segmentChangedWithIndex(aIndex: Int) {
        self.noDataLabel.hidden = true
        self.itemListTableView.hidden = true
        self.loadingIndicator.hidden = false
        self.loadingIndicator.startAnimating()
        self.getFoodItemListForItem(self.segmentedControl.sectionTitles[aIndex] as! String)
        
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
                    self.itemListTableView.hidden = false
                    self.itemListTableView.reloadData()
                }
                else {
                    self.noDataLabel.hidden = false
                    self.itemListTableView.hidden = true
                }
            }
            else {
                self.itemListTableView.hidden = true
                self.noDataLabel.hidden = false
            }
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableDataArray.count;
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let foodItem: FoodItem = self.tableDataArray.objectAtIndex(indexPath.row) as! FoodItem
        if foodItem.islastItem.boolValue {
            let identifier: String = "FoodItemTableViewCell"
            //get table view cell
            let listCell: FoodItemTableViewCell? = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as? FoodItemTableViewCell
//            if listCell == nil {
//                listCell = FoodItemTableViewCell(style: .Default, reuseIdentifier: identifier)
//            }
            
            listCell!.setDataOnCell(self.tableDataArray.objectAtIndex(indexPath.row), aIndexPath: indexPath, aTableView: tableView, controller: self)
            
            return listCell!
        }
        else {
            let identifier: String = "FoodItemCategoryTableViewCell"
            //get table view cell
            let listCell: FoodItemCategoryTableViewCell? = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as?FoodItemCategoryTableViewCell
           
            listCell!.setDataOnCell(self.tableDataArray[indexPath.row], onIndexPath: indexPath, onTableView: tableView, fromController: self)
            return listCell!
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let foodItem: FoodItem = (self.tableDataArray[indexPath.row] as! FoodItem)
        self.selectedIndexPath = indexPath
        if foodItem.islastItem.boolValue {
            self.performSegueWithIdentifier("FoodItemListTOItemDetail", sender: self)
        }
        else {
            self.performSegueWithIdentifier("ListToSublistView", sender: self)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "FoodItemListTOItemDetail") {
            let detailViewController: ItemDetailViewController = (segue.destinationViewController as! ItemDetailViewController)
            let foodItem: FoodItem = (self.tableDataArray[self.selectedIndexPath.row] as! FoodItem)
            detailViewController.delegate = self
            detailViewController.foodDetail = foodItem
        }
        else if (segue.identifier == "itemListToPlaceOrder") {
            let addItemViewController: SelectedItemListViewController = (segue.destinationViewController as! SelectedItemListViewController)
            addItemViewController.foodItemArray = Constant.SharedAppDelegate.globalKart
            addItemViewController.delegate = self
            addItemViewController.orderType = self.orderType
            addItemViewController.selectedDate = self.selectedDate
            Constant.SharedAppDelegate.cartView.hidden = true
        }
        else if (segue.identifier == "ListToSublistView") {
            let subItemListViewController: SubItemListViewController = (segue.destinationViewController as! SubItemListViewController)
            let foodItem: FoodItem = (self.tableDataArray[self.selectedIndexPath.row] as! FoodItem)
            subItemListViewController.orderType = self.orderType
            subItemListViewController.item = foodItem
            subItemListViewController.selectedDate = self.selectedDate
            subItemListViewController.sortType = self.sortType
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
            self.itemListTableView.beginUpdates()
            self.itemListTableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: .None)
            self.itemListTableView.endUpdates()
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
            self.itemListTableView.hidden = false
            self.noDataLabel.hidden = true
            self.itemListTableView.reloadData()
        }
        else if self.sortType == .kSortTypeVeg && vegResult.count > 0 {
            self.tableDataArray = NSMutableArray(array: vegResult)
            self.itemListTableView.hidden = false
            self.noDataLabel.hidden = true
            self.itemListTableView.reloadData()
        }
        else if self.sortType == .kSortTypeNonVeg && nonVegResult.count > 0 {
            self.tableDataArray = NSMutableArray(array: nonVegResult)
            self.itemListTableView.hidden = false
            self.noDataLabel.hidden = true
            self.itemListTableView.reloadData()
        }
        else {
            self.itemListTableView.hidden = true
            self.noDataLabel.hidden = false
            self.itemListTableView.reloadData()
        }
        
        self.filterView.removeFromSuperview()
    }

    
    func updateTable() {
        if Constant.SharedAppDelegate.globalKart.count > 0 {
            Constant.SharedAppDelegate.cartView.hidden = false
        }
        self.itemListTableView.reloadData()
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
