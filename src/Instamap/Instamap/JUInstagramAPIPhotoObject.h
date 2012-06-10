//
//  JUInstagramAPIPhotoObject.h
//  Instamap
//
//  Created by Jiří Urbášek on 6/10/12.
//  Copyright (c) 2012 Jiří Urbášek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface JUInstagramAPIPhotoObject : NSObject

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *caption;
@property (nonatomic, retain) NSString *user;
@property (nonatomic, retain) NSString *filter;
@property (nonatomic, retain) NSArray *tags;

@end
