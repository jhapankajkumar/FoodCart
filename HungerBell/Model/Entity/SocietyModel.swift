//
//  SocietyModel.swift
//  HungerBell
//
//  Created by pankaj.jha on 6/10/16.
//  Copyright © 2016 Times Internet Limited. All rights reserved.
//

import UIKit
import ObjectMapper

class SocietyModel: NSObject, Mappable {
    var societyId:NSNumber!
    var societyName:NSString!
    var sector:NSString!
    
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        societyId    <- map["id"]
        societyName  <- map["nm"]
        sector <- map["st"]
    }
    
}
