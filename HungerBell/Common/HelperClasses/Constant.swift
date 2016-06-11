//
//  Constant.swift
//  HungerBell
//
//  Created by pankaj.jha on 6/11/16.
//  Copyright © 2016 Times Internet Limited. All rights reserved.
//

import UIKit

struct Constant {
    
    static let SCREENSIZE:CGSize = UIScreen.mainScreen().bounds.size
    
    static let SharedAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    static let  IS_IPHONE_6_PLUS  = (UIScreen.mainScreen().bounds.size.height - 736) == 0 ? true : false
    static let  IS_IPHONE_6       = (UIScreen.mainScreen().bounds.size.height - 667) == 0 ? true : false
    static let  IS_IPHONE_5       =   (UIScreen.mainScreen().bounds.size.height - 568) == 0 ? true : false
    static let  IS_IPHONE_4       =  (UIScreen.mainScreen().bounds.size.height - 480) == 0 ? true : false

    static let  SHARE_MAIL_FORMAT  = "<a href=\"%@\">%@</a> <br><br>%@ <a href=\"%@\">%@</a>"
    
    static func RGB(r:CGFloat, g:CGFloat, b:CGFloat) ->UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1.0)
    }
    
    static func RGBA(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) ->UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
    //    //Theme Color
    static func DARK_THEME_COLOR() -> UIColor {
        return UIColor(red: 52/255.0, green: 126/255.0, blue: 31/255.0, alpha: 1.0)
    }
    static func  LIGHT_THEME_COLOR() -> UIColor {
       return UIColor(red:94/255.0, green:174/255.0, blue:80/255.0, alpha:1.0)
    }
    static func  THEME_COLOR() ->UIColor {
      return  UIColor(red:106/255.0, green:185/255.0, blue:109/255.0, alpha:1.0)
    }
    
    static func  STANDARD_GRAY_COLOR() ->UIColor {
     return UIColor(red:221/255.0, green:221/255.0, blue:221/255.0, alpha:1.0)
    }
    
    static func  STANDARD_BACKGROUND_COLOR()-> UIColor {
      return UIColor(red:231/255.0, green:231/255.0, blue:231/255.0, alpha:1.0)
    }
    
    
    static func  Avenir_Bold(aSize:CGFloat) ->UIFont {
        return UIFont(name: "Avenir-Black", size: aSize)!
    }
    
    static func  Avenir_Regular(aSize:CGFloat) ->UIFont {
        return UIFont(name: "Avenir-Book", size: aSize)!
    }
    
    static func  Avenir_Light(aSize:CGFloat) ->UIFont {
        return UIFont(name: "Avenir-Light", size: aSize)!
    }
    
  
    
    

//    // ============================================================================================================================
//============================================================================================================================
//    
//    static let  IS_RETINA ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0))
//    
//    // Bundle name
//    static let  BUNDLE_NAME                 [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
//    static let  APP_VERSION                 [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//    static let  APP_VERSION_SETTING         [NSString stringWithFormat:@"%@ Version %@ (%@)",BUNDLE_NAME, APP_VERSION, [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]
//    
//    static let  APP_NAME @"EatKart"
//    
//    
//    
//    // Template
//    // ============================================================================================================================
    static let  NO_NETWORK_STRING           = "Seems you are offline. Please check your network connection."
    static let  NO_NETWORK_IN_ROAMING       = "Looks like you are Roaming. Please check your network connection."
    static let  SOMETHING_WENT_WRONG        = "Looks like we have encountered a problem. Please try again."


//    
//    
//    static let  BreakFastCategory @"https://api.myjson.com/bins/1423p";
//    
//    
//    //static let  CategoryUrl  @"http://192.168.0.5:8080/rest/categories?ordertype=%@"
//    
//    static let  CategoryUrl(v)  @"http://webapi.eatkart.co.in:8080/FoodiGuy/rest/categories?ordertype=0"
//    
//    static let  SectorURl    @"http://webapi.eatkart.co.in:8080/FoodiGuy/default/sectors"
//    
//    static let  SocietiesURL(v) @"http://webapi.eatkart.co.in:8080/FoodiGuy/default/socities?sector=v"
//    
//    static let  MenuListURL(v,k) @"http://webapi.eatkart.co.in:8080/FoodiGuy/rest/menus?isavailable=1&ordertype=v&name=k"
//    
//    //#defin //@"https://api.myjson.com/bins/1423p"
//    

//    
    static let  kSociety_Key   = "society_name"
    static let  kSector_Key    = "sector_name"
//    
//    
    static let  USER_INFO =  "userinformationfile"
}

enum OrderType: Int {
    case kOrderTypeBreakFast = 0
    case kOrderTypeDinner // 1
}


enum SortType: Int {
    case kSortTypeAll = 0
    case kSortTypeVeg // 1
    case kSortTypeNonVeg
}


