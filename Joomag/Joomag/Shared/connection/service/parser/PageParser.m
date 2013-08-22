//
//  PageParser.m
//  Joomag
//
//  Created by Armen Abrahamyan on 8/2/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "PageParser.h"

@implementation PageParser

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    
    [super parser:parser didStartElement:elementName namespaceURI:namespaceURI qualifiedName:qualifiedName attributes:attributeDict];
    
    if([currentElement isEqualToString:@"GetPageMobile"]) {
        blockTokens = [[NSMutableArray alloc] init];
        activeData = [[NSMutableArray alloc] init];
    } else if ([currentElement isEqualToString:@"block_tokens"]) {        
        blockTokensActiveData = currentElement;
    } else if ([currentElement isEqualToString:@"active_data"]) {        
        blockTokensActiveData = currentElement;
    } else if ([currentElement isEqualToString:@"block"]) {
        blocks = [[NSMutableDictionary alloc] init];
        blockOrHotspotLevel = currentElement;
    } else if ([currentElement isEqualToString:@"hotspot"]) {
        hotSpots = [[NSMutableDictionary alloc] init];
        blockOrHotspotLevel = currentElement;
    }
    
    
    
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	[super parser:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
    
    if([elementName isEqualToString:@"block"]) {
        [blockTokens addObject:blocks];
    } else if ([elementName isEqualToString:@"hotspot"]) {
        [activeData addObject:hotSpots];
    } else if ([elementName isEqualToString:@"GetPageMobile"]) {
        [arrayData addObject:blockTokens];
        [arrayData addObject:activeData]; 
    }
    
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [super parser:parser foundCharacters:string];
    
        if([blockTokensActiveData isEqualToString:@"block_tokens"] && [blockOrHotspotLevel isEqualToString:@"block"]) {
            [blocks setObject:string forKey:currentElement];
        } else if ([blockTokensActiveData isEqualToString:@"active_data"] && [blockOrHotspotLevel isEqualToString:@"hotspot"]) {
            [hotSpots setObject:string forKey:currentElement];
        }
    
}


@end
