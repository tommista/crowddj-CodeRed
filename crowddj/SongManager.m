//
//  SongManager.m
//  crowddj
//
//  Created by Tommy Brown on 4/3/15.
//  Copyright (c) 2015 tommista. All rights reserved.
//

#import "SongManager.h"
#import <Spotify/Spotify.h>

@interface SongManager(){
    NSMutableArray *songList;
}
@end

@implementation SongManager

+ (SongManager *) sharedSongManager{
    static SongManager *instance = nil;
    if(!instance){
        instance = [[self alloc] init];
        [instance initialize];
    }
    
    return instance;
}

- (void) initialize{
}

- (void) clearList{
    songList = [[NSMutableArray alloc] init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"songList"];
    [defaults synchronize];
}

- (void) addTrackToPlaylist:(NSString *)url{
    NSArray *urlParts = [url componentsSeparatedByString:@"/"];
    NSString *trackId = [urlParts lastObject];
    NSLog(@"trackId: %@", trackId);
    url = [NSString stringWithFormat:@"spotify:track:%@", trackId];
    
    [SPTRequest requestItemAtURI:[NSURL URLWithString:url] withSession:nil callback:^(NSError *error, SPTTrack* track) {
        NSLog(@"track: %@", track);
        if(track != nil){
            [songList addObject:track];
        }
    }];
    
}

@end
