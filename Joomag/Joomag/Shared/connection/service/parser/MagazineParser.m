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
    

    
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [super parser:parser foundCharacters:string];
    
    if([currentElement isEqualToString:@"ID"]) {
        [magainzeData setObject:string forKey:@"ID"];
    } else if ([currentElement isEqualToString:@"title"]) {
        [magainzeData setObject:string forKey:@"title"];
    } else if ([currentElement isEqualToString:@"width"]) {
        [magainzeData setObject:string forKey:@"width"];
    } else if ([currentElement isEqualToString:@"height"]) {
        [magainzeData setObject:string forKey:@"height"];
    } else if ([currentElement isEqualToString:@"page_count"]) {
        [magainzeData setObject:string forKey:@"page_count"];
    } else if ([currentElement isEqualToString:@"price"]) {
        [magainzeData setObject:string forKey:@"price"];
    } else if ([currentElement isEqualToString:@"UID"]) {
        [magainzeData setObject:string forKey:@"UID"];
    } else if ([currentElement isEqualToString:@"bg_music"]) {
        [magainzeData setObject:string forKey:@"bg_music"];
    } else if ([currentElement isEqualToString:@"lang_ID"]) {
        [magainzeData setObject:string forKey:@"lang_ID"];
    } else if ([currentElement isEqualToString:@"cover_url"]) {
        [magainzeData setObject:string forKey:@"cover_url"];
    } else if ([currentElement isEqualToString:@"imgWz1"]) {
        [magainzeData setObject:string forKey:@"imgWz1"];
    } else if ([currentElement isEqualToString:@"imgHz1"]) {
        [magainzeData setObject:string forKey:@"imgHz1"];
    } else if ([currentElement isEqualToString:@"imgWz2"]) {
        [magainzeData setObject:string forKey:@"imgWz2"];
    } else if ([currentElement isEqualToString:@"imgHz2"]) {
        [magainzeData setObject:string forKey:@"imgHz2"];
    } else if ([currentElement isEqualToString:@"z1X"]) {
        [magainzeData setObject:string forKey:@"z1X"];
    } else if ([currentElement isEqualToString:@"z1Y"]) {
        [magainzeData setObject:string forKey:@"z1Y"];
    } else if ([currentElement isEqualToString:@"z2X"]) {
        [magainzeData setObject:string forKey:@"z2X"];
    } else if ([currentElement isEqualToString:@"z2Y"]) {
        [magainzeData setObject:string forKey:@"z2Y"];
    } else if ([currentElement isEqualToString:@"last_modified"]) {
        [magainzeData setObject:string forKey:@"last_modified"];
    }
}


@end
