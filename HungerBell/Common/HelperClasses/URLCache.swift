//
//  URLCache.swift
//  HungerBell
//
//  Created by pankaj.jha on 6/17/16.
//  Copyright © 2016 Times Internet Limited. All rights reserved.
//

import UIKit

import Archiver

class URLCache: NSObject {
    
    static let sharedInstance = URLCache()
    let URLCacheInterval:NSTimeInterval =  600
    var dataCache:NSCache!
    var imageCache:NSCache!
    
    func getDataForURL(url: NSURL, needTimCheck timeCheck: Bool) -> CacheData? {
        return self.getDataForURL(url, needTimCheck: timeCheck, cacheTimeInterval: 0)
    }
    
    func getDataForURL(url: NSURL, needTimCheck timeCheck: Bool, cacheTimeInterval: NSTimeInterval) -> CacheData? {
        
        if let data:CacheData? = self.getDataFromCacheForURL(url, needTimCheck: timeCheck, cacheTimeInterval: cacheTimeInterval) {
            return data
        }
        else {
            let data:CacheData? = self.getDataFromPersistanceForURL(url, needTimCheck: timeCheck, cacheTimeInterval: cacheTimeInterval)
            return data;
        }
    }
    
    func addDataToCache(cacheData: CacheData, forURL url: NSURL) {
        let urlHashKey: String = URLCache.cacheKeyForURL(url)
        if self.dataCache == nil {
            self.dataCache = NSCache()
        }
        self.dataCache.setObject(cacheData, forKey: urlHashKey)
        // Check if persistance is required.
        //        if self.isDynamicSaveEnabled() {
        self.persistCacheData(cacheData, forURL: url)
        //}
    }
    
    func getDataFromCacheForURL(url: NSURL, needTimCheck timeCheck: Bool) -> CacheData? {
        return self.getDataFromCacheForURL(url, needTimCheck: timeCheck, cacheTimeInterval: self.URLCacheInterval)
    }
    
    func getDataFromCacheForURL(url: NSURL, needTimCheck timeCheck: Bool, cacheTimeInterval: NSTimeInterval) -> CacheData? {
        
        if self.dataCache != nil {
            // Get URL hash key
            let urlHashKey: String = URLCache.cacheKeyForURL(url)
            if let cacheData:CacheData =  self.dataCache.objectForKey(urlHashKey) as? CacheData  {
                
                if !timeCheck {
                    return cacheData
                }
                else if cacheTimeInterval == 0 {
                    return cacheData
                }
                
                /* get the elapsed time since last file update */
                let elapsedTime: NSTimeInterval = fabs(cacheData.cacheCreatedDateTime.timeIntervalSinceNow)//fabs(cacheData.cacheCreatedDateTime.timeIntervalSinceNow())
                if elapsedTime < cacheTimeInterval {
                    // We have data in the cache.
                    return cacheData
                }
            }
        }
        return nil
    }
    
    func removeDataFromCacheForURL(url: NSURL) {
        if ((self.dataCache) != nil) {
            // Get URL hash key
            let urlHashKey = URLCache.cacheKeyForURL(url);
            self.dataCache.removeObjectForKey(urlHashKey);
        }
    }
    
    func removeAllCachedData() {
        self.dataCache .removeAllObjects()
    }
    
    func persistCacheData(cacheData: CacheData, forURL url: NSURL) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {() -> Void in
            // Get URL hash key
            let urlHashKey: String = URLCache.cacheKeyForURL(url)
            Archiver.createFile(cacheData, fileName: urlHashKey)
            
        })
    }
    
    func removeDataFromPersistanceForURL(url: NSURL) {
        // Get URL hash key
        let urlHashKey: String = URLCache.cacheKeyForURL(url)
        Archiver.deleteFile(urlHashKey)
    }
    
    func getDataFromPersistanceForURL(url: NSURL, needTimCheck timeCheck: Bool) -> CacheData? {
        return self.getDataFromPersistanceForURL(url, needTimCheck: timeCheck, cacheTimeInterval: 0)
    }
    
    func getDataFromPersistanceForURL(url: NSURL, needTimCheck timeCheck: Bool, cacheTimeInterval: NSTimeInterval) -> CacheData? {
        let urlHashKey: String = URLCache.cacheKeyForURL(url)
        if Archiver.fileExists(urlHashKey) {
            
            let cacheData: CacheData = Archiver.readFile(urlHashKey) as! CacheData
            if !timeCheck && cacheData.cachedData != nil {
                return cacheData
            }
            else if  cacheTimeInterval == 0 && cacheData.cachedData != nil {
                return cacheData
            }
            else if cacheData.cachedData != nil {
                /* get the elapsed time since last file update */
                let elapsedTime: NSTimeInterval = fabs(cacheData.cacheCreatedDateTime.timeIntervalSinceNow)
                if elapsedTime < cacheTimeInterval {
                    // We have data in the cache.
                    return cacheData
                }
            }
        }
        return nil
    }
    
    
    class func cacheKeyForURL(url: NSURL) -> String {
        var digest = [UInt8](count: Int(CC_MD5_DIGEST_LENGTH), repeatedValue: 0)
        if let data = url.absoluteString.dataUsingEncoding(NSUTF8StringEncoding) {
            CC_MD5(data.bytes, CC_LONG(data.length), &digest)
        }
        
        var digestHex = ""
        for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        
        return digestHex
    }
    
}
