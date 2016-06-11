//
//  FoodCategory.swift
//  HungerBell
//
//  Created by pankaj.jha on 6/10/16.
//  Copyright © 2016 Times Internet Limited. All rights reserved.
//

import UIKit
import ObjectMapper

class FoodCategory: NSObject, Mappable {
    
    var name:NSString!
    var order:NSNumber!
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        name    <- map["name"]
        order  <- map["oder"]
        
    }
    
    
}
