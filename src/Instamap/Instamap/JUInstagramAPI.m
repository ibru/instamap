//
//  JUInstagramAPI.m
//  Instamap
//
//  Created by Jiří Urbášek on 5/14/12.
//  Copyright (c) 2012 Jiří Urbášek. All rights reserved.
//

#import "JUInstagramAPI.h"
#import "JUInstagramAPIPhotoObject.h"
#import "NSString+RKAdditions.h"

#define kGeoDegreeInMetres      110574.61


@interface JUInstagramAPI() {

}

@property (nonatomic, retain) NSString *authToken;
@property (nonatomic) MKCoordinateRegion searchRegion;

- (void)setupJSONMappings;

@end

#pragma mark -

@implementation JUInstagramAPI

#pragma mark Private

@synthesize
authToken = _authToken,
searchRegion = _searchRegion;

- (void)setupJSONMappings {
    
    RKLogConfigureByName("RestKit/Network", RKLogLevelInfo);
    
    RKObjectManager* manager = [RKObjectManager objectManagerWithBaseURLString:@"https://api.instagram.com/v1/"];
    
    RKObjectMapping *articleMapping = [RKObjectMapping mappingForClass:[JUInstagramAPIPhotoObject class]];
    [articleMapping mapKeyPath:@"user.username" toAttribute:@"user"];
    [articleMapping mapKeyPath:@"location.latitude" toAttribute:@"latitude"];
    [articleMapping mapKeyPath:@"location.longitude" toAttribute:@"longitude"];
    [articleMapping mapKeyPath:@"caption.text" toAttribute:@"caption"];
    [articleMapping mapAttributes:@"filter", nil];
    
    [manager.mappingProvider addObjectMapping:articleMapping];
}

#pragma mark Init

- (id)init
{
    self = [super init];
    if (self) {
        [self setupJSONMappings];
    }
    return self;
}

#pragma mark Public

@synthesize apiDelegate;

- (BOOL)isSessionValid {
    return self.authToken != nil;
}

- (void)login {

    //TODO: do real login using OAuth
    
    self.authToken = @"446055.f59def8.176055b0dbb848c88bc8d240cd42ef94";
}

- (void)logout {

}

- (void)searchPhotosInRegion:(MKCoordinateRegion)region {
    
    self.searchRegion = region;
    
    
    RKObjectManager* manager = [RKObjectManager sharedManager];

    RKObjectMapping *articleMapping = [manager.mappingProvider objectMappingForClass:[JUInstagramAPIPhotoObject class]];
    [manager.mappingProvider setMapping:articleMapping forKeyPath:@"data"];
    
    NSString *resourcePath = [@"/media/search" stringByAppendingFormat:@"?lat=%f&lng=%f&access_token=%@&distance=%d",
                             self.searchRegion.center.latitude, self.searchRegion.center.longitude, self.authToken, (int)(MAX(self.searchRegion.span.latitudeDelta,self.searchRegion.span.longitudeDelta) * kGeoDegreeInMetres)];
    
    [manager loadObjectsAtResourcePath:resourcePath delegate:self];
}

#pragma mark RKObjectLoaderDelegate

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
    
    if (self.apiDelegate != nil && [self.apiDelegate respondsToSelector:@selector(instaAPI:didReceivedPhotos:inRegion:)]) {
        [self.apiDelegate instaAPI:self didReceivedPhotos:objects inRegion:self.searchRegion];
    }
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    
    NSLog(@"Error: %@", error);
}


@end
