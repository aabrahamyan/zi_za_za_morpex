//
//  BaseParser.m
//  Joomag
//
//  Created by Armen Abrahamyan on 8/2/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "BaseParser.h"

@implementation BaseParser

-(id) init {
    self = [super init];
    if(self) {
        arrayData = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSMutableArray*) parserData:(NSData*)data {
	NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
	[xmlParser setDelegate:self];
	[xmlParser parse];
	
	return arrayData;
}

- (void) parserDidStartDocument:(NSXMLParser *)parser {
	
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
	attributes:(NSDictionary *)attributeDict {

        currentElement = elementName;
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
	
	
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
    
}

- (void)parser:(NSXMLParser *)parser foundIgnorableWhitespace:(NSString *)whitespaceString {
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSString * errorString = [NSString stringWithFormat:@" (Error code %i )", [parseError code]];
	NSLog(@"errorString = %@", errorString);
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
}


@end
