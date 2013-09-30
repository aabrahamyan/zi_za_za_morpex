//
//  FaceBookUtil.h
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-09-27.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

@interface FaceBookUtil : NSObject

@property (strong, nonatomic) FBSession *session;
@property (nonatomic, copy) void (^completionHandler)(void);

+ (FaceBookUtil *) getInstance;

- (void) createNewSession;
- (void) closeSession;
- (void) openSessionWithCompletionHandler;

@end
