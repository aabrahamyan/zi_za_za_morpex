//
//  FaceBookUtil.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-09-27.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "FaceBookUtil.h"

@implementation FaceBookUtil

static FaceBookUtil *shared = nil;

- (id) init {
    if((self = [super init])) {
        // Init data here

    }
    
    return self;
}

+ (FaceBookUtil *) getInstance {
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        shared = [[FaceBookUtil alloc] init];
    });
    
    return shared;
}

- (void)createNewSession {
    self.session = [[FBSession alloc] init];
    FBSession.activeSession = self.session;
}

- (void) closeSession {
    [FBSession.activeSession closeAndClearTokenInformation];
    self.session = nil;
}

- (void) openSessionWithCompletionHandler {
    [self.session openWithCompletionHandler:^(FBSession *session,
                                                FBSessionState status,
                                                NSError *error) {
        if (self.completionHandler)
            self.completionHandler();
    }];
}




/*
- (void)getTwitterAccountInformation
{
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
        if(granted) {
            NSArray *accountsArray = [accountStore accountsWithAccountType:accountType];
            
            if ([accountsArray count] > 0) {
                ACAccount *twitterAccount = [accountsArray objectAtIndex:0];
                NSLog(@"%@",twitterAccount.username);
                NSLog(@"%@",twitterAccount.accountType);
            }
        }
    }];
}
*/


@end
