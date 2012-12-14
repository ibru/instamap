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
#import <MapKit/MapKit.h>


@class JUInstagramAPI;
@protocol JUInstagramAPIDelegate <NSObject>

- (void)instaAPI:(JUInstagramAPI *)api didReceivedPhotos:(NSArray *)photos inRegion:(MKCoordinateRegion)region;

@end

#pragma mark -
                                                                                                     
@interface JUInstagramAPI : NSObject

@property (nonatomic, strong) id<JUInstagramAPIDelegate> apiDelegate;

- (BOOL)isSessionValid;

- (void)login;
- (void)logout;

- (void)searchPhotosInRegion:(MKCoordinateRegion)region;

@end
