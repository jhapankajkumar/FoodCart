//
//  BaseObject.swift
//  HungerBell
//
//  Created by pankaj.jha on 6/17/16.
//  Copyright © 2016 Times Internet Limited. All rights reserved.
//

import UIKit

class BaseObject: NSObject,NSCoding {
    
    func encodeWithCoder(aCoder: NSCoder) {
        self.autoEncodeWithCoder(aCoder)
    }
    required convenience  init?(coder aDecoder: NSCoder) {
        self.init()
        self.autoDecode(aDecoder)
    }
    
}


extension NSObject {
    
    func autoEncodeWithCoder(coder:NSCoder) {
        let propertyDictionary = ClassProperty.sharedInstance.getPropertyDictionaryForClass(self.classForCoder)
        for key:String in (propertyDictionary?.keys)! {
            coder.encodeObject(self.valueForKey(key)?.valueForKey(key))
        }
    }
    
    func autoDecode(coder:NSCoder) {
        let propertyDictionary = ClassProperty.sharedInstance.getPropertyDictionaryForClass(self.classForCoder)
        for key:String in (propertyDictionary?.keys)! {
            object_setIvar(self, Ivar.init((key as NSString).UTF8String), coder.decodeObjectForKey(key))
        }
    }
    
}
