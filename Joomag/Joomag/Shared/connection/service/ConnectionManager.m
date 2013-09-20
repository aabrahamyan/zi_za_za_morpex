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
#import "MagazineParser.h"
#import "PageParser.h"
#import "MagazinesListParser.h"
#import "CategoriesParser.h"
#import "MainDataHolder.h"

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

/**
 * Request for Magazine, with magazineId
 * Params: magazine ID, selector function
 */
- (void) constructGetMagazineRequest: (NSInteger) magazineId withCallback : (id<ResponseTrackerDelegate>) callback {
    
    AFHTTPClient * requestClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:SERVICE_URL]];
    
    NSString * magazineJCSIPRequestString = [RequestHelper constructGetMagazineString:magazineId];
    
    if(magazineJCSIPRequestString) {
        
        NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:magazineJCSIPRequestString, MAIN_POST_PARAM, nil];
        
        [requestClient postPath:@"" parameters:params
         
                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            MagazineParser * magazineResponseParser = [[MagazineParser alloc] init];
                            NSString * str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                            NSData * data = [str dataUsingEncoding:NSUTF8StringEncoding];
                            NSArray * resultArray = [magazineResponseParser parserData:data];
                            [callback didFinishResponse:resultArray];
                        }
         
                        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            [callback didFailResponse:error];
                        }
         ];

        
    }
    
}

/**
 * Request Page for Magazine, with magazineId & pageNumber
 * Params: magazine ID, pageNumber, selector function
 */
- (void) constructGetMapagzinePage: (NSInteger) magazineId withPageNumber : (NSInteger) pageNumber andWithDelegate : (id<ResponseTrackerDelegate>) callback {
    
    AFHTTPClient * requestClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:SERVICE_URL]];
    
    NSString * magazinePageJCSIPRequestString = [RequestHelper constructGetMagazinePageString:magazineId withPageNumber:pageNumber];
    
    if(magazinePageJCSIPRequestString) {
        
        NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:magazinePageJCSIPRequestString, MAIN_POST_PARAM, nil];
        
        [requestClient postPath:@"" parameters:params
         
                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            PageParser * pageResponseParser = [[PageParser alloc] init];
                            
                            //&amp
                            NSString * str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                            str = [str stringByReplacingOccurrencesOfString:@"&" withString:@"amp;" ];
                            NSData * data = [str dataUsingEncoding:NSUTF8StringEncoding];
                            
                            NSArray * resultArray = [pageResponseParser parserData:data];
                            [callback didFinishResponse:resultArray];
                           
                        }
         
                        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            [callback didFailResponse:error];
                        }
         ];
        
        
    }

}

- (void) constructGetMagazinesListRequest : (id<ResponseTrackerDelegate>) callback : (NSString *) magazinesType : (NSString *) searchKeyword : (NSString *) categoryId : (NSString *) categoryName {
    
    __block NSString * magType = magazinesType;
    
    AFHTTPClient * requestClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:SERVICE_URL]];
    
    NSString * magazinesListReqString = [RequestHelper constructAndGetMagazinesListRequestString:magazinesType:searchKeyword:categoryId:categoryName]; 
    
    if(magazinesListReqString) {
        NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:magazinesListReqString,MAIN_POST_PARAM, nil];
        
        [requestClient postPath:@"" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            MagazinesListParser * magListParser = [[MagazinesListParser alloc] init];
            
            if([magType isEqualToString:@"featured"]) {
                [MainDataHolder getInstance].magazinesList = [magListParser parserData:responseObject];
            } else if ([magType isEqualToString:@"Popular"]) {
                [MainDataHolder getInstance].popularMagList = [magListParser parserData:responseObject];
            } else if ([magType isEqualToString:@"Highlighted"]) {
                [MainDataHolder getInstance].highlightedMagList = [magListParser parserData:responseObject];
            } else if(categoryId || categoryName) {
                [MainDataHolder getInstance].filteredCategories = [magListParser parserData:responseObject];

            }
            
            
            [magListParser bindArrayToMappingObject:magType];
            //NSLog(@"[MainDataHolder getInstance].magazinesList = %@",[MainDataHolder getInstance].magazinesList);
            [callback didFinishResponse:magType];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //TODO: Parser call for failure
        }];
    }
}

- (void) constrcutAndGetCategoriesTypesRequest: (id<ResponseTrackerDelegate>) callback {
    AFHTTPClient * requestClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:SERVICE_URL]];
    
    NSString * categoriesRequestString = [RequestHelper constructAndGetCategoriesRequestString];
    
    if(categoriesRequestString) {
        NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:categoriesRequestString,MAIN_POST_PARAM, nil];                
        
        [requestClient postPath:@"" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            CategoriesParser * catsParser = [[CategoriesParser alloc] init];
            [MainDataHolder getInstance].categoriesList = [catsParser parserData:responseObject];
            
            NSLog(@"[MainDataHolder getInstance].categoriesList = %@",[MainDataHolder getInstance].categoriesList);
            

            [callback didFinishResponse:nil];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //TODO: Call in case of failure
        }];
    }
}



@end
