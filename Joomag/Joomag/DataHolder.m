//
//  DataHolder.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-07-21.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "DataHolder.h"
#import "MagazinRecord.h"
#import "MagazinRecord.h"

// string constants found in the XML
static NSString *kTitleStr         = @"title";
static NSString *kDateStr          = @"date";
static NSString *kImageStr         = @"imageUrl";
static NSString *kDetailsImageStr  = @"detailsImageUrl";
static NSString *kPageImage        = @"pageImage";
static NSString *kDetailsTextStr   = @"detailsText";
static NSString *kMagazineStr      = @"magazine";

@interface DataHolder () <NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableArray *workingArray;
@property (nonatomic, strong) NSMutableString *workingPropertyString;
@property (nonatomic, readwrite) BOOL storingCharacterData;
@property (nonatomic, strong) NSArray *elementsToParse;
@property (nonatomic, strong) MagazinRecord *workingEntry;

@end

@implementation DataHolder


+ (DataHolder *) sharedData {
    static dispatch_once_t pred;
    static DataHolder *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[DataHolder alloc] init];
    });
    
    return shared;
}

- (id)init {
    if (self = [super init]) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        self.screenWidth = screenRect.size.width;
        self.screenHeight = screenRect.size.height;
        
        //self.testData = [NSMutableArray array];
        self.workingArray = [NSMutableArray array];
        self.workingPropertyString = [NSMutableString string];
        self.elementsToParse = [[NSArray alloc] initWithObjects:kTitleStr, kDateStr, kImageStr, kDetailsImageStr, kPageImage, kDetailsTextStr, nil];
        
        NSString *xmlFilePath = [[NSBundle mainBundle] pathForResource:@"testData" ofType:@"xml"];
        NSURL* xmlURL = [NSURL fileURLWithPath:xmlFilePath];
        NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
        parser.delegate = self;
        [parser parse];
    }
    
    return self;
}

#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *) qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:kMagazineStr])
	{
        self.workingEntry = [[MagazinRecord alloc] init];
    }
    self.storingCharacterData = [self.elementsToParse containsObject:elementName];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    
    if (self.workingEntry)
	{
        if (self.storingCharacterData)
        {
            NSString *trimmedString = [self.workingPropertyString stringByTrimmingCharactersInSet:
                                       [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [self.workingPropertyString setString:@""];  // clear the string for next time
            
            if ([elementName isEqualToString:kTitleStr])
            {
                self.workingEntry.magazinTitle = trimmedString;
            }
            else if ([elementName isEqualToString:kDateStr])
            {
                self.workingEntry.magazinDate = trimmedString;
            }
            else if ([elementName isEqualToString:kImageStr])
            {
                self.workingEntry.magazinImageURL = trimmedString;
            }
            else if ([elementName isEqualToString:kDetailsImageStr])
            {
                self.workingEntry.magazinDetailsImageURL = trimmedString;
            }
            else if ([elementName isEqualToString:kDetailsTextStr])
            {
                self.workingEntry.magazinDetailsText = trimmedString;
            }
            else if ([elementName isEqualToString:kPageImage])
            {
                [self.workingEntry.pageImageURLsArray addObject: trimmedString];
            }
            else
            {
                [self.workingArray addObject:self.workingEntry];
                self.workingEntry = nil;
            }
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (self.storingCharacterData)
    {
        [self.workingPropertyString appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    self.testData = [NSArray arrayWithArray:self.workingArray];
    
    /*
     MagazinRecord *m = [[MagazinRecord alloc] init];
     m = [self.testData objectAtIndex:0];
     NSLog(@"magazine: %@",m.pageImageURLsArray);
     */
}

@end
