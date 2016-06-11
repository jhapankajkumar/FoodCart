//
//  BMIViewController.swift
//  EatKart
//
//  Created by pankaj.jha on 4/8/16.
//  Copyright © 2016 EatKart. All rights reserved.
//

import UIKit

class BMIViewController: UIViewController,UITextFieldDelegate {
    
//    //Top section Outlets
//    @IBOutlet weak var weightTextField: UITextField!
//    @IBOutlet weak var maleButton: UIButton!
//    @IBOutlet weak var heightTextField: UITextField!
//    @IBOutlet weak var femaleButton: UIButton!
//    @IBOutlet weak var ageTextField: UITextField!
//    @IBOutlet weak var segmentView: UIView!
//    @IBOutlet weak var bmiScrollView: UIScrollView!
//    @IBOutlet weak var bmiSectionView: UIView!
//    @IBOutlet weak var bmrSectionView: UIView!
//    @IBOutlet weak var calculateLabel: UILabel!
//    @IBOutlet weak var bmrScrollView: UIScrollView!
//    
//    var ekNavigationBar:CustomNavigationBarView = CustomNavigationBarView()
//    var orderType:OrderType = kOrderTypeBreakFast
//    let screenSize = UIScreen.mainScreen().bounds.size
//    var selectedIndex = 0
//    var segmentedControl = HMSegmentedControl!()
//    var activityDataArray = NSMutableArray()
//    var dropDownViewController  = DropDownViewController!()
//    var wyPopoverController = WYPopoverController!()
//    var bmiResult = BMIResult!()
//
//    var selectedActivityIndexPath =  NSIndexPath(forRow: 0, inSection: 0)
//    var activityData = ActivityModel()
//    var bmrCaclulatedValue = 0
//    var bmICaclulatedValue = 0.0
//    var bodyType = 0
//    
//    
//    
//    
//    
//    //BMI Segment Outlets
//    @IBOutlet weak var underWeightView: UIView!
//    @IBOutlet weak var normalView: UIView!
//    @IBOutlet weak var overWeightView: UIView!
//    @IBOutlet weak var obeseView: UIView!
//    @IBOutlet weak var calculatedBMI: UILabel!
//    @IBOutlet weak var idealBMI: UILabel!
//    @IBOutlet weak var bmiResultDescription: UILabel!
//    
//    //BMR Segment Outlets
//    @IBOutlet weak var activityView: UIView!
//    @IBOutlet weak var currentWeightValue: UILabel!
//    @IBOutlet weak var smoothWeightLossValue: UILabel!
//    @IBOutlet weak var fastWeightLossValue: UILabel!
//    @IBOutlet weak var smoothWeightGainValue: UILabel!
//    @IBOutlet weak var bmrResultDescription: UILabel!
//    
//    @IBOutlet weak var bmrValue: UILabel!
//    @IBOutlet weak var activityLabel: UILabel!
//    @IBOutlet weak var activityImage: UIImageView!
//    
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        initialSetup()
//        addSectionSegments()
//        addDoneButtonOnKeyboard()
//        createActivityDataArray()
//
//        // Do any additional setup after loading the view.
//    }
//    
//    override func viewWillAppear(animated: Bool) {
//        self.bmiScrollView.contentSize = CGSizeMake(screenSize.width, 287)
//        self.bmrScrollView.contentSize = CGSizeMake(screenSize.width, 287)
//        print(self.bmiScrollView.contentSize)
//        self.navigationController?.navigationBar .addSubview(self.ekNavigationBar)
//        setIntialValue()
//    }
//    
//    override func viewWillDisappear(animated: Bool) {
//        self.ekNavigationBar .removeFromSuperview()
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    
//    func initialSetup() {
//        self.navigationItem.hidesBackButton = true;
//        
//        currentWeightValue.text = "- Kcal"
//        smoothWeightLossValue.text = "- Kcal"
//        smoothWeightGainValue.text = "- Kcal"
//        fastWeightLossValue.text = "- Kcal"
//        calculateLabel.text = String(format:"C\nA\nL\nC\nU\nL\nA\nT\nE")
//        maleButton.selected = true
//        
//        
//        self.ekNavigationBar = NSBundle.mainBundle().loadNibNamed("CustomNavigationBarView", owner: self, options: nil)[0] as! CustomNavigationBarView
//        self.ekNavigationBar.frame = CGRectMake(0, 0, self.view.frame.size.width, self.ekNavigationBar.frame.size.height)
//        self.ekNavigationBar.createViewForData("Eatkart", index: 0, controller: self)
//        self.ekNavigationBar.sortButton!.hidden = true
//        
//        
//        ageTextField.layer.borderColor = UIColor(red: 106/255, green: 185/255, blue: 109/255, alpha: 1.0).CGColor
//        ageTextField.layer.borderWidth =  1.0
//        
//        weightTextField.layer.borderColor = UIColor(red: 106/255, green: 185/255, blue: 109/255, alpha: 1.0).CGColor
//        weightTextField.layer.borderWidth =  1.0
//        
//        heightTextField.layer.borderColor = UIColor(red: 106/255, green: 185/255, blue: 109/255, alpha: 1.0).CGColor
//        heightTextField.layer.borderWidth =  1.0
//        
//        self.bmrScrollView.hidden = true
//        let tapGesture = UITapGestureRecognizer(target: self, action: "activityViewTapped:");
//        activityView.addGestureRecognizer(tapGesture);
//        activityView.userInteractionEnabled = false;
//        activityView.alpha = 0.6
//        
//        
//        let tapToCaclulate = UITapGestureRecognizer(target: self, action: "calculateBMIAndBMR");
//        calculateLabel.addGestureRecognizer(tapToCaclulate);
//    }
//    
//    @IBAction func femaleButtonSelected(sender: AnyObject) {
//        
//        femaleButton.selected = true
//        maleButton.selected  = false
//    }
//    @IBAction func maleButtonSelected(sender: AnyObject) {
//        
//        maleButton.selected = true
//        femaleButton.selected = false
//    }
//    
//    func setIntialValue() {
//        
//        let data:NSData? = (NSUserDefaults.standardUserDefaults().objectForKey("BMIBMR") as? NSData)
//        if data != nil {
//           
//            bmiResult = NSKeyedUnarchiver .unarchiveObjectWithData(data!) as! BMIResult
//            
//            if bmiResult != nil {
//                if bmiResult.weight != nil {
//                    weightTextField.text = bmiResult.weight.stringValue
//                }
//                if bmiResult.height != nil {
//                    heightTextField.text = bmiResult.height.stringValue
//                }
//                if bmiResult.weight != nil {
//                    ageTextField.text = bmiResult.age.stringValue
//                }
//                
//                self.maleButton.selected = bmiResult.male.boolValue ? true :false
//                self.femaleButton.selected = bmiResult.male.boolValue ? false :true
//                
//            
//                if bmiResult.exerciseType != nil {
//                self.selectedActivityIndexPath = NSIndexPath(forRow: bmiResult.exerciseType.integerValue, inSection: 0)
//                    
//                    activityData = activityDataArray.objectAtIndex(bmiResult.exerciseType.integerValue) as! ActivityModel
//                    activityLabel.text = activityData.activityName;
//                    activityImage.image = UIImage(named: activityData.imageName)
//                    
//                    calculateBMIAndBMR()
//                    caculateBMRValues(bmiResult.exerciseType.integerValue)
//                }
//                
//                
//                
//            }
//            else {
//                self.calculatedBMI.text = "...."
//                self.idealBMI.text =  "...."
//                self.bmrValue.text = "...."
//            }
//        }
//        else {
//            self.calculatedBMI.text = "...."
//            self.idealBMI.text =  "...."
//            self.bmrValue.text = "...."
//        }
//        
//        
//    }
//    
//    /*
//    // MARK: - Navigation
//    
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//    // Get the new view controller using segue.destinationViewController.
//    // Pass the selected object to the new view controller.
//    }
//    */
//    
//    
//    func addSectionSegments() {
//        if (self.segmentedControl == nil) {
//            // Tying up the segmented control to a scroll view
//            self.segmentedControl = HMSegmentedControl(frame: CGRectMake(0, 2, screenSize.width, 44))
//            var titlesArray: [AnyObject] = NSMutableArray() as [AnyObject]
//            //        for (FoodCategory *category in self.categorylist) {
//            //            [titlesArray addObject: category.name];
//            //        }
//            titlesArray.append("BMI")
//            titlesArray.append("BMR")
//            //self.segmentedControl.sectionTitles = @[@"Breakfast", @"Dinner"];
//            self.segmentedControl.sectionTitles = titlesArray
//            self.segmentedControl.backgroundColor = UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1.0)
//            self.segmentedControl.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 94/255, green: 174/255, blue: 80/255, alpha: 1.0), NSFontAttributeName: UIFont.systemFontOfSize(16)]
//            self.segmentedControl.selectedTitleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 106/255, green: 185/255, blue: 109/255, alpha: 1.0), NSFontAttributeName: UIFont.systemFontOfSize(16)]
//            self.segmentedControl.selectionIndicatorColor = UIColor(red: 106/255, green: 185/255, blue: 109/255, alpha: 1.0)
//            self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe
//            self.segmentedControl.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
//            self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown
//            self.segmentedControl.selectionIndicatorBoxOpacity = 0.0
//            self.segmentedControl.selectionIndicatorHeight = 3.0
//            self.segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleFixed
//            self.segmentedControl.tag = 40320
//            self.segmentedControl.isAccessibilityElement = true
//            self.segmentView.addSubview(self.segmentedControl)
//            self.selectedIndex = 0
//        }
//        
//        segmentedControl.indexChangeBlock = {(index:Int) -> Void in
//            
//            switch index {
//            case 0:
//                //self.bmiScrollView .contentOffset = CGPointMake(0, 0)
//                self.orderType = kOrderTypeBreakFast
//                self.bmrScrollView.hidden = true
//                self.bmiScrollView.hidden = false
//                break
//                
//            case 1:
//                //self.bmiScrollView .contentOffset = CGPointMake(self.screenSize.width, 0)
//                self.orderType = kOrderTypeDinner
//                self.bmiScrollView.hidden = true
//                self.bmrScrollView.hidden = false
//                break
//                
//            default:
//                break
//            }
//        }
//        self.segmentedControl.selectedSegmentIndex = self.selectedIndex
//    }
//    
//    
//    func calculateBMIAndBMR() {
//        
//        weightTextField.resignFirstResponder()
//        heightTextField.resignFirstResponder()
//        ageTextField.resignFirstResponder()
//        
//        if validateTextFields() {
//            
//            if self.bmiResult == nil {
//                self.bmiResult = BMIResult()
//            }
//            bmICaclulatedValue = getBMI(Double(weightTextField.text!)!, height: Double(heightTextField.text!)!, age: 0)
//            calculatedBMI.text =  String(format:"%.2f", bmICaclulatedValue)
//            let height = Double(heightTextField.text!)!
//            let  idealWeightFrom:Double = ((18.5 * height * height) / 10000);
//            let idealWeightTo:Double =  ((24.9 * height * height) / 10000);
//            
//            self.idealBMI.text = String(format:"%.0f -  %.0f", idealWeightFrom,idealWeightTo)
//            
//            var message = ""
//            
//            switch bmICaclulatedValue {
//                
//            case bmICaclulatedValue where bmICaclulatedValue <= 18.5:
//                
//                self.underWeightView.layer.borderColor = UIColor(red: 106/255, green: 185/255, blue: 109/255, alpha: 1.0).CGColor
//                self.underWeightView.layer.borderWidth = 2.0;
//                
//                self.obeseView.layer.borderColor = UIColor.clearColor().CGColor
//                self.normalView.layer.borderColor = UIColor.clearColor().CGColor
//                self.overWeightView.layer.borderColor = UIColor.clearColor().CGColor
//                message = "You fall into UnderWeight category"
//                bodyType = 1
//                
//                break
//            case bmICaclulatedValue where bmICaclulatedValue <= 25.0 && bmICaclulatedValue > 18.5 :
//                self.underWeightView.layer.borderColor = UIColor.clearColor().CGColor
//                self.normalView.layer.borderColor = UIColor(red: 106/255, green: 185/255, blue: 109/255, alpha: 1.0).CGColor
//                self.normalView.layer.borderWidth = 2.0;
//                self.overWeightView.layer.borderColor = UIColor.clearColor().CGColor
//                self.obeseView.layer.borderColor = UIColor.clearColor().CGColor
//                message = "You fall into Normal category"
//                bodyType = 2
//                
//                break
//            case bmICaclulatedValue where bmICaclulatedValue <= 30.0 && bmICaclulatedValue > 25.0 :
//                self.underWeightView.layer.borderColor = UIColor.clearColor().CGColor
//                self.normalView.layer.borderColor = UIColor.clearColor().CGColor
//                self.overWeightView.layer.borderColor = UIColor(red: 106/255, green: 185/255, blue: 109/255, alpha: 1.0).CGColor
//                self.overWeightView.layer.borderWidth = 2.0;
//                
//                self.obeseView.layer.borderColor = UIColor.clearColor().CGColor
//                message = "You fall into OverWeight category"
//                bodyType = 3
//                
//                
//                break
//            case bmICaclulatedValue where bmICaclulatedValue  > 30 :
//                self.obeseView.layer.borderColor = UIColor(red: 106/255, green: 185/255, blue: 109/255, alpha: 1.0).CGColor
//                self.obeseView.layer.borderWidth = 2.0;
//                
//                self.underWeightView.layer.borderColor = UIColor.clearColor().CGColor
//                self.normalView.layer.borderColor = UIColor.clearColor().CGColor
//                self.overWeightView.layer.borderColor = UIColor.clearColor().CGColor
//                
//                message = "You fall into Obese category"
//                bodyType = 4
//                
//                break
//            default : break
//            }
//            
//            bmiResultDescription.text = message
//            
//            //BMR Cacluation
//            let bmr = getBMR(Double(weightTextField.text!)!, height: Double(heightTextField.text!)!, age: Int(ageTextField.text!)!, isMen: self.maleButton.selected)
//            
//            print(bmr);
//            bmrValue.text = String(format:"%d",Int(bmr))
//            bmrCaclulatedValue = Int(bmr)
//            
//           
//            
//            bmiResult.age = NSNumber(integer: Int(ageTextField.text!)!)
//            bmiResult.weight = NSNumber(integer: Int(weightTextField.text!)!)
//            bmiResult.height = NSNumber(integer: Int(heightTextField.text!)!)
//            
//            bmiResult.bmiValue = NSNumber(double:  Double(bmICaclulatedValue))
//            bmiResult.bmrValue = NSNumber(integer: Int(bmrCaclulatedValue))
//            bmiResult.bmiResultDescription = message
//            bmiResult.male = NSNumber(bool: maleButton.selected)
//            bmiResult.bodyType = NSNumber(integer: bodyType)
//
//            if selectedActivityIndexPath.row > 0  {
//                
//               self.caculateBMRValues(selectedActivityIndexPath.row)
//            }
//            
//            bmiResult.bmrResultDescription = self.bmrResultDescription.text;
//            activityView.userInteractionEnabled = true;
//            activityView.alpha = 1.0
//            
//            //NSData *personEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:personObject];
//            
//            let data = NSKeyedArchiver.archivedDataWithRootObject(bmiResult)
//            
//            NSUserDefaults.standardUserDefaults().setObject(data, forKey: "BMIBMR")
////            NSUserDefaults.standardUserDefaults().setObject(bmiResult.age, forKey: "age")
////            NSUserDefaults.standardUserDefaults().setObject(bmiResult.weight, forKey: "weight")
////            NSUserDefaults.standardUserDefaults().setObject(bmiResult.height, forKey: "height")
////            NSUserDefaults.standardUserDefaults().setObject(bmiResult.bmiValue, forKey: "bmiv")
////            NSUserDefaults.standardUserDefaults().setObject(bmiResult.bmrValue, forKey: "bmrv")
////            NSUserDefaults.standardUserDefaults().setObject(bmiResult.bmiResultDescription, forKey: "bmir")
////            NSUserDefaults.standardUserDefaults().setObject(bmiResult.bmrResultDescription, forKey: "bmrr")
////            NSUserDefaults.standardUserDefaults().setObject(bmiResult.male, forKey: "gender")
////            NSUserDefaults.standardUserDefaults().setObject(bmiResult.bodyType, forKey: "body")
//            
//            NSUserDefaults.standardUserDefaults().synchronize()
//            
//        }
//        else {
//            
//            showInvalidIputAlert()
//        }
//    }
//    
//    func showInvalidIputAlert() {
//        let alert = UIAlertController(title: "Eatkart", message: "Entries are invalid values must be:\n1. 6 < Weight 559 <\n2. 50 < Height < 320\n3. 1< Age < 150", preferredStyle: .Alert)
//        let yesButton: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: { (UIAlertAction) -> Void in
//        })
//        alert.addAction(yesButton)
//        self.presentViewController(alert, animated: true, completion: { _ in })
//    }
//    
//    func getBMI(weight: Double, height:Double, age :Int) ->Double {
//        return (weight / (height * height)) * 10000
//    }
//    
//    
//    func getBMR(weight: Double, height:Double, age :Int, isMen:Bool) ->Double {
//        
//        if isMen {
//            
//            let w  = (10 * weight)
//            let h =  (6.25 * height)
//            let a =   (5 * age)
//            
//            return  w + h - Double(a) + 5
//        }
//        else {
//            
//            let w  = (10 * weight)
//            let h =  (6.25 * height)
//            let a =   (5 * age)
//            
//            return  w + h - Double(a) - 161
//        }
//    }
//    
//    
//    
//    func validateTextFields() ->Bool {
//        
//        if let weight = weightTextField.text, let height = heightTextField.text, let age = ageTextField.text  where !weight.isEmpty &&  !height.isEmpty && !age.isEmpty && Double(weight) <= 559 && Double(weight) >= 6  && Double(height) <= 230 && Double(height) >= 50 && Int(age) <= 150 && Int(age) >= 1
//        {
//            
//            return true
//        }
//        else
//        {
//            return false
//        }
//        
//    }
//    
//    func addDoneButtonOnKeyboard()
//    {
//        let doneToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, screenSize.width, 44))
//        doneToolbar.barStyle = UIBarStyle.Default
//        
//        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
//        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("doneButtonAction"))
//        
//        let items = [flexSpace,done]
//        //items.addObject(flexSpace)
//        //items.addObject(done)
//        
//        doneToolbar.items = items
//        doneToolbar.sizeToFit()
//        
//        self.weightTextField.inputAccessoryView = doneToolbar
//        self.heightTextField.inputAccessoryView = doneToolbar
//        self.ageTextField.inputAccessoryView = doneToolbar
//        
//    }
//    
//    func doneButtonAction()
//    {
//        self.ageTextField.resignFirstResponder()
//        self.weightTextField.resignFirstResponder()
//        self.heightTextField.resignFirstResponder()
//    }
//    
//    
//    func createActivityDataArray() {
//        
//        let activity = ActivityModel()
//        activity.imageName = "activity.png"
//        activity.activityName = "Select Activity"
//        activityDataArray.addObject(activity)
//        
//        let activity1 = ActivityModel()
//        activity1.imageName = "activity1.png"
//        activity1.activityName = "Sedentary Activity"
//        activityDataArray.addObject(activity1)
//        
//        let activity2 = ActivityModel()
//        activity2.imageName = "activity2.png"
//        activity2.activityName = "Light Activity"
//        activityDataArray.addObject(activity2)
//        
//        let activity3 = ActivityModel()
//        activity3.imageName = "activity3.png"
//        activity3.activityName = "Moderate Activity"
//        activityDataArray.addObject(activity3)
//        
//        let activity4 = ActivityModel()
//        activity4.imageName = "activity4.png"
//        activity4.activityName = "Very Active"
//        activityDataArray.addObject(activity4)
//        
//        let activity5 = ActivityModel()
//        activity5.imageName = "activity5.png"
//        activity5.activityName = "Extremely Active"
//        activityDataArray.addObject(activity5)
//        
//    }
//    
//    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
//        
//        if ((textField.text?.characters.count)! + string.characters.count) <= 3 {
//            return true
//        }
//        else {
//            return false
//        }
//        
//        
//    }
//    
//    
//    func activityViewTapped(aSender: UITapGestureRecognizer) {
//        //UIButton *button = (UIButton*)sender;
//        if dropDownViewController == nil {
//            let lStoryboard: UIStoryboard = UIStoryboard(name: "LevelTwoDropDownStoryboard", bundle: nil)
//            self.dropDownViewController = lStoryboard.instantiateInitialViewController() as! DropDownViewController
//            dropDownViewController.delegate = self
//            self.dropDownViewController.preferredContentSize = CGSizeMake(280, 300)
//        }
//        
//        self.dropDownViewController.dataArray = activityDataArray as NSArray as [AnyObject]
//        self.dropDownViewController.selectedIndexPath = selectedActivityIndexPath
//        
//        if wyPopoverController == nil {
//            self.wyPopoverController = WYPopoverController(contentViewController: dropDownViewController)
//            self.wyPopoverController.delegate = self
//            self.wyPopoverController.passthroughViews = [aSender]
//            self.wyPopoverController.popoverLayoutMargins = UIEdgeInsetsMake(10, 10, 10, 10)
//            self.wyPopoverController.wantsDefaultContentAppearance = false
//        }
//        if wyPopoverController.popoverVisible {
//            wyPopoverController.dismissPopoverAnimated(true)
//            self.wyPopoverController.delegate = nil
//            self.wyPopoverController = nil
//        }
//        else {
//            ((wyPopoverController as WYPopoverController)).presentPopoverFromRect((aSender.view?.bounds)!, inView: aSender.view, permittedArrowDirections: WYPopoverArrowDirection.Down, animated: true)
//        }
//    }
//    
//    
//    func selectedIndexPath(aSelectedIndexPath: NSIndexPath, forObject aObject: AnyObject) {
//        if (aObject.isKindOfClass(ActivityModel)) {
//            self.selectedActivityIndexPath = aSelectedIndexPath
//            self.activityData = aObject as! ActivityModel
//            activityLabel.text = self.activityData.activityName
//            activityImage.image = UIImage(named: activityData.imageName)
//            if selectedActivityIndexPath.row > 0 {
//                self.caculateBMRValues(aSelectedIndexPath.row)
//            }
//        }
//        wyPopoverController.dismissPopoverAnimated(true)
//        self.wyPopoverController.delegate = nil
//        self.wyPopoverController = nil
//    }
//    
//    func popoverControllerShouldDismissPopover(popoverController: WYPopoverController) -> Bool {
//        return true
//    }
//    
//    func popoverControllerDidDismiss(controller: WYPopoverController) {
//        self.wyPopoverController.delegate = nil
//        self.wyPopoverController = nil
//    }
//    
//    func caculateBMRValues(index: Int) {
//        
//        let multiplier = [1.2003, 1.375, 1.5499, 1.7250, 1.9];
//        
//        let weightloseFactor = -497;
//        let fastWeightlostFactor = -993;
//        let smoothWeightGainFactor = 507;
//        
//        let requiredMaintainCurrentWeight = multiplier[index - 1] * Double(bmrCaclulatedValue);
//        if requiredMaintainCurrentWeight > 0 {
//         currentWeightValue.text =   String(format:"%d Kcal",Int(requiredMaintainCurrentWeight))
//        }
//        
//        
//        var weightValue1 = 0
//        var weightValue2 = 0
//        var weightValue3 = 0
//        if (requiredMaintainCurrentWeight > 0) {
//            weightValue1 =  (Int(requiredMaintainCurrentWeight) + weightloseFactor);
//            weightValue2 =  (Int(requiredMaintainCurrentWeight) + fastWeightlostFactor);
//            weightValue3 =   (Int(requiredMaintainCurrentWeight) + smoothWeightGainFactor);
//        }
//        
//        
//        if weightValue1 < 1493 && Int(requiredMaintainCurrentWeight) > 0 {
//           weightValue1 = 1493
//        }
//        if weightValue2 < 1493 && Int(requiredMaintainCurrentWeight) > 0 {
//           weightValue2 = 1493
//        }
//        if weightValue3 < 1493 && Int(requiredMaintainCurrentWeight) > 0 {
//          weightValue3 = 1493;
//        }
//        if weightValue1 > 0 {
//          smoothWeightLossValue.text =   String(format:"%d Kcal",weightValue1)
//        }
//        if weightValue2 > 0 {
//        fastWeightLossValue.text =   String(format:"%d Kcal",weightValue2)
//        }
//        if weightValue3 > 0 {
//        smoothWeightGainValue.text =   String(format:"%d Kcal",weightValue3)
//        }
//        
//        var message = ""
//        
//        if bodyType == 1 && weightValue1 > 0 {//Under weight
//            message = message + "We recommend you smooth weight gain";
//        } else if (bodyType == 2 && requiredMaintainCurrentWeight > 0) {//Normal
//            message = message + "We recommend you maintain current weight";
//        } else if (bodyType == 3 && weightValue2 > 0) {//Over weight
//            message = message + "We recommend you smooth weight loss";
//        } else if (bodyType == 4 && weightValue3 > 0) {//Obese
//            message = message + "We recommend you fast weight loss";
//        }
//        
//        bmrResultDescription.text = message;
//        
//        bmiResult.bmrResultDescription = self.bmrResultDescription.text;
//        bmiResult.exerciseType = NSNumber(integer: index)
//        
//        //NSData *personEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:personObject];
//        
//        let data = NSKeyedArchiver.archivedDataWithRootObject(bmiResult)
//        
//        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "BMIBMR")
//    }
//    
//    
//    func backButtonTapped(sender: UIButton) {
//        self.navigationController!.popViewControllerAnimated(true)
//    }
//    
//    //
//    //    public double getBMR(double weight/*KG*/, double height/*cm*/, double age/*years*/, boolean isMen) {
//    //    if (isMen)
//    //    return 10 * weight + 6.25 * height - 5 * age + 5;
//    //    else
//    //    return 10 * weight + 6.25 * height - 5 * age - 161;
//    //    }
//    //
//    //    public double getBMI(double weight/*KG*/, double height/*cm*/) {
//    //    return (weight / (height * height)) * 100 * 100;
//    //    }
}



