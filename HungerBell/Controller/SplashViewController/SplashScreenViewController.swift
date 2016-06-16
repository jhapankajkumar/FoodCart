//
//  SplashScreenViewController.swift
//  HungerBell
//
//  Created by pankaj.jha on 6/10/16.
//  Copyright © 2016 Times Internet Limited. All rights reserved.
//

import UIKit
import RESideMenu



class SplashScreenViewController: UIViewController {
    @IBOutlet weak var backgroundImage: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBarHidden = true
        // Check in runtime that is it a 4 inch or 3.5 and accordingly add background image to it.
        if Constant.IS_IPHONE_5 {
            self.backgroundImage.image = UIImage(named: "Default-568h@2x.png")
        }
        else if Constant.IS_IPHONE_6 {
            self.backgroundImage.image = UIImage(named: "Default-667h@2x.png")
        }
        else {
            self.backgroundImage.image = UIImage(named: "Default.png")
        }
        
        let prefs: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        
        guard let sector:NSString? = prefs.objectForKey(Constant.kSector_Key) as? NSString
            else {
                print("fata hua error")
        }
        
        guard let society:NSString? = prefs.objectForKey(Constant.kSociety_Key) as? NSString
            else {
                print("fata hua error")
        }
        
        
        if  sector?.length > 0 && society?.length > 0 {
            self.performSelector(#selector(SplashScreenViewController.gotoHomeScreen), withObject: nil, afterDelay: 1.0)
        }
        else {
            self.performSegueWithIdentifier("SplashScreenToLocationScreen", sender: self)
        }
    }
    
    func gotoHomeScreen() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        _ = storyBoard .instantiateViewControllerWithIdentifier("SettingsViewController")
        let homeScreenViewController = storyBoard .instantiateViewControllerWithIdentifier("HomeScreenViewController")
        self.navigationController?.popToRootViewControllerAnimated(false);
        let sideMenuViewController = RESideMenu(contentViewController: homeScreenViewController, leftMenuViewController: nil, rightMenuViewController: nil);
        self.navigationController?.pushViewController(sideMenuViewController, animated: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
