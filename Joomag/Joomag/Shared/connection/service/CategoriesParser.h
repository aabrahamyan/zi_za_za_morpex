//
//  CategoriesParser.h
//  Joomag
//
//  Created by Armen Abrahamyan on 8/14/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "BaseParser.h"

@interface CategoriesParser : BaseParser {

    NSString * typeElem;
    NSString * categoriesElem;
    NSString * categoryElem;
    
    NSMutableDictionary * inTypes;
    NSMutableArray * categories;
    NSMutableDictionary * category;

}

@end
