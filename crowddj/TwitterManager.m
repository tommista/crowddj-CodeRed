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
    NSMutableDictionary *tweetList;
    NSString *hashtag;
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
    tweetList = [[NSMutableDictionary alloc] init];
}

- (void) setHashtag: (NSString *)value{
    tweetList = [[NSMutableDictionary alloc] init];
    hashtag = value;
    [self fetchTweetsWithHashtag:hashtag];
}

- (void) fetchTweetsWithHashtag: (NSString *) tag{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"Bearer AAAAAAAAAAAAAAAAAAAAALXqdgAAAAAAMfVikYHyimgiQKPW9bqJGndfngk%3Dad7RyM7WUMG5knJcMm7PKICeoOLOfvORmqBZUlvvTVV6J3FI81" forHTTPHeaderField:@"Authorization"];
    
    NSDictionary *parameters = @{@"q": tag};
    
    [manager GET:@"https://api.twitter.com/1.1/search/tweets.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        NSArray *tweetArray = [responseObject objectForKey:@"statuses"];
        
        for(NSDictionary *tweet in tweetArray){
            
            if([tweetList objectForKey:[tweet objectForKey:@"id_str"]] == nil){
                [tweetList setObject:tweet forKey:[tweet objectForKey:@"id_str"]];
                NSArray *entities = [((NSDictionary *)[tweet objectForKey:@"entities"]) objectForKey:@"urls"];
                if(entities.count != 0){
                    NSString *expandedUrl = [((NSDictionary *)[entities objectAtIndex:0]) objectForKey:@"expanded_url"];
                    if(expandedUrl != nil){
                        NSLog(@"expandedURL: %@", expandedUrl);
                        [[SongManager sharedSongManager] addTrackToPlaylist:expandedUrl];
                    }
                }
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


@end
