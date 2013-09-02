//
//  MagazineParser.m
//  Joomag
//
//  Created by Armen Abrahamyan on 8/2/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "MagazineParser.h"

@implementation MagazineParser

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    
    [super parser:parser didStartElement:elementName namespaceURI:namespaceURI qualifiedName:qualifiedName attributes:attributeDict];
    
    if([currentElement isEqualToString:@"magazine"]) {
        magainzeData = [[NSMutableDictionary alloc] init];
                
    }
    
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	[super parser:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
    
    if([elementName isEqualToString:@"magazine"]) {
        [arrayData addObject:magainzeData];
    }
    
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [super parser:parser foundCharacters:string];
    
    if(![currentElement isEqualToString:@"magazine"]) {
        [magainzeData setObject:string forKey:currentElement];
    }
}

@end
