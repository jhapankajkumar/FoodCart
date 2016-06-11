//
//  SuggesionAndComplainViewController.swift
//  EatKart
//
//  Created by pankaj.jha on 4/16/16.
//  Copyright © 2016 EatKart. All rights reserved.
//

import UIKit

@objc class SuggesionAndComplainViewController: UIViewController,UITextViewDelegate {/*

    @IBOutlet weak var infolabel: UILabel!
    @IBOutlet weak var suggesionSubmitButton: UIButton!
    @IBOutlet weak var suggesionTextView: UITextView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var complainTextView: UITextView!
    let suggesion =  "Suggest us what you feel"
    let complains =  "Write your complain"
    @IBOutlet weak var complainSubmitButton: UIButton!
    let screenSize = UIScreen.mainScreen().bounds.size
    
    @IBOutlet weak var containerScrollView: UIScrollView!
    var ekNavigationBar = EKNavigationBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set navigation bar view
        self.ekNavigationBar = NSBundle.mainBundle().loadNibNamed("EKNavigationBar", owner: self, options: nil)[0] as! EKNavigationBar
        self.ekNavigationBar.frame = CGRectMake(0, 0, self.view.frame.size.width, self.ekNavigationBar.frame.size.height)
        self.ekNavigationBar.createViewForData("Suggesion & Complain", index: 0, controller: self)
        //    self.submitButton.layer.cornerRadius = 4.0;
        self.suggesionSubmitButton.layer.borderColor = UIColor(red: 106/255.0 , green: 185/255.0, blue: 109/255.0, alpha: 1.0) .CGColor
        self.complainSubmitButton.layer.borderColor = UIColor(red: 106/255.0 , green: 185/255.0, blue: 109/255.0, alpha: 1.0) .CGColor
        // Do any additional setup after loading the view.
        let toolBar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, screenSize.width, 44))
        toolBar.barStyle = .Default
        let barButtonDone: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .Done, target: self, action: "doneButtonTapped:")
        let fixedItem: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        toolBar.items = [fixedItem, barButtonDone]
        barButtonDone.tintColor = UIColor.blackColor()
        self.suggesionTextView.inputAccessoryView = toolBar
        self.complainTextView.inputAccessoryView = toolBar
        self.suggesionTextView.text = suggesion
        self.suggesionTextView.textColor = UIColor.lightGrayColor()
        self.complainTextView.text = complains
        self.complainTextView.textColor = UIColor.lightGrayColor()


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.addSubview(self.ekNavigationBar)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.ekNavigationBar.removeFromSuperview()
    }
    
    func doneButtonTapped(item: UIBarButtonItem) {
        //[self.view endEditing:YES];
        if (self.suggesionTextView.isFirstResponder()) && (self.suggesionTextView.text.characters.count == 0) {
            self.suggesionTextView.textColor = UIColor.lightGrayColor()
            self.suggesionTextView.text = suggesion
            self.suggesionTextView.resignFirstResponder()
        }
        else if (self.complainTextView.text.characters.count == 0) && (self.complainTextView.isFirstResponder() == true) {
            self.complainTextView.textColor = UIColor.lightGrayColor()
            self.complainTextView.text = complains
            self.complainTextView.resignFirstResponder()
        }
        self.containerScrollView.setContentOffset(CGPointMake(0, 0), animated: true)
        self.view.endEditing(true)
    }
    
    func menuButtonTapped(button: UIButton) {
        self.sideMenuViewController.presentLeftMenuViewController()
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        if textView == self.suggesionTextView && (textView.text! == suggesion) {
            textView.text = ""
            textView.textColor = UIColor.blackColor()
            
            
        }
        else if textView == self.complainTextView {
            
            if textView.text! == complains {
                textView.text = ""
                textView.textColor = UIColor.blackColor()
            }
            self.containerScrollView.setContentOffset(CGPointMake(0, 100), animated: true)
        }
        
        
        return true
    }
    
    func textViewDidChange(textView: UITextView) {
        if textView.text.characters.count == 0 && textView == self.suggesionTextView {
            textView.textColor = UIColor.lightGrayColor()
            textView.text = suggesion
            textView.resignFirstResponder()
        }
        else if textView.text.characters.count == 0 && textView == self.complainTextView {
            textView.textColor = UIColor.lightGrayColor()
            textView.text = complains
            textView.resignFirstResponder()
        }
        
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if textView.text.characters.count + text.characters.count <= 150 {
            return true
        }
        return false
    }
    
   @IBAction func submitSuggesion(sender: AnyObject) {
        
    self.containerScrollView.setContentOffset(CGPointMake(0, 0), animated: true)
        let trimmedString = self.suggesionTextView.text.stringByTrimmingCharactersInSet(
            NSCharacterSet.whitespaceAndNewlineCharacterSet()
        )
        
        if trimmedString.characters.count > 0 {
            self.view.endEditing(true)
            DataFetchManager.sharedInstance().submitSuggesionOrComplain(self.suggesionTextView.text, wihtCompletionBlock: { (success:Bool) -> Void in
                
                let alert = UIAlertController(title: "Eatkart", message: "Thank You for taking the time to write to us. EatKart team is greatfull for your suggesion and helping us to create new and imporved services.", preferredStyle: .Alert)
                let yesButton: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: { (UIAlertAction) -> Void in
                })
                alert.addAction(yesButton)
                self.presentViewController(alert, animated: true, completion: { _ in })
                
            })
        }
        
       
    }
    
    @IBAction func submitComplain(sender: AnyObject) {
        let trimmedString = self.complainTextView.text.stringByTrimmingCharactersInSet(
            NSCharacterSet.whitespaceAndNewlineCharacterSet()
        )
        
        if trimmedString.characters.count > 0 {
            self.view.endEditing(true)
            DataFetchManager.sharedInstance().submitSuggesionOrComplain(self.complainTextView.text, wihtCompletionBlock: { (success:Bool) -> Void in
                let alert = UIAlertController(title: "Eatkart", message: "EatKart appreciate customers who let us know when things are'n right. EatKart team appreciate the opportunity to resolve your query.", preferredStyle: .Alert)
                let yesButton: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: { (UIAlertAction) -> Void in
                })
                alert.addAction(yesButton)
                self.presentViewController(alert, animated: true, completion: { _ in })
            })
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
 */
}
