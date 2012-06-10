//
//  PhotoPinView.m
//  Instamap
//
//  Created by Jiří Urbášek on 6/10/12.
//  Copyright (c) 2012 Jiří Urbášek. All rights reserved.
//

#import "PhotoPinView.h"


@implementation PhotoPinView

@synthesize 
coordinate = _coordinate,
title = _title,
subtitle = _subtitle;

+ (PhotoPinView *)photoViewWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle {
    
    return [[self alloc] initWithCoordinate:coordinate title:title subtitle:subtitle];
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle {
    
    if (self = [super init]) {
        //TODO: is this OK or do we need to tell ARC to retain it somehow
        _coordinate = coordinate;
        _title = title;
        _subtitle = _subtitle;
    }
    return self;
}


@end
