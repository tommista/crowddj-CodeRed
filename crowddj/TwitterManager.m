//
//  TwitterManager.m
//  crowddj
//
//  Created by Tommy Brown on 4/3/15.
//  Copyright (c) 2015 tommista. All rights reserved.
//

#import "TwitterManager.h"
#import "

static NSString * const accessToken = @"AAAAAAAAAAAAAAAAAAAAALXqdgAAAAAAMfVikYHyimgiQKPW9bqJGndfngk%3Dad7RyM7WUMG5knJcMm7PKICeoOLOfvORmqBZUlvvTVV6J3FI81";

@implementation TwitterManager

+ (TwitterManager *) sharedTwitterManager{
    static TwitterManager *instance = nil;
    if(!instance){
        instance = [[self alloc] init];
        [instance initialize];
    }
    
    return instance;
}

- (void) initialize{
    
}

- (void) doSomething{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://example.com/resources.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
