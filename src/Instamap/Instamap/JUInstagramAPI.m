//
//  JUInstagramAPI.m
//  Instamap
//
//  Created by Jiří Urbášek on 5/14/12.
//  Copyright (c) 2012 Jiří Urbášek. All rights reserved.
//

#import "JUInstagramAPI.h"


@interface JUInstagramAPI() {

}

@property (nonatomic, retain) NSString *authToken;

@end

#pragma mark -

@implementation JUInstagramAPI

#pragma mark Private

@synthesize authToken = _authToken;


#pragma mark Public

@synthesize apiDelegate;

- (BOOL)isSessionValid {
    return self.authToken != nil;
}

- (void)login {

}

- (void)logout {

}


@end
