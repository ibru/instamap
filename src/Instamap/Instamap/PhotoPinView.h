//
//  PhotoPinView.h
//  Instamap
//
//  Created by Jiří Urbášek on 6/10/12.
//  Copyright (c) 2012 Jiří Urbášek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface PhotoPinView : NSObject <MKAnnotation>

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle;

+ (PhotoPinView *)photoViewWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle;

@end
