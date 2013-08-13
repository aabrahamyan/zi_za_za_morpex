//
//  MagazinesListParser.m
//  Joomag
//
//  Created by Armen Abrahamyan on 8/14/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "MagazinesListParser.h"

@implementation MagazinesListParser

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    
    [super parser:parser didStartElement:elementName namespaceURI:namespaceURI qualifiedName:qualifiedName attributes:attributeDict];
    
    if([elementName isEqualToString:@"magazine"]) {
        upperLeverElem = elementName;        
        magazinesDictionary = [[NSMutableDictionary alloc] init];
    }
    
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	[super parser:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
    
    if([upperLeverElem isEqualToString:@"magazine"]) {
        [arrayData addObject:magazinesDictionary];
    }
    
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [super parser:parser foundCharacters:string];
    
    if([upperLeverElem isEqualToString:@"magazine"]) {
//        if([currentElement isEqualToString:@"title"]) {
//            [magazinesDictionary setObject:string forKey:@"title"];
//        } else if([currentElement isEqualToString:@"name"]) {
//            [magazinesDictionary setObject:string forKey:@"name"];
//        } else if([currentElement isEqualToString:@"UID"]) {
//            [magazinesDictionary setObject:string forKey:@"UID"];
//        } else if([currentElement isEqualToString:@"date"]) {
//            [magazinesDictionary setObject:string forKey:@"date"];
//        } else if([currentElement isEqualToString:@"desc"]) {
//            [magazinesDictionary setObject:string forKey:@"desc"];
//        } else if([currentElement isEqualToString:@"pages"]) {
//            [magazinesDictionary setObject:string forKey:@"pages"];
//        }
        
        if(currentElement) {
            [magazinesDictionary setObject:string forKey:currentElement];
        }
    }
}

@end
