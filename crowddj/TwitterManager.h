//
//  TwitterManager.h
//  crowddj
//
//  Created by Tommy Brown on 4/3/15.
//  Copyright (c) 2015 tommista. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwitterManager : NSObject

+(TwitterManager *) sharedTwitterManager;
- (void) initialize;
- (void) fetchTweetsWithHashtag: (NSString *) hashtag;
- (void) setHashtag: (NSString *)value;
- (void) refresh;

@end
