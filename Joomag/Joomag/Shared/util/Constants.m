//
//  Constants.m
//  Joomag
//
//  Created by Armen Abrahamyan on 7/29/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "Constants.h"

//-------------- Main Request/Response handling ---------------//
NSString * const SERVICE_URL = @"http://www.joomag.com/Frontend/WebService/gateway.php";
NSString * const MAIN_POST_PARAM = @"req";

NSString * const ENVELOPE = @"Envelope";
NSString * const HEADER = @"Header";
NSString * const REQUEST = @"Request";
NSString * const RESPONSE = @"Response";
NSString * const RIGHT_SLASH = @"/";
NSString * const SMALL_BRACKET = @"<";
NSString * const BIG_BRACKET = @">";

NSString * const GUID;

//-------------- Login Request/Response handling ---------------//
NSString * const LOGIN = @"LOGIN";
NSString * const EMAIL = @"email"; 
NSString * const PASSWORD = @"password"; 

//-------------- GETMAGAZINEMOBILE Request/Response handling ---------------//
NSString * const GETMAGAZINE_MOBILE = @"GETMAGAZINEMOBILE";
NSString * const MAGAZINE_ID = @"ID";

//-------------- GETPAGEMOBILE Request/Response handling ---------------//
NSString * const GETPAGE_MOBILE = @"GETPAGEMOBILE";
NSString * const PAGE_MAGAZINE_ID = @"MAGAZINE_ID";
NSString * const PAGE_NUMABER = @"PAGE_NUM";

//-------------- GETMAGAZINES LIST Request/Response handling ---------------//
NSString * const GETMAGAZINESLIST = @"GETMAGAZINELIST";
NSString * const FEATURED_SPREAD  = @"featured";
//-------------- GET CATEGORIES LIST Request/Response handling ---------------//
NSString * const GETTYPESWITHCATEGORIES = @"GETTYPESWITHCATEGORIES";
//-------------- Constant Value -----------------//
NSString * const RANDOM_BLOCK_NUMBER = @"4tMb0";
NSString * const GK = @"gk";


@implementation Constants

@end
