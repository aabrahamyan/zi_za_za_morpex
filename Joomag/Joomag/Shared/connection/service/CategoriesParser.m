//
//  CategoriesParser.m
//  Joomag
//
//  Created by Armen Abrahamyan on 8/14/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "CategoriesParser.h"

@implementation CategoriesParser

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    
    [super parser:parser didStartElement:elementName namespaceURI:namespaceURI qualifiedName:qualifiedName attributes:attributeDict];

    if([elementName isEqualToString:@"type"]) {
        typeElem = elementName;
        inTypes = [[NSMutableDictionary alloc] init];
    } else if ([elementName isEqualToString:@"categories"]) {
        categoriesElem = elementName;
        categories = [[NSMutableArray alloc] init];        
    } else if ([elementName isEqualToString:@"category"]) {
        categoryElem = elementName;
        category = [[NSMutableDictionary alloc] init];
    }

    
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	[super parser:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
    
    if([elementName isEqualToString:@"category"]) {
        [categories addObject:category];
    }
    
    if([elementName isEqualToString:@"categories"]) {
        [inTypes setObject:categories forKey:@"cats"];
    }
    
    if([elementName isEqualToString:@"type"]) {
        [arrayData addObject:inTypes];
    }
    
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [super parser:parser foundCharacters:string];
    
    if([typeElem isEqualToString:@"type"]) {
        
        if([categoriesElem isEqualToString:@"categories"]) {
            if([categoryElem isEqualToString:@"category"]) {
                [category setObject:string forKey:currentElement];
            }
        }
        
        if([currentElement isEqualToString:@"ID"]) {
            [inTypes setObject:string forKey:@"ID"];
        } else if ([currentElement isEqualToString:@"name"]) {
            [inTypes setObject:string forKey:@"name"];
        }
        
        
    }
}

@end
