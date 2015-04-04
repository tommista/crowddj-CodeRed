// TutorialApp
// Created by Spotify on 04/09/14.
// Copyright (c) 2014 Spotify. All rights reserved.

// Import Spotify API header file
#import <Spotify/Spotify.h>
#import "AppDelegate.h"

// Constants
static NSString * const kClientId = @"3a61f8fd1ef6442c99858752346a01f8";
static NSString * const kCallbackURL = @"crowddj://spotify";
static NSString * const kTokenSwapServiceURL = @"http://localhost:1234/swap";

@interface AppDelegate ()
@property (nonatomic, readwrite) SPTAudioStreamingController *player;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Create SPTAuth instance; create login URL and open it
    SPTAuth *auth = [SPTAuth defaultInstance];
    NSURL *loginURL = [auth loginURLForClientId:kClientId
                            declaredRedirectURL:[NSURL URLWithString:kCallbackURL]
                                         scopes:@[SPTAuthStreamingScope]];
    
    // Opening a URL in Safari close to application launch may trigger
    // an iOS bug, so we wait a bit before doing so.
    [application performSelector:@selector(openURL:)
                      withObject:loginURL afterDelay:0.1];
    
    return YES;
}

// Handle auth callback
-(BOOL)application:(UIApplication *)application
           openURL:(NSURL *)url
 sourceApplication:(NSString *)sourceApplication
        annotation:(id)annotation {
    
    // Ask SPTAuth if the URL given is a Spotify authentication callback
    if ([[SPTAuth defaultInstance]
         canHandleURL:url
         withDeclaredRedirectURL:[NSURL URLWithString:kCallbackURL]]) {
        
        // Call the token swap service to get a logged in session
        [[SPTAuth defaultInstance]
         handleAuthCallbackWithTriggeredAuthURL:url
         tokenSwapServiceEndpointAtURL:[NSURL URLWithString:kTokenSwapServiceURL]
         callback:^(NSError *error, SPTSession *session) {
             
             if (error != nil) {
                 NSLog(@"*** Auth error: %@", error);
                 return;
             }
             
             // Call the -playUsingSession: method to play a track
             [self playUsingSession:session];
         }];
        return YES;
    }
    
    return NO;
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
        
        [SPTRequest requestItemAtURI:[NSURL URLWithString:@"spotify:album:4L1HDyfdGIkACuygktO7T7"]
                         withSession:nil
                            callback:^(NSError *error, SPTAlbum *album) {
                                
                                if (error != nil) {
                                    NSLog(@"*** Album lookup got error %@", error);
                                    return;
                                }
                                [self.player playTrackProvider:album callback:nil];
                                
                            }];
    }];
    
}

@end