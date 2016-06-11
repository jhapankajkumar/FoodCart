//
//  DropDownViewController.swift
//  HungerBell
//
//  Created by pankaj.jha on 6/11/16.
//  Copyright © 2016 Times Internet Limited. All rights reserved.
//

import UIKit

class DropDownViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var listTableView: UITableView!
    
    var dataArray:NSArray!
    var selectedIndexPath:NSIndexPath!
    var delegate:DropDownViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        listTableView .reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  dataArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier: String = "levelTwoCell"
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)!
        /*
         if (cell == nil) {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_cellIdentifier];
         }
         */
        let label: UILabel = (cell.viewWithTag(1001) as! UILabel)
        var imageView: UIImageView? = (cell.viewWithTag(1002) as! UIImageView)
        let object: AnyObject = dataArray[indexPath.row]
        if (object is SectorModel) {
            label.text = (object as! SectorModel).sectorName  as String
            imageView = nil
        }
        else if (object is SocietyModel) {
            label.text = (object as! SocietyModel).societyName as String
            imageView = nil
        }
        else {
            cell.imageView!.image = nil
            label.text = (object as! ActivityModel).activityName as String
            
            imageView!.image = UIImage(named: (object as! ActivityModel).imageName as String)
        }
        
        if self.selectedIndexPath != nil && self.selectedIndexPath.isEqual(indexPath) {
            label.textColor = UIColor.blackColor()
        }
        else {
            label.textColor = UIColor.blackColor()
        }
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedIndexPath = indexPath
        let object: AnyObject = dataArray[selectedIndexPath.row]
        if let delegate = self.delegate {
            delegate.indePathSelected!(selectedIndexPath, object: object)
        }
    }

}

@objc protocol DropDownViewControllerDelegate {
   optional func indePathSelected(indexPath:NSIndexPath, object:AnyObject )
}
