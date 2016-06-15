//
//  ItemDetailViewController.swift
//  HungerBell
//
//  Created by pankaj.jha on 6/10/16.
//  Copyright © 2016 Times Internet Limited. All rights reserved.
//

import UIKit


@objc protocol ItemDetailViewControllerDelegate {
  optional  func setUpdatedCountOfItem(item:FoodItem)

}

class ItemDetailViewController: UIViewController {

    @IBOutlet weak var desciptionTitle:UILabel!
    @IBOutlet weak var itemDescription:UILabel!
    @IBOutlet weak var priceTitle:UILabel!
    @IBOutlet weak var itemImage:UIImageView!
    @IBOutlet weak var price:UILabel!
    @IBOutlet weak var caloryTitle:UILabel!
    @IBOutlet weak var calory:UILabel!
    @IBOutlet weak var increasQuantity:UIButton!
    @IBOutlet weak var DecreasQuantity:UIButton!
    @IBOutlet weak var orderCountLabel:UILabel!
    @IBOutlet weak var totalTitle:UILabel!
    @IBOutlet weak var total:UILabel!
    var foodDetail:FoodItem!
    @IBOutlet weak var itemName:UILabel!
    @IBOutlet weak var doneButton:UIButton!
    @IBOutlet weak var addRemoveView:UIView!
    
    var customNavigationBarView:CustomNavigationBarView!
    weak var delegate:ItemDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpFoodDetail()
        Constant.SharedAppDelegate.cartView.hidden = true
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
        self.customNavigationBarView = NSBundle.mainBundle().loadNibNamed("CustomNavigationBarView", owner: self, options: nil)[0] as! CustomNavigationBarView
        self.customNavigationBarView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.customNavigationBarView.frame.size.height)
        self.customNavigationBarView.sortButton.hidden = true
        self.customNavigationBarView.createViewForData(self.foodDetail.name, controller: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController!.navigationBar.addSubview(self.customNavigationBarView)
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        var foundViewController = false
        if let viewControllers = navigationController?.viewControllers {
            for viewController in viewControllers {
                // some process
                if viewController.isKindOfClass(ItemDetailViewController) {
                    foundViewController = true
                }
            }
        }
        if foundViewController == false {
            if let delegate = self.delegate {
                delegate.setUpdatedCountOfItem!(self.foodDetail)
            }
        }
        
        //if self.navigationController!.viewControllers.indexOf(self) == NSNotFound {
            // back button was pressed.  We know this is true because self is no longer
            // in the navigation stack.
        
       // }
        super.viewWillDisappear(animated)
    }
    
    func backButtonTapped(sender: UIButton) {
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    func setUpFoodDetail() {
        let imageUrl: String = "https://s3-ap-southeast-1.amazonaws.com/eatkartimages/img/\(self.foodDetail.name.stringByReplacingOccurrencesOfString(" ", withString: "+"))_full.jpg"
        
        self.itemImage.setImageWithURL(imageUrl, defaultUrl: imageUrl, downloadFlag: false, activityIndicatorStyle:.Gray, placeHolderImage: UIImage(named: "image_placeholder")) { (image:UIImage!, erro:NSError!) in
            if  image != nil {
                           }
            else {
                
            }
        }
        
        
        self.itemDescription.text = self.foodDetail.itemDescription as String
        self.price.text = "₹ \(self.foodDetail.price)"
        self.itemName.text = self.foodDetail.name as String
        self.calory.text = "\(self.foodDetail.calory.intValue>0 ? self.foodDetail.calory : 0) Kcal" as String
        self.doneButton.layer.borderColor = Constant.THEME_COLOR().CGColor
        self.doneButton.layer.borderWidth = 2.0
        self.orderCountLabel.text = "\(UInt(self.foodDetail.orderCount))"
        self.total.text = "\(self.foodDetail.orderCount * self.foodDetail.price.integerValue)" as String
    }
    /*
     #pragma mark - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func addItem(sender: AnyObject) {
        if self.foodDetail.orderCount < 20 {
            let predicate: NSPredicate = NSPredicate(format: "itemId==%@", self.foodDetail.itemId)
            let results: NSArray = Constant.SharedAppDelegate.globalKart.filteredArrayUsingPredicate(predicate)
            if results.count > 0 {
                let item: FoodItem = results.firstObject as! FoodItem
                item.orderCount = item.orderCount + 1
                self.orderCountLabel.text = "\(UInt(self.foodDetail.orderCount))"
                self.total.text = "\(self.foodDetail.orderCount * self.foodDetail.price.integerValue)"
                Constant.SharedAppDelegate.globalKart.removeObject(results.firstObject!)
                Constant.SharedAppDelegate.globalKart.addObject(item)
            }
            else {
                Constant.SharedAppDelegate.globalKart.addObject(self.foodDetail)
                self.foodDetail.orderCount =  self.foodDetail.orderCount + 1
                self.orderCountLabel.text = "\(UInt(self.foodDetail.orderCount))"
                self.total.text = "\(self.foodDetail.orderCount * self.foodDetail.price.integerValue)"
            }
        }
    }
    
    @IBAction func removeItem(sender: AnyObject) {
        if self.foodDetail.orderCount > 0 {
            let predicate: NSPredicate = NSPredicate(format: "itemId==%@", self.foodDetail.itemId)
            let results: NSArray = Constant.SharedAppDelegate.globalKart.filteredArrayUsingPredicate(predicate)
            if results.count > 0 {
                let item: FoodItem = (results.firstObject as! FoodItem)
                item.orderCount = item.orderCount - 1
                self.orderCountLabel.text = "\(UInt(self.foodDetail.orderCount))"
                self.total.text = "\(self.foodDetail.orderCount * self.foodDetail.price.integerValue)"
                Constant.SharedAppDelegate.globalKart.removeObject(results.firstObject!)
                Constant.SharedAppDelegate.globalKart.addObject(item)
                if item.orderCount == 0 {
                    Constant.SharedAppDelegate.globalKart.removeObject(results.firstObject!)
                }
            }
        }
        else {
            
        }
    }
    
    @IBAction func doneButtonTapped(sender: AnyObject) {
        if self.delegate != nil {
            self.delegate?.setUpdatedCountOfItem!(self.foodDetail)
        }
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
