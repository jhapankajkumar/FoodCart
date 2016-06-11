//
// FoodItem.swift
// HungerBell
//
// Created by pankaj.jha on 6/10/16.
// Copyright © 2016 Times Internet Limited. All rights reserved.
//

import UIKit
import ObjectMapper

class FoodItem: NSObject, Mappable {
 
 var itemId :NSNumber!
 var name :NSString!
 var calory :NSNumber!
 var isNonVeg :NSNumber!
 var price :NSNumber!
 var isDiscountAvailable :NSNumber!
 var islastItem :NSNumber!
 var pieces :NSNumber!
 var rating :NSNumber!
 var priority :NSNumber!
 var category :NSString!
 var itemDescription :NSString!
 var orderCount :NSInteger!
 var packaginCharges :NSString!
 var fatType :NSString!
 var quantityUnit :NSString!
 
 required init?(_ map : Map) {
 
 }
 
 func mapping(map: Map) {
 
     itemId <- map["id"]
     name <- map["nm"]
     calory <- map["cal"]
     isNonVeg <- map["vgt"]
     price <- map["pr"]
     isDiscountAvailable <- map["ida"]
     islastItem <- map["ili"]
     pieces <- map["ps"]
     rating <- map["rat"]
     priority <- map["od"]
     category <- map["cat"]
     itemDescription <- map["des"]
     orderCount <- map["orderCount"]
     packaginCharges <- map["pkgc"]
     fatType <- map["ft"]
     quantityUnit <- map["qu"]
 }
 
}
