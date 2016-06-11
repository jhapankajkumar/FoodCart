//
//  InitialViewController.swift
//  HungerBell
//
//  Created by pankaj.jha on 6/11/16.
//  Copyright © 2016 Times Internet Limited. All rights reserved.
//

import UIKit
import WYPopoverController
import MBProgressHUD
import RESideMenu

class InitialViewController: UIViewController,DropDownViewControllerDelegate,WYPopoverControllerDelegate {
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var societyButton: UIButton!
    @IBOutlet weak var sectorButton: UIButton!
    
    
    var sectorDataArray:NSArray!
    var societyDataArray:NSArray!
    var sectorData:SectorModel!
    var societyData:SocietyModel!
    var selectedSectorIndexPath:NSIndexPath!
    var selectedSocietyIndexPath:NSIndexPath!
    var dropDownViewController:DropDownViewController!
    var wyPopoverController:WYPopoverController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        DataFetchManager.sharedInstance .fetchSectorDataWithCompletionBlock() { (result, sectors) in
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            if result == true && sectors!.count > 0 {
                self.sectorDataArray =  sectors
            }
            
        }
        
        self.sectorButton.tag = 0
        self.societyButton.tag = 1
        self.societyButton.userInteractionEnabled = false
        self.societyButton.alpha = 0.5
        sectorButton.addTarget(self, action: #selector(InitialViewController.sectorOrSocietyButtonTapped(_:)), forControlEvents: .TouchUpInside)
        societyButton.addTarget(self, action: #selector(InitialViewController.sectorOrSocietyButtonTapped(_:)), forControlEvents: .TouchUpInside)
        saveButton.addTarget(self, action: #selector(InitialViewController.saveButtonTapped), forControlEvents: .TouchUpInside)

    }
    
    
    func sectorOrSocietyButtonTapped(aSender: UIButton) {
        //UIButton *button = (UIButton*)sender;
        if self.dropDownViewController == nil {
            let lStoryboard: UIStoryboard = UIStoryboard(name: "DropDownStoryboard", bundle: nil)
            
            self.dropDownViewController = lStoryboard.instantiateInitialViewController() as! DropDownViewController
            dropDownViewController.delegate = self
            self.dropDownViewController.preferredContentSize = CGSizeMake(280, 300)
        }
        if aSender.tag == 0 {
            self.dropDownViewController.dataArray = sectorDataArray
            self.dropDownViewController.selectedIndexPath = selectedSectorIndexPath
        }
        else {
            self.dropDownViewController.dataArray = societyDataArray
            self.dropDownViewController.selectedIndexPath = selectedSocietyIndexPath
        }
        if self.wyPopoverController == nil {
            self.wyPopoverController = WYPopoverController(contentViewController: dropDownViewController)
            self.wyPopoverController.delegate = self
            self.wyPopoverController.passthroughViews = [aSender]
            self.wyPopoverController.popoverLayoutMargins = UIEdgeInsetsMake(10, 10, 10, 10)
            self.wyPopoverController.wantsDefaultContentAppearance = false
        }
        if wyPopoverController.popoverVisible == true {
            wyPopoverController.dismissPopoverAnimated(true)
            self.wyPopoverController.delegate = nil
            self.wyPopoverController = nil
        }
        else {
            ((wyPopoverController as WYPopoverController)).presentPopoverFromRect(aSender.bounds, inView: aSender, permittedArrowDirections: .Up, animated: true)
        }
    }
    
    func saveButtonTapped() {
        if self.sectorData != nil && self.societyData != nil {
            let prefs: NSUserDefaults = NSUserDefaults.standardUserDefaults()
            prefs.setObject(sectorData.sectorName, forKey: Constant.kSector_Key)
            prefs.setObject(societyData.societyName, forKey: Constant.kSociety_Key)
            prefs.synchronize()
            let userData: UserDetail = UserDetail()
            userData.sec = sectorData.sectorName
            userData.soc = societyData.societyName
            userData.dId = UniqueDeviceIdentifier.sharedInstance.getUUID()
            guard let token:NSString? = NSUserDefaults.standardUserDefaults().objectForKey("GCMTOKEN") as? NSString
                else {
                    print("fata hua error")
            }
            userData.gTkn = token
            MBProgressHUD.showHUDAddedTo(self.view!, animated: true)
            
            self.gotoHomeScreen()
            
//            DataFetchManager.sharedInstance().saveUserDetail(userData, withCompletionBlock: {(referalCode: String, error: NSError) -> Void in
//                MBProgressHUD.hideAllHUDsForView(self.view!, animated: true)
//                if !error {
//                    NSUserDefaults.standardUserDefaults().setObject(referalCode, forKey: "refralCode")
//                    NSUserDefaults.standardUserDefaults().synchronize()
//                }
//                self.gotoHomeScreen()
//            })
        }
        else {
//            var message: String? = nil
//            if sectorData == nil {
//                message = "Please Select Sector"
//            }
//            else {
//                message = "Please Select Society"
//            }
//            var alertController: UIAlertController = UIAlertController.alertControllerWithTitle("EatKart", message: message!, preferredStyle: .Alert)
//            var ok: UIAlertAction = UIAlertAction.actionWithTitle("OK", style: .Default, handler: nil)
//            alertController.addAction(ok)
//            self.presentViewController(alertController, animated: true, completion: { _ in })
        }
    }
    
    func gotoHomeScreen() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let settingsController: SettingsViewController = (mainStoryboard.instantiateViewControllerWithIdentifier("SettingsViewController") as! SettingsViewController)
        let homeScreen: HomeScreenViewController = (mainStoryboard.instantiateViewControllerWithIdentifier("HomeScreenViewController") as! HomeScreenViewController)
        let sideMenuViewController = RESideMenu(contentViewController: CustomNavigationViewController(rootViewController: homeScreen), leftMenuViewController: CustomNavigationViewController(rootViewController: settingsController), rightMenuViewController: nil)
        //sideMenuViewController.backgroundImage = [UIImage imageNamed:@"Stars"];
        //sideMenuViewController.delegate = homeScreen;
        self.navigationController!.pushViewController(sideMenuViewController, animated: false)
        //sideMenuViewController.backgroundImage = [UIImage imageNamed:@"bg.png"];
        // Make it a root controller
        //
        //self.window.rootViewController = sideMenuViewController;
    }
    
   @objc func indePathSelected(indexPath: NSIndexPath, object: AnyObject) {
        if (object is SectorModel) {
            self.selectedSectorIndexPath = indexPath
            self.sectorData = object as! SectorModel
            sectorButton.setTitle(sectorData.sectorName as String, forState: .Normal)
            self.societyDataArray = nil
            self.societyData = nil
            self.societyButton.userInteractionEnabled = false
            self.societyButton.alpha = 0.5
            societyButton.setTitle("Select Society", forState: .Normal)
            MBProgressHUD.showHUDAddedTo(Constant.SharedAppDelegate.window, animated: true)
            
            DataFetchManager.sharedInstance.fetchSocietyDataWithForSector(sectorData.sectorName, completionHandler: { (result, societes) in
                MBProgressHUD.hideAllHUDsForView(Constant.SharedAppDelegate.window, animated: true)
                if result == true && societes != nil && societes?.count > 0 {
                    self.societyDataArray = societes! as NSArray
                    self.societyButton.userInteractionEnabled = true
                    self.societyButton.alpha = 1.0
                }
            })
        }
        else {
            self.selectedSocietyIndexPath = indexPath
            self.societyData = object as! SocietyModel
            societyButton.setTitle(societyData.societyName as String, forState: .Normal)
        }
        wyPopoverController.dismissPopoverAnimated(true)
        self.wyPopoverController.delegate = nil
        self.wyPopoverController = nil
    }
    
    func popoverControllerShouldDismissPopover(popoverController: WYPopoverController) -> Bool {
        return true
    }
    
    func popoverControllerDidDismiss(controller: WYPopoverController) {
        self.wyPopoverController.delegate = nil
        self.wyPopoverController = nil
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
