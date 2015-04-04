//
//  ViewController.h
//  crowddj
//
//  Created by Tommy Brown on 4/3/15.
//  Copyright (c) 2015 tommista. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpotifyPlayer.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) SpotifyPlayer* spotifyPlayer;

@end

