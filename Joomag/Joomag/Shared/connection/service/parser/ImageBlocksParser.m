//
//  ImageBlocksParser.m
//  Joomag
//
//  Created by Armen Abrahamyan on 8/14/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "ImageBlocksParser.h"

@implementation ImageBlocksParser

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    
    [super parser:parser didStartElement:elementName namespaceURI:namespaceURI qualifiedName:qualifiedName attributes:attributeDict];
    
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	[super parser:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
    
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [super parser:parser foundCharacters:string];
}


@end
