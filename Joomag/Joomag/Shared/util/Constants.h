//
//  Constants.h
//  Joomag
//
//  Created by Armen Abrahamyan on 7/29/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <Foundation/Foundation.h>

//-------------- Main Request/Response handling ---------------//
extern NSString * const SERVICE_URL;
extern NSString * const MAIN_POST_PARAM;

extern NSString * const ENVELOPE;
extern NSString * const HEADER;
extern NSString * const REQUEST;
extern NSString * const RESPONSE;
extern NSString * const RIGHT_SLASH;
extern NSString * const SMALL_BRACKET;
extern NSString * const BIG_BRACKET;

extern NSString * const GUID;

//-------------- Login Request/Response handling ---------------//
extern NSString * const LOGIN;
extern NSString * const EMAIL;
extern NSString * const PASSWORD;

//-------------- GETMAGAZINEMOBILE Request/Response handling ---------------//
extern NSString * const GETMAGAZINE_MOBILE;
extern NSString * const MAGAZINE_ID;

//-------------- GETPAGEMOBILE Request/Response handling ---------------//
extern NSString * const GETPAGE_MOBILE;
extern NSString * const PAGE_MAGAZINE_ID;
extern NSString * const PAGE_NUMABER;

//-------------- GETMAGAZINESLIST Request/Response handling ---------------//
extern NSString * const GETMAGAZINESLIST;
//-------------- GET CATEGORIES LIST Request/Response handling ---------------//
extern NSString * const GETTYPESWITHCATEGORIES;
//--------------

@interface Constants : NSObject

@end
