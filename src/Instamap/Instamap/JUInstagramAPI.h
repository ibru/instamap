//
//  JUInstagramAPI.h
//  Instamap
//
//  Created by Jiří Urbášek on 5/14/12.
//  Copyright (c) 2012 Jiří Urbášek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <RestKit/RestKit.h>


@class JUInstagramAPI;
@protocol JUInstagramAPIDelegate <NSObject>

- (void)instaAPI:(JUInstagramAPI *)api didReceivedPhotos:(NSArray *)photos nearLocation:(CLLocationCoordinate2D)location inRange:(CGFloat)range;

@end

#pragma mark -
                                                                                                     
@interface JUInstagramAPI : NSObject <RKObjectLoaderDelegate>

@property (nonatomic, strong) id<JUInstagramAPIDelegate> apiDelegate;

- (BOOL)isSessionValid;

- (void)login;
- (void)logout;

- (void)searchPhotosNearLocation:(CLLocationCoordinate2D)locatoion inRange:(CGFloat)range;

@end
