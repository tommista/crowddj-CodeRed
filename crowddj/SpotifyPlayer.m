//
//  SpotifyPlayer.m
//  crowddj
//
//  Created by Tommy Brown on 4/3/15.
//  Copyright (c) 2015 tommista. All rights reserved.
//

#import "SpotifyPlayer.h"

@interface SpotifyPlayer(){
    
}
@end

@implementation SpotifyPlayer

+ (SpotifyPlayer *) sharedSpotifyPlayer{
    static SpotifyPlayer *instance = nil;
    if(!instance){
        instance = [[self alloc] init];
    }
    
    return instance;
}

@end
