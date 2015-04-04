//
//  TwitterManager.m
//  crowddj
//
//  Created by Tommy Brown on 4/3/15.
//  Copyright (c) 2015 tommista. All rights reserved.
//

#import "TwitterManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "SongManager.h"

@interface TwitterManager(){
}
@end

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

- (void) fetchTweetsWithHashtag: (NSString *) hashtag{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"Bearer AAAAAAAAAAAAAAAAAAAAALXqdgAAAAAAMfVikYHyimgiQKPW9bqJGndfngk%3Dad7RyM7WUMG5knJcMm7PKICeoOLOfvORmqBZUlvvTVV6J3FI81" forHTTPHeaderField:@"Authorization"];
    
    NSDictionary *parameters = @{@"q": hashtag};
    
    [manager GET:@"https://api.twitter.com/1.1/search/tweets.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        [[SongManager sharedSongManager] addTrackToPlaylist:@"https://open.spotify.com/track/5U8hKxSaDXB8cVeLFQjvwx"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


@end
