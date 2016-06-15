//
//  SingleCell.swift
//  HungerBell
//
//  Created by pankaj.jha on 6/10/16.
//  Copyright © 2016 Times Internet Limited. All rights reserved.
//

import UIKit

class SingleCell: UITableViewCell, UITextFieldDelegate {

    
    @IBOutlet weak var infotextfield:UITextField!
    var indexPath:NSIndexPath!
    var controller:UIViewController!;
    var tableView:UITableView!;
    weak var delegate:SingleCellDelagte?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func createDate(data:AnyObject, indexPath:NSIndexPath, tableView:UITableView,controller:UIViewController) {
        self.indexPath = indexPath;
        self.controller = controller;
        self.tableView = tableView;
        self.infotextfield.delegate = self;
    }


    func textFieldDidBeginEditing(textField: UITextField) {
        

        
    }
    func textFieldDidEndEditing(textField: UITextField) {
        
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        return true;
    }
    func textFieldShouldClear(textField: UITextField) -> Bool {
        
        return true;
    }
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        
        return true;
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        return true;
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder();
        return true;
    }
    

}


@objc protocol SingleCellDelagte {
   optional  func textField(textField: UITextField, didBeginEditingOnIndexPath anIndexPath: NSIndexPath, tableView: UITableView)
    
    
   optional func textField(textField: UITextField, didEndEditingOnIndexPath anIndexPath: NSIndexPath, tableView: UITableView)
    
    
  optional  func textField(textField: UITextField, shouldBeginEditingOnIndexPath anIndexPath: NSIndexPath, tableView: UITableView) -> Bool
    
   optional func textField(textField: UITextField, shouldReturnOn anIndexPath: NSIndexPath, tableView: UITableView) -> Bool
}