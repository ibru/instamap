//
//  ViewController.h
//  Instamap
//
//  Created by Jiří Urbášek on 5/14/12.
//  Copyright (c) 2012 Jiří Urbášek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "JUInstagramAPI.h"


@interface ViewController : UIViewController <MKMapViewDelegate, JUInstagramAPIDelegate>

@property (nonatomic, retain) IBOutlet MKMapView *mapView;

@end
