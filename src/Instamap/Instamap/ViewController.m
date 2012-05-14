//
//  ViewController.m
//  Instamap
//
//  Created by Jiří Urbášek on 5/14/12.
//  Copyright (c) 2012 Jiří Urbášek. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

#pragma mark -

@implementation ViewController

@synthesize
mapView = _mapView;

#pragma mark UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    NSLog(@"coordinate: lat: %f, lon: %f", self.mapView.centerCoordinate.latitude, self.mapView.centerCoordinate.longitude);
}

#pragma mark MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    [mapView setCenterCoordinate:mapView.region.center animated:NO];
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {

    NSLog(@"coordinate: lat: %f, lon: %f", self.mapView.centerCoordinate.latitude, self.mapView.centerCoordinate.longitude);
}

#pragma mark ViewController

#pragma mark -- actions

- (IBAction)locationRefreshTouched:(id)sender {
    
}


@end
