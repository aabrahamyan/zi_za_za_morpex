//
//  MainDataHolder.m
//  Joomag
//
//  Created by Armen Abrahamyan on 8/14/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "MainDataHolder.h"

@implementation MainDataHolder {
    NSMutableArray *group1;  // TODO: real data
    NSMutableArray *group2; // TODO: real data
}

static MainDataHolder * mainDataHolder;

- (id) init {
    if((self = [super init])) {
        // Init data here
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        self.width = screenRect.size.width;
        self.height = screenRect.size.height;
        
        self.testData = [[NSMutableArray alloc] init];
        self.bookMarkData =[[NSMutableArray alloc] init];
        
        self.popularMagList = [[NSMutableArray alloc] init];
        self.highlightedMagList = [[NSMutableArray alloc] init];
        
        self.popularsData = [[NSMutableArray alloc] init];
        self.highlightedData = [[NSMutableArray alloc] init];
        
        self.categoriesList = [[NSMutableArray alloc] init];
        self.magazinesTitleList = [[NSMutableArray alloc] init];
        
        group1 = [NSMutableArray  arrayWithObjects:
                  [NSArray arrayWithObjects:@"Cat title 1",@"title 1",@"General Information", @"placeholder.png", nil],
                  nil];
        
        group2 = [NSMutableArray  arrayWithObjects:
                  [NSArray arrayWithObjects:@"Cat title 2",@"title 1",@"des 2", @"placeholder.png", nil],
                  [NSArray arrayWithObjects:@"Cat title 2",@"title 2",@"sep 1", @"placeholder.png", nil],
                  [NSArray arrayWithObjects:@"Cat title 2",@"title 3",@"jul 3", @"placeholder.png", nil],
                  [NSArray arrayWithObjects:@"Cat title 2",@"title 4",@"jul 10", @"placeholder.png", nil],
                  nil];
        
        self.myLibMagazines = [NSMutableArray  arrayWithObjects: group1, group2, nil];
    }
    
    return self;
}

+ (MainDataHolder *) getInstance {
    
    if(mainDataHolder == nil) {
        mainDataHolder = [[MainDataHolder alloc] init];
    }
    
    return mainDataHolder;
}

@end
