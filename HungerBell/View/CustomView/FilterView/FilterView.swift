//
//  FilterView.swift
//  HungerBell
//
//  Created by pankaj.jha on 6/10/16.
//  Copyright © 2016 Times Internet Limited. All rights reserved.
//

import UIKit

class FilterView: UIView {

    
    @IBOutlet weak var allTitle: UILabel!
    @IBOutlet weak var vegTitle: UILabel!
    @IBOutlet weak var nonVegTitle: UILabel!
    
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var vegButton: UIButton!
    @IBOutlet weak var nonVegButton: UIButton!

    var sortType:SortType!
    weak var controller:AnyObject!

    
    override func awakeFromNib() {
        self.allButton.selected = true
        self.sortType = .kSortTypeAll
        let alltapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FilterView.allTitleTapped(_:)))
        self.allTitle.addGestureRecognizer(alltapGesture)
        let vegtapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FilterView.vegTitleTapped(_:)))
        self.vegTitle.addGestureRecognizer(vegtapGesture)
        let nonvegtapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FilterView.nonVegTitleTapped(_:)))
        self.nonVegTitle.addGestureRecognizer(nonvegtapGesture)
        let backgroundViewTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FilterView.backgroundViewTapped(_:)))
        self.addGestureRecognizer(backgroundViewTap)
    }
    
    func allTitleTapped(recongnizer: UITapGestureRecognizer) {
        self.seclectionChanged(self.allButton)
    }
    
    func vegTitleTapped(recongnizer: UITapGestureRecognizer) {
        self.seclectionChanged(self.vegButton)
    }
    
    func nonVegTitleTapped(recongnizer: UITapGestureRecognizer) {
        self.seclectionChanged(self.nonVegButton)
    }
    
    func backgroundViewTapped(recongnizer: UITapGestureRecognizer) {
        self.removeFromSuperview()
    }
    
    func setUpDateWithSortType(sortType: SortType) {
        if sortType == .kSortTypeAll {
            self.allButton.selected = true
        }
        else if sortType == .kSortTypeNonVeg {
            self.nonVegButton.selected = true
        }
        else if sortType == .kSortTypeVeg {
            self.vegButton.selected = true
        }
        
    }
    
    @IBAction func seclectionChanged(sender: UIButton) {
        switch sender.tag {
        case 1001:
            if sender.selected == false {
                self.allButton.selected = true
                self.vegButton.selected = false
                self.nonVegButton.selected = false
                self.sortType = .kSortTypeAll
            }
            
        case 1002:
            if sender.selected == false {
                self.allButton.selected = false
                self.vegButton.selected = true
                self.nonVegButton.selected = false
                self.sortType = .kSortTypeVeg
            }
            
        case 1003:
            if sender.selected == false {
                self.allButton.selected = false
                self.vegButton.selected = false
                self.nonVegButton.selected = true
                self.sortType = .kSortTypeNonVeg
            }
            
        default:
            break
        }
        
        if (self.controller is ItemListViewController) {
            (self.controller as! ItemListViewController).reloadDataWithSortType(self.sortType)
        }
        else {
            //(self.controller as! SubItemListViewController).reloadDataWithSortType(self.sortType)
        }
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
