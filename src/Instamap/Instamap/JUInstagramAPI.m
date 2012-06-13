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


@interface JUInstagramAPI() {

}

@property (nonatomic, retain) NSString *authToken;

@property (nonatomic) CLLocationCoordinate2D searchLocation;
@property (nonatomic) CGFloat searchRange;

@end

#pragma mark -

@implementation JUInstagramAPI

#pragma mark Private

@synthesize
authToken = _authToken,
searchLocation = _searchLocation,
searchRange = _searchRange;


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

- (void)searchPhotosNearLocation:(CLLocationCoordinate2D)locatoion inRange:(CGFloat)range {
    
    self.searchLocation = locatoion;
    self.searchRange = range;
    
    RKObjectManager* manager = [RKObjectManager objectManagerWithBaseURLString:@"https://api.instagram.com/v1/"];
    
    RKObjectMapping* articleMapping = [RKObjectMapping mappingForClass:[JUInstagramAPIPhotoObject class]];
    [articleMapping mapKeyPath:@"user.username" toAttribute:@"user"];
    [articleMapping mapKeyPath:@"location.latitude" toAttribute:@"latitude"];
    [articleMapping mapKeyPath:@"location.longitude" toAttribute:@"longitude"];
    [articleMapping mapKeyPath:@"caption.text" toAttribute:@"caption"];
    [articleMapping mapAttributes:@"filter", nil];
    
    [manager.mappingProvider setMapping:articleMapping forKeyPath:@"data"];
    
    NSString *resourcePath = [@"/media/search" stringByAppendingFormat:@"?lat=%f&lng=%f&access_token=%@&distance=%d",
                             locatoion.latitude, locatoion.longitude, self.authToken, (int)range];
    
    [manager loadObjectsAtResourcePath:resourcePath delegate:self];
}

#pragma mark RKObjectLoaderDelegate

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
    
    if (self.apiDelegate != nil && [self.apiDelegate respondsToSelector:@selector(instaAPI:didReceivedPhotos:nearLocation:inRange:)]) {
        [self.apiDelegate instaAPI:self didReceivedPhotos:objects nearLocation:self.searchLocation inRange:self.searchRange];
    }
    
    for (JUInstagramAPIPhotoObject *photoObject in objects) {
        NSLog(@"%@, %@, %@", photoObject.user, photoObject.tags, photoObject.caption);
    }
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    
    NSLog(@"Error: %@", error);
}


@end
