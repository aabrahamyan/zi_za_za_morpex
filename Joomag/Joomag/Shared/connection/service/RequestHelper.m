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
    requestString = [requestString stringByAppendingFormat:@"%@", SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",RIGHT_SLASH];
    requestString = [requestString stringByAppendingFormat:@"%@",ENVELOPE];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    
    return requestString;
    
}

+ (NSString *) constructGetMagazineString : (NSInteger) magazineId {
    
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
    //---------------------- Open Magazine Mobile -------------------------//
    requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",GETMAGAZINE_MOBILE];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    //---------------------- Open Magazine ID -------------------------//
    requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",MAGAZINE_ID];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    //---------------------- Open Value of ID -------------------------//
    requestString = [requestString stringByAppendingFormat:@"%d",magazineId];
    requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",RIGHT_SLASH];
    requestString = [requestString stringByAppendingFormat:@"%@",MAGAZINE_ID];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    //---------------------- Close Magazine Mobile -------------------------//
    requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",RIGHT_SLASH];
    requestString = [requestString stringByAppendingFormat:@"%@",GETMAGAZINE_MOBILE];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    //---------------------- Close Request ---------------------------------//
    requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",RIGHT_SLASH];
    requestString = [requestString stringByAppendingFormat:@"%@",REQUEST];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    //---------------------- Close Envelope ---------------------------------//
    requestString = [requestString stringByAppendingFormat:@"%@", SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",RIGHT_SLASH];
    requestString = [requestString stringByAppendingFormat:@"%@",ENVELOPE];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    
    return requestString;
}

+ (NSString *) constructGetMagazinePageString : (NSInteger) magazineId withPageNumber : (NSInteger) pageNumber {
    
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
    //---------------------- Open Get Page ---------------------------------//
    requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",GETPAGE_MOBILE];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    //---------------------- Open Magazine ID ---------------------------------//
    requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",PAGE_MAGAZINE_ID];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    //---------------------- Open Magazine ID VALUE ------------------------------//
    requestString = [requestString stringByAppendingFormat:@"%d",magazineId];
    requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",RIGHT_SLASH];
    requestString = [requestString stringByAppendingFormat:@"%@",PAGE_MAGAZINE_ID];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    //---------------------- Open PageNumber ------------------------------//
    requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",PAGE_NUMABER];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    //---------------------- Open PageNumber VALUE ------------------------------//
    requestString = [requestString stringByAppendingFormat:@"%d",pageNumber];
    requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",RIGHT_SLASH];
    requestString = [requestString stringByAppendingFormat:@"%@",PAGE_NUMABER];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    //---------------------- Close Get Page ---------------------------------//
    requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",RIGHT_SLASH];
    requestString = [requestString stringByAppendingFormat:@"%@",GETPAGE_MOBILE];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    //---------------------- Close Request ---------------------------------//
    requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",RIGHT_SLASH];
    requestString = [requestString stringByAppendingFormat:@"%@",REQUEST];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    //---------------------- Close Envelope ---------------------------------//
    requestString = [requestString stringByAppendingFormat:@"%@", SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",RIGHT_SLASH];
    requestString = [requestString stringByAppendingFormat:@"%@",ENVELOPE];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    
    return requestString;
    
}

+ (NSString *) constructAndGetMagazinesListRequestString: (NSString *) magazineTypes : (NSString *) searchKeyWord : (NSString *) categoryId : (NSString *) categoryName {
    
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
    //---------------------- Open Magazines List --------------------------//
    requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",GETMAGAZINESLIST];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    //---------------------- Featured Spread ------------------------------//
    requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",magazineTypes];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",RIGHT_SLASH];
    requestString = [requestString stringByAppendingFormat:@"%@",magazineTypes];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    
    if(searchKeyWord) {
        requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
        requestString = [requestString stringByAppendingFormat:@"%@",@"keywords"];
        requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
        requestString = [requestString stringByAppendingFormat:@"%@",searchKeyWord];
        requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
        requestString = [requestString stringByAppendingFormat:@"%@",RIGHT_SLASH];
        requestString = [requestString stringByAppendingFormat:@"%@",@"keywords"];
        requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    }
    
    if(categoryId) {
        requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
        requestString = [requestString stringByAppendingFormat:@"%@",@"cat_ID"];
        requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
        requestString = [requestString stringByAppendingFormat:@"%@",categoryId];
        requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
        requestString = [requestString stringByAppendingFormat:@"%@",RIGHT_SLASH];
        requestString = [requestString stringByAppendingFormat:@"%@",@"cat_ID"];
        requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    } else if (categoryName) {
        requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
        requestString = [requestString stringByAppendingFormat:@"%@",@"category"];
        requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
        requestString = [requestString stringByAppendingFormat:@"%@",categoryName];
        requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
        requestString = [requestString stringByAppendingFormat:@"%@",RIGHT_SLASH]; 
        requestString = [requestString stringByAppendingFormat:@"%@",@"category"];
        requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    }
    
    requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",RIGHT_SLASH];
    requestString = [requestString stringByAppendingFormat:@"%@",GETMAGAZINESLIST];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    //---------------------- Close Request ---------------------------------//
    requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",RIGHT_SLASH];
    requestString = [requestString stringByAppendingFormat:@"%@",REQUEST];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    //---------------------- Close Envelope ---------------------------------//
    requestString = [requestString stringByAppendingFormat:@"%@", SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",RIGHT_SLASH];
    requestString = [requestString stringByAppendingFormat:@"%@",ENVELOPE];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    
    return requestString;
    
}

+ (NSString *) constructAndGetCategoriesRequestString {

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
    //---------------------- Open Categories ---------------------------------//
    requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@", GETTYPESWITHCATEGORIES];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",RIGHT_SLASH];
    requestString = [requestString stringByAppendingFormat:@"%@", GETTYPESWITHCATEGORIES];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    //---------------------- Close Request ---------------------------------//
    requestString = [requestString stringByAppendingFormat:@"%@",SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",RIGHT_SLASH];
    requestString = [requestString stringByAppendingFormat:@"%@",REQUEST];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    //---------------------- Close Envelope ---------------------------------//
    requestString = [requestString stringByAppendingFormat:@"%@", SMALL_BRACKET];
    requestString = [requestString stringByAppendingFormat:@"%@",RIGHT_SLASH];
    requestString = [requestString stringByAppendingFormat:@"%@",ENVELOPE];
    requestString = [requestString stringByAppendingFormat:@"%@",BIG_BRACKET];
    
    return requestString; 
    
}

@end
