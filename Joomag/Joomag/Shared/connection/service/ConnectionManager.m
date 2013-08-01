//
//  ConnectionManager.m
//  Joomag
//
//  Created by Armen Abrahamyan on 8/1/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "ConnectionManager.h"
#import "AFHTTPClient.h"
#import "Constants.h"
#import "RequestHelper.h"

#import "LoginResponseParser.h"

@implementation ConnectionManager

/**
 * Request for Login, with uname(email) & password
 * Params: email, pass, callback object, selector function
 */
- (void) constructLoginRequest: (NSString * ) email withPassword : (NSString *) password withCallback : (id<ResponseTrackerDelegate>) callback {
    
    AFHTTPClient * requestClient =
            [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:SERVICE_URL]];
    
    NSString * loginJCSIPRequestString = [RequestHelper constructAndGetLoginString:email withPassword:password];
    
    if(loginJCSIPRequestString) {
        
        NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:loginJCSIPRequestString, MAIN_POST_PARAM, nil];
        
        [requestClient postPath:@"" parameters:params
         
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                LoginResponseParser * loginResponseParser = [[LoginResponseParser alloc] init];
                
                NSArray * resultArray = [loginResponseParser parserData:responseObject];
                [callback didFinishResponse:resultArray];
            }
         
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {                
                [callback didFailResponse:error];
            }
         ];
        
    }
    
}

@end
