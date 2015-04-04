//
//  SpotifyPlayer.h
//  crowddj
//
//  Created by Tommy Brown on 4/3/15.
//  Copyright (c) 2015 tommista. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Spotify/Spotify.h>

@interface SpotifyPlayer : NSObject

+ (SpotifyPlayer *) sharedSpotifyPlayer;

-(void)playUsingSession:(SPTSession *)session;
-(void) playTrack: (NSString *) track;
- (void) queueTrack:(NSString *)track;
- (void) initialize;
-(void) pause;
-(void) play;
- (void) skipTrack;
-(bool) isPlaying;
- (NSDictionary *) currentTrackMetadata;

@property (nonatomic, readwrite) SPTAudioStreamingController *player;

@end
