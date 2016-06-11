//
//  ViewController.h
//  PaymentGateway
//
//  Created by Suraj on 22/07/15.
//  Copyright (c) 2015 Suraj. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PaymentPageViewControllerDelegate <NSObject>

-(void)setPaymentStatusWithPaymentDictionary:(NSMutableDictionary *)paymentDictionry;

@end
@interface PaymentPageViewController : UIViewController

@property (nonatomic,weak) id<PaymentPageViewControllerDelegate> paymentDelegate;

@end

