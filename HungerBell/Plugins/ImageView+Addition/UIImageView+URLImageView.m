//
//  UIImageView+URLImageView.m
//  TOI
//
//  Created by Pankaj Jha on 26/09/13.
//  Copyright (c) Times Internet Limited. All rights reserved.
//

#import "UIImageView+URLImageView.h"

#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

#define TAG_UIBUTTON                        525010

@interface UIImageView (Private)

-(void)downloadingButtonTapped;

@end

@implementation UIImageView (URLImageView)

#pragma mark - Public Methods
- (void)setImageWithURL:(NSString*)aImageURLString defaultUrl:(NSString*)aDefaultUrlString downloadFlag:(BOOL)downloadFlag
 activityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle
       placeHolderImage:(UIImage*)placeHolderImage {
    [self setImageWithURL:aImageURLString defaultUrl:aDefaultUrlString downloadFlag:downloadFlag activityIndicatorStyle:activityStyle placeHolderImage:placeHolderImage withCompletionBlock:nil];
}

- (void)setImageWithURL:(NSString*)aImageURLString defaultUrl:(NSString*)aDefaultUrlString downloadFlag:(BOOL)downloadFlag
 activityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle
       placeHolderImage:(UIImage*)placeHolderImage
    withCompletionBlock:(void (^)(UIImage *image, NSError *error))completionBlock {
    [self setImage:placeHolderImage];
    
    if (aImageURLString && aImageURLString.length) {
        NSURL *imageURL = [NSURL URLWithString:aImageURLString];
        __weak typeof(self)weakSelf = self;
            // image download is allowed
            [self setImageWithURL:imageURL placeholderImage:placeHolderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                dispatch_async(dispatch_get_main_queue(), ^ {
                    if (image) {
                        if (completionBlock) {
                            completionBlock(image, nil);
                        }
                        else {
                            [weakSelf setImage:image];
                        }
                    }
                    else {
                        if (completionBlock) {
                            completionBlock(nil,error);
                        }
                    }
                });
            } usingActivityIndicatorStyle:activityStyle];
        
    }
}


#pragma mark - Private Methods

@end
