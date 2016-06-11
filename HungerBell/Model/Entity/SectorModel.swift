//
//  SectorModel.swift
//  HungerBell
//
//  Created by pankaj.jha on 6/10/16.
//  Copyright © 2016 Times Internet Limited. All rights reserved.
//

import UIKit
import ObjectMapper
class SectorModel: NSObject, Mappable {
    var sectorId:NSNumber!
    var sectorName:NSString!
    
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        sectorId    <- map["id"]
        sectorName  <- map["nm"]
    }
}
