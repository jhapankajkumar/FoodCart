//
//  ClassProperty.swift
//  HungerBell
//
//  Created by pankaj.jha on 6/16/16.
//  Copyright © 2016 Times Internet Limited. All rights reserved.
//

import UIKit

class ClassProperty: NSObject {
    static let sharedInstance = ClassProperty()
    
    var propertyCache:NSCache = NSCache()
    
    internal func getPropertyDictionaryForClass(aClass:AnyObject) -> [String:String]? {
        
        if let dict:[String:String] =  self.getClassPropertyDictionaryFromCache(aClass) {
            return dict
        }
        else {
            var propertyDictionary:[String:String] = [String:String]()
            for c in Mirror(reflecting: aClass).children
            {
                if let name = c.label{
                    propertyDictionary[name] = name
                }
            }
            
            self.addClassPropertyDictionaryToCache(propertyDictionary, forClass: aClass)
            
            return propertyDictionary;
        }
    }
    
    func addClassPropertyDictionaryToCache(propertyDictionary: [String : String], forClass aClass: AnyObject) {
        self.propertyCache.setObject(propertyDictionary, forKey: aClass)
    }
    
    func getClassPropertyDictionaryFromCache(aClass: AnyObject) -> [String : String]? {
        
        if let value:[String:String] = self.propertyCache.objectForKey(aClass) as? [String:String] {
            return value
        }
        else {
            return nil
        }
    }
}
