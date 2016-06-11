//
//  UniqueDeviceIdentifier.swift
//  HungerBell
//
//  Created by pankaj.jha on 6/11/16.
//  Copyright © 2016 Times Internet Limited. All rights reserved.
//

import UIKit
import FXKeychain

let DEVICE_IDENTIFIER = "device_identifier"
class UniqueDeviceIdentifier {
    
    static let sharedInstance = UniqueDeviceIdentifier()
    var UUID:NSString!
    
    func getUUID() -> NSString {
        if UUID != nil {
            return UUID as String
        }
        else {
            self.fetchOrGenerateUUID()
            return UUID
        }
    }
    
    func deleteUUID() {
        self.UUID = nil
        FXKeychain.defaultKeychain().removeObjectForKey(DEVICE_IDENTIFIER)
    }
    
    func fetchOrGenerateUUID() {
        
        guard let uuid:NSString? = FXKeychain.defaultKeychain().objectForKey(DEVICE_IDENTIFIER) as? NSString
            else {
                print("fata hua error")
        }
        
        if (uuid != nil) {
            self.UUID = (FXKeychain.defaultKeychain()[DEVICE_IDENTIFIER] as! String)
        }
        else {
            // get the UDID and save it to user defaults and Keychain
            self.UUID =  NSUUID().UUIDString
            FXKeychain.defaultKeychain()[DEVICE_IDENTIFIER] = UUID
        }
    }
}
