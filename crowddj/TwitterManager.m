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

- (void) refresh{
    [self fetchTweetsWithHashtag:hashtag];
}

- (void) fetchTweetsWithHashtag: (NSString *) tag{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"Bearer AAAAAAAAAAAAAAAAAAAAALXqdgAAAAAAMfVikYHyimgiQKPW9bqJGndfngk%3Dad7RyM7WUMG5knJcMm7PKICeoOLOfvORmqBZUlvvTVV6J3FI81" forHTTPHeaderField:@"Authorization"];
    
    NSDictionary *parameters = @{@"q": tag};
    
    [manager GET:@"https://api.twitter.com/1.1/search/tweets.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        
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
                }else{
                    NSString *text = [tweet objectForKey:@"text"];
                    NSArray *textParts = [text componentsSeparatedByString:@" "];
                    
                    for(int x = 0; x < textParts.count; x++){
                        NSString *str = [textParts objectAtIndex:x];
                        if([str isEqualToString:@"by"]){
                            NSString *songName = @"";
                            NSString *artistName = @"";
                            for(int a = 0; a < x; a++){
                                if(a != 0){
                                    songName = [NSString stringWithFormat:@"%@ %@", songName, [textParts objectAtIndex:a]];
                                }else{
                                    songName = [textParts objectAtIndex:a];
                                }
                            }
                            for(int a = x + 1; a < textParts.count - 1; a++){
                                if(a != x + 1){
                                    artistName = [NSString stringWithFormat:@"%@ %@", artistName, [textParts objectAtIndex:a]];
                                }else{
                                    artistName = [textParts objectAtIndex:a];
                                }
                            }
                            
                            NSLog(@"Artist: %@ Song: %@", artistName, songName);
                            
                            dispatch_async(dispatch_get_global_queue(0,0), ^{
                                NSString *urlString = [[NSString stringWithFormat:@"https://api.spotify.com/v1/search?q=%@+artist:%@&offset=0&limit=20&type=track", songName, artistName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                                NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: urlString]];
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    NSError *error;
                                    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                    NSString *parsedUrl = [((NSDictionary *)[((NSArray *)[((NSDictionary *)[json objectForKey:@"tracks"]) objectForKey:@"items"]) objectAtIndex:0]) objectForKey:@"uri"];
                                    NSLog(@"$$$$ %@", parsedUrl);
                                    NSArray *parsedUrlParts = [parsedUrl componentsSeparatedByString:@":"];
                                    NSString *trackId = [parsedUrlParts lastObject];
                                    [[SongManager sharedSongManager] addTrackToPlaylist:trackId];
                                    
                                });
                            });
                            
                            /*AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                            NSString *ughString = [[NSString stringWithFormat:@"%@+artist:%@", songName, artistName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                            ughString = [ughString stringByReplacingOccurrencesOfString:@"%2B" withString:@"+"];
                            NSDictionary *parameters = @{@"q": ughString, @"type" : @"track"};
                            
                            NSLog(@"Parameters: %@", parameters);
                            
                            [manager GET:@"https://api.spotify.com/v1/search" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                NSLog(@"JSON: %@", responseObject);
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                NSLog(@"Error: %@", error);
                            }];*/
                            
                        }
                    }
                    
                }
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


@end
