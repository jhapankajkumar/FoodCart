//
//  CacheData.swift
//  HungerBell
//
//  Created by pankaj.jha on 6/11/16.
//  Copyright © 2016 Times Internet Limited. All rights reserved.
//

import UIKit
import ObjectiveC

class CacheData: BaseObject {
    
    var cacheCreatedDateTime :NSDate!
    var cachedData:AnyObject!
    var infoDictionary:NSDictionary!
    
   init(aCacheCreateDateTime:NSDate, aCacheData:AnyObject) {
    
        cacheCreatedDateTime = aCacheCreateDateTime;
        cachedData = aCacheData;
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}



