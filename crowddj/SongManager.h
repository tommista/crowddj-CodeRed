//
//  SongManager.h
//  crowddj
//
//  Created by Tommy Brown on 4/3/15.
//  Copyright (c) 2015 tommista. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SongManager : NSObject

+(SongManager *) sharedSongManager;
- (void) initialize;
- (void) addTrackToPlaylist:(NSString *) url;
- (void) clearList;

@end
