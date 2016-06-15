//
//  DataFetchManager.swift
//  HungerBell
//
//  Created by pankaj.jha on 6/10/16.
//  Copyright © 2016 Times Internet Limited. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class DataFetchManager: NSObject {
    
    static let sharedInstance = DataFetchManager()
    
    
    //fetch Sector Data
    func fetchSectorDataWithCompletionBlock(completionHandler: (result:Bool, sectors: [SectorModel]?) -> Void ) {
        let url = "http://webapi.eatkart.co.in:8080/FoodiGuy/default/sectors";
        Alamofire.request(.GET, url, parameters: nil)
            .responseJSON { response in
                /*print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization */
                
                if let JSON = response.result.value {
                    let sectorDataArray = Mapper<SectorModel>().mapArray(JSON)
                    if sectorDataArray?.count > 0 {
                        completionHandler(result: true, sectors: sectorDataArray!)
                    }
                    else {
                        completionHandler(result: false, sectors: nil)
                    }
                    print("JSON: \(JSON)")
                }
        }
    }
    
    
    
    //fetch Society Data for sector
    func fetchSocietyDataWithForSector(sector:NSString, completionHandler: (result:Bool, societes: [SocietyModel]?) -> Void ) {
        let url = "http://webapi.eatkart.co.in:8080/FoodiGuy/default/socities?sector=\(sector)"
        
        let encodedMessage = url.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        Alamofire.request(.GET, encodedMessage, parameters: nil)
            .responseJSON { response in
                /*print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization */
                
                if let JSON = response.result.value {
                    let societyDataArray = Mapper<SocietyModel>().mapArray(JSON)
                    if societyDataArray?.count > 0 {
                        completionHandler(result: true, societes: societyDataArray!)
                    }
                    else {
                        completionHandler(result: false, societes: nil)
                    }
                    print("JSON: \(JSON)")
                }
        }
    }
    
    
    func fetchFoodCategoryOfOrderType(orderType: OrderType, completionHandler: (result:Bool, categories:
        NSArray?) -> Void ) {
        let url = "http://webapi.eatkart.co.in:8080/FoodiGuy/rest/categories?ordertype=\(orderType)"
        
        let encodedMessage = url.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        Alamofire.request(.GET, encodedMessage, parameters: nil)
            .responseJSON { response in
                /*print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization */
                
                if let JSON = response.result.value {
                    let categoryArray = Mapper<FoodCategory>().mapArray(JSON)
                    if categoryArray?.count > 0 {
                        completionHandler(result: true, categories: categoryArray!)
                    }
                    else {
                        completionHandler(result: false, categories: nil)
                    }
                    print("JSON: \(JSON)")
                }
        }
    }
    
    func fetchFoodItemDataForOrderType(orderType: OrderType, name:NSString, completionHandler: (result:Bool, foodItems: NSArray?) -> Void ) {
        let url = "http://webapi.eatkart.co.in:8080/FoodiGuy/rest/menus?isavailable=1&ordertype=\(orderType)&name=\(name)"
        
        let encodedMessage = url.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        
        let nsurlreq = NSMutableURLRequest(URL: NSURL(string: encodedMessage)!, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 240)

        //let nsurlreq = NSMutableURLRequest(URL: NSURL(string: encodedMessage)!)
        
        
        Alamofire.request(nsurlreq).responseJSON { response in
            if let JSON = response.result.value {
                let foodItemArray = Mapper<FoodItem>().mapArray(JSON)
                if foodItemArray?.count > 0 {
                    completionHandler(result: true, foodItems: foodItemArray!)
                }
                else {
                    completionHandler(result: false, foodItems: nil)
                }
                print("JSON: \(JSON)")
            }
        }
        
//        Alamofire.request(.GET, encodedMessage, parameters: nil)
//            .responseJSON { response in
//                /*print(response.request)  // original URL request
//                print(response.response) // URL response
//                print(response.data)     // server data
//                print(response.result)   // result of response serialization */
//                
//                if let JSON = response.result.value {
//                    let foodItemArray = Mapper<FoodItem>().mapArray(JSON)
//                    if foodItemArray?.count > 0 {
//                        completionHandler(result: true, foodItems: foodItemArray!)
//                    }
//                    else {
//                        completionHandler(result: false, foodItems: nil)
//                    }
//                    print("JSON: \(JSON)")
//                }
//        }
    }
    
//    - (void)fetchFoodItemDataForOrderType:(OrderType)orderType withName:(NSString *)name WithCompletionBlock:(void (^) (CacheData * cacheData, NSError *error)) completionBlock {
//    
//    //NSString *url = nil;
//    
//    
//    NSString *url =[NSString stringWithFormat:@"http://webapi.eatkart.co.in:8080/FoodiGuy/rest/menus?isavailable=1&ordertype=%d&name=%@",orderType,name];
//    URLObject *urlObject = [URLObject defaultGETForURLPath:url internalClass:@"FoodItem"];
//    ObjectMapperContainer *objectMapperContainer = [ObjectMapperContainer objectMapperContainer];
//    
//    
//    [self mapAttributeForObjectMapper:objectMapperContainer toJSONClass:@"FoodItem"];
//    
//    //[objectMapperContainer addClassNameMapping:[ObjectMapper objectMapperForJsonClass:@"FoodItem" toMyClass:@"FoodItem"]];
//    
//    [urlObject setObjectMapperContainer:objectMapperContainer];
//    urlObject.cacheIntervalTime = 24 * 60 * 60;
//    [self requestDataFromURLObject:urlObject completionBlock:^(id aObject, NSError *error) {
//    if (!error && aObject) {
//    CacheData *cachedData = (CacheData*)aObject;
//    if (cachedData && cachedData.cachedData && [cachedData.cachedData isKindOfClass:[NSArray class]]) {
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//    completionBlock(cachedData,nil);
//    });
//    }
//    else {
//    dispatch_async(dispatch_get_main_queue(), ^{
//    completionBlock(nil,[NSError errorWithString:@"" errorCode:100]);
//    });
//    
//    }
//    }
//    else {
//    dispatch_async(dispatch_get_main_queue(), ^{
//    completionBlock(nil,error);
//    });
//    }
//    
//    }];
//    }
    
    
}
