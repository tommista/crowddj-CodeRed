//
//  SpotifyPlayer.m
//  crowddj
//
//  Created by Tommy Brown on 4/3/15.
//  Copyright (c) 2015 tommista. All rights reserved.
//

#import "SpotifyPlayer.h"
#import "TwitterManager.h"

@implementation SpotifyPlayer

static NSString * const kClientId = @"3a61f8fd1ef6442c99858752346a01f8";
static NSString * const kCallbackURL = @"crowddj://spotify";
static NSString * const kTokenSwapServiceURL = @"http://localhost:1234/swap";

+ (SpotifyPlayer *) sharedSpotifyPlayer{
    static SpotifyPlayer *instance = nil;
    if(!instance){
        instance = [[self alloc] init];
        [instance initialize];
    }
    
    return instance;
}

- (void) initialize{
    if (_player == nil) {
        _player = [[SPTAudioStreamingController alloc] initWithClientId:kClientId];
        _player.playbackDelegate = self;
    }
}

- (void) play{
    
    if(!_player.isPlaying){
        [_player setIsPlaying:YES callback:^(NSError *error) {
        }];
    }
}

- (void) pause{
    if(_player.isPlaying){
        [_player setIsPlaying:NO callback:^(NSError *error) {
        }];
    }
}

- (void) skipTrack{
    if(_player.isPlaying){
        [_player skipNext:nil];
    }
}

- (BOOL) isPlaying{
    return _player.isPlaying;
}

- (void) playTrack:(NSString *)track{
    [SPTRequest requestItemAtURI:[NSURL URLWithString:track]
                     withSession:nil
                        callback:^(NSError *error, SPTTrack *track) {
                            
                            if (error != nil) {
                                NSLog(@"*** Track lookup got error %@", error);
                                return;
                            }
                            [self.player playTrackProvider:track callback:nil];
                            
                        }];
}

- (void) queueTrack:(NSString *)track{
    [SPTRequest requestItemAtURI:[NSURL URLWithString:track]
                     withSession:nil
                        callback:^(NSError *error, SPTTrack *track) {
                            
                            if (error != nil) {
                                NSLog(@"*** Track lookup got error %@", error);
                                return;
                            }
                            [self.player queueTrackProvider:track clearQueue:NO callback:nil];
                            //[self.player queuePlay:nil];
                            
                        }];
}

-(void)playUsingSession:(SPTSession *)session {
    
    
    // Create a new player if needed
    if (self.player == nil) {
        self.player = [[SPTAudioStreamingController alloc] initWithClientId:kClientId];
    }
    
    [self.player loginWithSession:session callback:^(NSError *error) {
        
        if (error != nil) {
            NSLog(@"*** Enabling playback got error: %@", error);
            return;
        }
        
        //[self playTrack:@"spotify:track:1Bildp7NM39gR3smbMh8W1"];
        
        
    }];
    
}

- (NSDictionary *) currentTrackMetadata{
    return _player.currentTrackMetadata;
}

#pragma mark - SPTAudioStreamingPlaybackDelegate

- (void) audioStreaming:(SPTAudioStreamingController *)audioStreaming didStartPlayingTrack:(NSURL *)trackUri{
    NSLog(@"Now playing: %@", trackUri.absoluteString);
    
    [SPTRequest requestItemAtURI:trackUri
                     withSession:nil
                        callback:^(NSError *error, SPTTrack *track) {
                            NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc] init];
                            [tempDictionary setObject:track forKey:@"trackInfo"];
                           [[NSNotificationCenter defaultCenter] postNotificationName: @"NewTrackPlaying" object:nil userInfo:tempDictionary];
                        }];
}


@end
