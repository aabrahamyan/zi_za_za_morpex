//
//  RequestHelper.h
//  Joomag
//
//  Created by Armen Abrahamyan on 8/1/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestHelper : NSObject


+ (NSString *) constructAndGetLoginString: (NSString *) email withPassword : (NSString *) password;

+ (NSString *) constructGetMagazineString : (NSInteger) magazineId;

+ (NSString *) constructGetMagazinePageString : (NSInteger) magazineId withPageNumber : (NSInteger) pageNumber;

+ (NSString *) constructAndGetMagazinesListRequestString: (NSString *) magazineTypes : (NSString *) searchKeyWord : (NSString *) categoryId : (NSString *) categoryName;

+ (NSString *) constructAndGetCategoriesRequestString;

@end
