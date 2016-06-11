//
//  EKNavigationBar.swift
//  HungerBell
//
//  Created by pankaj.jha on 6/10/16.
//  Copyright © 2016 Times Internet Limited. All rights reserved.
//

import UIKit



class EKNavigationBar: UIView {
    
    
    @IBOutlet weak var sectionButton: UIButton!
    @IBOutlet weak var title: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    static func viewForData()->CGFloat {
        return 60
    }
    
    static func rectForData()->CGRect {
        return CGRectMake(0, 0, 320, 44);
    }
    
    func createViewForData(aData: AnyObject, index:NSInteger, controller: AnyObject) -> Void {
        title.text = aData as! NSString as String
        
        //self.backgroundColor = THEME_COLOR;
        
        self.sectionButton.addTarget(controller,action:Selector("menuButtonTapped:"), forControlEvents: .TouchUpInside)
    }
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
}
