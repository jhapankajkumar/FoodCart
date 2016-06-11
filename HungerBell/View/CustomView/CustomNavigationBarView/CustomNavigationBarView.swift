//
//  CustomNavigationBarView.swift
//  HungerBell
//
//  Created by pankaj.jha on 6/10/16.
//  Copyright © 2016 Times Internet Limited. All rights reserved.
//

import UIKit

class CustomNavigationBarView: UIView {

    @IBOutlet weak var backButton: UIButton!

    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var title: UILabel!

    func createViewForData(aData:AnyObject,controller:AnyObject) {
        self.title.text = aData as? String
        self.backgroundColor = Constant.THEME_COLOR();
        self.backButton.addTarget(controller, action: Selector("backButtonTapped:"), forControlEvents: .TouchUpInside)
    }
    
//    - (void)createViewForData:(id)aData index:(NSInteger)index controller:(id)controller;
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
