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

@property (nonatomic, strong) RKObjectRequestOperation *fetchOperation;

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
    
    RKObjectMapping *articleMapping = [RKObjectMapping mappingForClass:[JUInstagramAPIPhotoObject class]];
    [articleMapping addAttributeMappingsFromDictionary:@{
     @"user.username": @"user",
     @"location.latitude": @"latitude",
     @"location.longitude": @"longitude",
     @"caption.text" : @"caption"
     }];
        
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:articleMapping pathPattern:nil keyPath:@"data" statusCodes:nil];
    
    NSString *resourcePath = [@"/media/search" stringByAppendingFormat:@"?lat=%f&lng=%f&access_token=%@&distance=%d",
                              self.searchRegion.center.latitude, self.searchRegion.center.longitude, self.authToken, (int)(MAX(self.searchRegion.span.latitudeDelta,self.searchRegion.span.longitudeDelta) * kGeoDegreeInMetres)];
    NSURL *url = [NSURL URLWithString:[@"https://api.instagram.com/v1/" stringByAppendingString:resourcePath]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    self.fetchOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    __block JUInstagramAPI *api = self;
    
    [self.fetchOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        if (self.apiDelegate != nil && [self.apiDelegate respondsToSelector:@selector(instaAPI:didReceivedPhotos:inRegion:)]) {
            [self.apiDelegate instaAPI:api didReceivedPhotos:result.array inRegion:self.searchRegion];
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    

    [self.fetchOperation start];
}

@end
