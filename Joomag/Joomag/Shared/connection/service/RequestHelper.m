//
//  RequestHelper.m
//  Joomag
//
//  Created by Armen Abrahamyan on 8/1/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "RequestHelper.h"
#import "Constants.h"

@implementation RequestHelper

+ (NSString *) constructAndGetLoginString: (NSString *) email withPassword : (NSString *) password {
    
    //---------------------- Open Envelope ---------------------------------//
    NSString * requestString = [NSString stringWithFormat:@"%@", SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",ENVELOPE];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    //---------------------- Open Header ---------------------------------//
    requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",HEADER];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    //---------------------- Close Header ---------------------------------//
    requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",RIGHT_SLASH];
    requestString = [requestString stringByAppendingFormat:@"%@",HEADER];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    //---------------------- Open Request ---------------------------------//
    requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",REQUEST];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    //---------------------- Open LOGIN ---------------------------------//
    requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",LOGIN];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    //---------------------- Open Email ---------------------------------//
    requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",EMAIL];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    //---------------------- Set Email Value ---------------------------------//
    requestString = [requestString stringByAppendingFormat:@"%@", email];
    requestString = [requestString stringByAppendingFormat:@"%@", SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",RIGHT_SLASH];
    requestString = [requestString stringByAppendingFormat:@"%@", EMAIL];
    requestString = [requestString stringByAppendingFormat:@"%@", BIG_BRACKET];
    //---------------------- Open Password ---------------------------------//
    requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",PASSWORD];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    //---------------------- Set Password Value & Close ------------------------------//
    requestString = [requestString stringByAppendingFormat:@"%@", password];
    requestString = [requestString stringByAppendingFormat:@"%@", SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",RIGHT_SLASH];
    requestString = [requestString stringByAppendingFormat:@"%@", PASSWORD];
    requestString = [requestString stringByAppendingFormat:@"%@", BIG_BRACKET];
    //---------------------- Close LOGIN ---------------------------------//
    requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",RIGHT_SLASH];
    requestString = [requestString stringByAppendingFormat:@"%@",LOGIN];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    //---------------------- Close Request ---------------------------------//
    requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",RIGHT_SLASH];
    requestString = [requestString stringByAppendingFormat:@"%@",REQUEST];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    //---------------------- Close Envelope ---------------------------------//
    requestString = [NSString stringWithFormat:@"%@", SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",RIGHT_SLASH];
    requestString = [requestString stringByAppendingFormat:@"%@",ENVELOPE];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    
    return requestString;
    
}

@end
