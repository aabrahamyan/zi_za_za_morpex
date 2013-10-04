//
//  HelpView.m
//  Joomag
//
//  Created by Armen Abrahamyan on 10/4/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "HelpView.h"
#import "HelpBO.h"
#import "HelpBU.h"

#define TILE_WIDTH_IPHONE 160
#define TILE_HEIGHT_IPHONE 200
#define TILE_WIDTH_IPAD 178
#define TILE_HEIGHT_IPAD 120

@implementation HelpView

- (id) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.frame = frame;//
        self.entries = [[NSMutableArray alloc] init];
        // Set BackGround Color
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        
        for (int i = 0;i < 9; i++) {
            HelpBO * bo = [[HelpBO alloc] init];
            bo.title = @"How to read a magazine ?";
            bo.url = [NSURL URLWithString:@"http://www.joomag.com"];
            
            [self.entries addObject:bo];
        }
        
    }
    return self;
}

- (void) redrawData {
    
    entriesLength = self.entries.count;
    
    // Load the initial set of pages that are on screen
    [self loadVisibleImages];
}

- (void) loadVisibleImages {
    // First, determine which page is currently visible
    
    // With some valid UIView *view:
    for(UIView *subview in [self subviews]) {
        if (subview.tag > 0) {
            [subview removeFromSuperview];  //TODO: change subview frame
        }
    }
    
    int yPosition = 0;
    int xPosition = 0;
    
    //NSLog(@"self.frame.size.width: %f", self.frame.size.width);
    
    for (int i = 0; i < entriesLength; i++) {
        HelpBO * bo = nil;
        bo = [self.entries objectAtIndex: i];
       
        HelpBU * helpBu = [[HelpBU alloc] initWithFrame:CGRectMake(xPosition, yPosition, TILE_WIDTH_IPAD, TILE_HEIGHT_IPAD)];
        helpBu.helpBo = bo;
        [helpBu setTileTitle:xPosition:yPosition];
        
        [self addSubview: helpBu];
        
        xPosition += 110;
        if(xPosition >= self.frame.size.width - 260) {
            xPosition = 0;
            yPosition += 80;
        }
        
        helpBu.tag = i+1;
    }
    
    [self setContentSize:CGSizeMake(self.frame.size.width, (yPosition+80) * 2)];
}

@end
