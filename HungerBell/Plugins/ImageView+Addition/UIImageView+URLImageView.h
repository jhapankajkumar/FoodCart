//
//  UIImageView+URLImageView.h
//  TOI
//
//  Created by Pankaj Jha on 26/09/13.
//  Copyright (c) Times Internet Limited. All rights reserved.
//

// Help taken from https://github.com/JJSaccolo/UIActivityIndicator-for-SDWebImage

#import <UIKit/UIKit.h>

@interface UIImageView (URLImageView)

- (void)setImageWithURL:(NSString*)aImageURLString defaultUrl:(NSString*)aDefaultUrlString downloadFlag:(BOOL)downloadFlag
 activityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle
       placeHolderImage:(UIImage*)placeHolderImage;

- (void)setImageWithURL:(NSString*)aImageURLString defaultUrl:(NSString*)aDefaultUrlString downloadFlag:(BOOL)downloadFlag
 activityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle
       placeHolderImage:(UIImage*)placeHolderImage
    withCompletionBlock:(void (^)(UIImage *image, NSError *error))completionBlock;

@end
