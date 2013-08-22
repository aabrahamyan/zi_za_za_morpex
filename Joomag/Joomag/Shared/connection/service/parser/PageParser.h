//
//  PageParser.h
//  Joomag
//
//  Created by Armen Abrahamyan on 8/2/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseParser.h"

@interface PageParser : BaseParser {
    NSString * upperPageElem;
    NSMutableDictionary * elems;
    
    //---------- Elems --------------//
    NSString * blockTokensActiveData;
    NSString * activeDataLevel;
    
    NSString * blockOrHotspotLevel;
    //---------- Collections -------//
    NSMutableArray * blockTokens;
    NSMutableDictionary * blocks;
    NSMutableArray * activeData;
    NSMutableDictionary * hotSpots;
}

@end
