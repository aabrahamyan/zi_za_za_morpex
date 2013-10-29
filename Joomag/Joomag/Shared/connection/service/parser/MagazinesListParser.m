//
//  MagazinesListParser.m
//  Joomag
//
//  Created by Armen Abrahamyan on 8/14/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "MagazinesListParser.h"
#import "MainDataHolder.h"
#import "MagazinRecord.h"


@implementation MagazinesListParser

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    
    [super parser:parser didStartElement:elementName namespaceURI:namespaceURI qualifiedName:qualifiedName attributes:attributeDict];
    
    upperLeverElem = elementName;
    
    if([elementName isEqualToString:@"magazine"]) {
        magazinesDictionary = [[NSMutableDictionary alloc] init];
    }
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	[super parser:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
    
    if([elementName isEqualToString:@"magazine"]) {
        [arrayData addObject:magazinesDictionary];
    }
    
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [super parser:parser foundCharacters:string];
    
    //if([upperLeverElem isEqualToString:@"magazine"]) {
    if(![currentElement isEqualToString:@"magazine"]) {
        
        if([currentElement isEqualToString:@"firstpage_hr"]) {
            if(![string isEqualToString:@"&"] && ![string isEqualToString:@"si=1"]) {
                string = [string stringByAppendingFormat:@"%@",@"&si=1"];
            }
        }
        
        if(![string isEqualToString:@"&"] && ![string isEqualToString:@"si=1"]) {
            [magazinesDictionary setObject:string forKey:currentElement];
        }
    }
    //}
}


- (void) bindArrayToMappingObject: (NSString *) magType {
    NSArray * list = nil;
    
    if([magType isEqualToString:@"featured"]) {
       list = [MainDataHolder getInstance].magazinesList;
    } else if ([magType isEqualToString:@"Popular"]) {
       list =  [MainDataHolder getInstance].popularMagList;
    } else if ([magType isEqualToString:@"Highlighted"]) {
        list =  [MainDataHolder getInstance].highlightedMagList;
    } else if (!magType) {
        list =  [MainDataHolder getInstance].filteredCategories; 
    }
        
    
    [[MainDataHolder getInstance].testData removeAllObjects];
    for (int counter = 0; counter < [list count]; counter ++) {
        NSDictionary * currentMagazine = [list objectAtIndex:counter];
        
        if(currentMagazine) {
            MagazinRecord * mgRecord = [[MagazinRecord alloc] init];
            mgRecord.magazinTitle = [currentMagazine objectForKey:@"title"];
            mgRecord.magazinDate = [currentMagazine objectForKey:@"date"];
            mgRecord.magazinImageURL = [currentMagazine objectForKey:@"featured_spread"];
            mgRecord.magazinDetailsImageURL = [currentMagazine objectForKey:@"firstpage"];
            mgRecord.magazinDetailsText = [currentMagazine objectForKey:@"desc"];
            mgRecord.magazineID = [[currentMagazine objectForKey:@"ID"] intValue];
            mgRecord.magazinPrice = [currentMagazine objectForKey:@"price"];
            
            NSLog(@"POPULAR: %@", mgRecord.magazinImageURL);
            
            [[MainDataHolder getInstance].magazinesTitleList addObject:mgRecord.magazinTitle];
            [[MainDataHolder getInstance].testData addObject:mgRecord];
        }
    }    
    
}

@end
