//
//  LoginResponseParser.m
//  Joomag
//
//  Created by Armen Abrahamyan on 8/2/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "LoginResponseParser.h"

@implementation LoginResponseParser

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    
        [super parser:parser didStartElement:elementName namespaceURI:namespaceURI qualifiedName:qualifiedName attributes:attributeDict];
    
    if([currentElement isEqualToString:@"Login"]) {
        accontInfo = [[NSMutableDictionary alloc] init];
    }

}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	[super parser:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
    
    if([elementName isEqualToString:@"envelope"]) {
        [arrayData addObject:accontInfo];
    }
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [super parser:parser foundCharacters:string];
    
    if([currentElement isEqualToString:@"account"]) {
        [accontInfo setObject:string forKey:@"account"];
    } else if ([currentElement isEqualToString:@"type"]) {
        [accontInfo setObject:string forKey:@"type"];
    } else if ([currentElement isEqualToString:@"user"]) {
        [accontInfo setObject:string forKey:@"user"];
    } else if ([currentElement isEqualToString:@"Status"]) {
        [accontInfo setObject:string forKey:@"Status"];
    }
}

@end
