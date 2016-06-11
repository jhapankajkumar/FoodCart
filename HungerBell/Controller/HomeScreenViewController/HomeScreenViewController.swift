//
//  HomeScreenViewController.swift
//  HungerBell
//
//  Created by pankaj.jha on 6/10/16.
//  Copyright © 2016 Times Internet Limited. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    var breakFirstDataArray:NSMutableArray!
    var dinnerDataArray:NSMutableArray!
    var tableDataArray:NSMutableArray!
    
    var ekNavigationBar:EKNavigationBar!
    var segmentedControl:HMSegmentedControl!
    var selectedIndex:NSInteger!
    var selectedIndexPath:NSIndexPath!
    var selectedDate:NSDate!
    var paymentInformation:PaymentInformation!
    
    
    @IBOutlet weak var segmentedSectionView: UIView!
    @IBOutlet weak var menuTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //call this method to initial setup
        self.initialSetup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.hidesBackButton = true
        if Constant.SharedAppDelegate.globalKart.count > 0 {
          Constant.SharedAppDelegate.globalKart.removeAllObjects()
        }
        
        Constant.SharedAppDelegate.cartView.hidden = true
        Constant.SharedAppDelegate.cartView.cartButton.setTitle("", forState: .Normal)
        Constant.SharedAppDelegate.cartView.cartButton.setTitle("", forState: .Highlighted)
        self.selectedDate = nil
        self.navigationController!.navigationBar.addSubview(self.ekNavigationBar)

    }
    
    override func viewDidAppear(animated: Bool) {
        //self.changeStatusBarBackgroundColor(nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.ekNavigationBar.removeFromSuperview()
    }
    //Method to call initial setup
    
    func initialSetup() {
        //set automatic table view height
        
        self.navigationController!.navigationBarHidden = false;
        self.navigationItem.hidesBackButton = true
        self.menuTableView.rowHeight = UITableViewAutomaticDimension
        self.menuTableView.estimatedRowHeight = 80
        self.menuTableView.separatorStyle = .None
        //set navigation bar view
        self.ekNavigationBar = NSBundle.mainBundle().loadNibNamed("EKNavigationBar", owner: self, options: nil)[0] as! EKNavigationBar
        self.ekNavigationBar.frame = CGRectMake(0, 0, self.view.frame.size.width, self.ekNavigationBar.frame.size.height)
        self.ekNavigationBar.createViewForData("Eatkart", index: 0, controller: self)
        self.addTableData()
        //add segmented controll
        self.addSectionSegments()
//        self.getPaymentInformation()
    }

    
    func addSectionSegments() {
        if self.segmentedControl == nil {
            // Tying up the segmented control to a scroll view
            self.segmentedControl = HMSegmentedControl(frame: CGRectMake(0, 2, Constant.SCREENSIZE.width, 36))
            self.segmentedControl.sectionTitles = ["Breakfast", "Dinner"]
            //self.segmentedControl.sectionTitles = titleArray;
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
        switch aIndex {
        case 0:
            self.tableDataArray = self.breakFirstDataArray
            self.cancelButtonPressed(nil)
            self.menuTableView.reloadData()
        case 1:
            self.tableDataArray = self.dinnerDataArray
            self.cancelButtonPressed(nil)
            self.menuTableView.reloadData()
        default:
            break
        }
        
    }
    
    
    
    
    func menuButtonTapped(sender: AnyObject) {
        //AddGAIEvent(@"Settings screen", @"accessed", @"userButton" , [NSNumber numberWithInt:100]);
        self.sideMenuViewController.presentLeftMenuViewController()
    }
    //Add initial table data
    
    func addTableData() {
        self.dinnerDataArray = NSMutableArray()
        self.breakFirstDataArray = NSMutableArray()
        self.tableDataArray = NSMutableArray()
        let breakfastDataOne: [AnyObject] = ["ORDER FOR TODAY", "Order for Today's breakfirst"]
        let breakfastDataTwo: [AnyObject] = ["ORDER FOR \nLATER", "Place an order for a later delivery in next 7 days"]
        //NSArray * breakfastDataThree = [NSArray arrayWithObjects:@"PLAN FOR A WEEK",@"Plan your week long orders in advance for 10% discount", nil];
        self.breakFirstDataArray.addObject(breakfastDataOne)
        self.breakFirstDataArray.addObject(breakfastDataTwo)
        //[self.breakFirstDataArray addObject:breakfastDataThree];
        let dinnerDataOne: [AnyObject] = ["ORDER FOR TODAY", "Order for Today's dinner"]
        let dinnerDataTwo: [AnyObject] = ["ORDER FOR \nLATER", "Place an order for a later delivery in next 7 days"]
        self.dinnerDataArray.addObject(dinnerDataOne)
        self.dinnerDataArray.addObject(dinnerDataTwo)
        self.tableDataArray = self.breakFirstDataArray
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableDataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier: String = "HomeScreenTableViewCell"
        //get table view cell
        let listCell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
        
        
        var dataArray: [AnyObject] = self.tableDataArray.objectAtIndex(indexPath.row) as! [AnyObject]
        //get labels from cell
        let orderLabel: UILabel = (listCell.viewWithTag(1001) as! UILabel)
        let orderDescription: UILabel = (listCell.viewWithTag(1002) as! UILabel)
        //set data on label
        orderDescription.text = dataArray[1] as? String
        orderLabel.text = dataArray[0] as? String
        return listCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedIndexPath = indexPath
        
        
        self.performSegueWithIdentifier("HomeScreenToItemListScreen", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "HomeScreenToItemListScreen") {
            let listViewController: ItemListViewController = (segue.destinationViewController as! ItemListViewController)
            
            //listViewController.orderType = self.selectedIndex;
            listViewController.selectedDate = self.selectedDate
            //if self.selectedIndex > 0 {
                listViewController.orderType = .kOrderTypeDinner
            //}
            //else {
              //  listViewController.orderType = .kOrderTypeBreakFast
            //}
        }
    }
    

    
    func dateIsChanged(sender: UIDatePicker?) {
        self.selectedDate = sender!.date
        NSLog("selectedDate ")
    }
    
    func cancelButtonPressed(sender: AnyObject?) {
        //self.datePickerView.removeFromSuperview()
    }

    
}
