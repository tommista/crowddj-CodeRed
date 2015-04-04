//
//  AppDelegate.h
//  crowddj
//
//  Created by Tommy Brown on 4/3/15.
//  Copyright (c) 2015 tommista. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpotifyPlayer.h"
#import "ViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SpotifyPlayer *spotifyPlayer;
@property (nonatomic, strong) ViewController *mainViewController;


@end

