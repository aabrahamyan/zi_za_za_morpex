//
//  MyLibScrollView.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-09-05.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "MyLibScrollView.h"
#import "MainDataHolder.h"
#import "MagazinRecord.h"
#import "UIImageView+WebCache.h"

#define TILE_WIDTH_IPHONE 160
#define TILE_HEIGHT_IPHONE 200
#define TILE_WIDTH_IPAD 220
#define TILE_HEIGHT_IPAD 28

@implementation MyLibScrollView{
    NSInteger entriesLength;
    int tileW;
    int tileH;
    int index;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        // self.backgroundColor = [UIColor greenColor];
        // self.pagingEnabled = YES;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.contentMode = UIViewContentModeTopRight;
        self.autoresizingMask =(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        self.delegate = self;
    }
    
    return self;
}

- (void) redrawData {
    self.entries = [MainDataHolder getInstance].testData;
    entriesLength = self.entries.count;
    
    //NSLog(@"data: %@", self.entries);
    
    // Load the initial set of pages that are on screen
    [self loadVisibleImages];
}


// -------------------------------------------------------------------------------
// loadVisibleImages
// Load the images which are now on screen
// -------------------------------------------------------------------------------
- (void)loadVisibleImages {
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
        MagazinRecord *mRec = [[MagazinRecord alloc] init];
        mRec = [self.entries objectAtIndex: i];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(xPosition, yPosition, 180, 240)];
        
        [imageView setImageWithURL: [NSURL URLWithString: mRec.magazinDetailsImageURL] placeholderImage: nil options:SDWebImageProgressiveDownload];
        
        [self addSubview: imageView];
        
        xPosition += 210;
        if(xPosition >= self.frame.size.width){
            xPosition = 0;
            yPosition += 260;
        }
        
        imageView.tag = i+1;
    }
    
    [self setContentSize:CGSizeMake(self.frame.size.width, yPosition+260)];
}

// -------------------------------------------------------------------------------
// setTilesWithArray: tileWidth: andHeight:
// Set the images in scroll view
// -------------------------------------------------------------------------------
- (void)setTilesWithArray: (NSArray *)arr tileWidth: (int)width andHeight: (int)height {
    
    int xPosition = 0;
    int yPosition = 0;
    int offsetX = 0;
    index = [arr count];
    
    for (int i = 0; i < entriesLength; i ++) {
        
        if(i%index == 0 && i!=0){
            offsetX += index/2*width;
        }
        
        xPosition = offsetX + [arr[i%index][0] intValue]*width;
        yPosition = [arr[i%index][1] intValue]*height;
        
        //NSLog(@"x: %d y: %d index: %i",xPosition, yPosition, index);
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(xPosition, yPosition, tileW, tileH)];
        imageView.image = [UIImage imageNamed:@"placeholder.png"];
        imageView.tag = i+1;
        
        [self addSubview:imageView];
    }
    
    // Set up the content size of the scroll view for IPHONE
    self.contentSize = CGSizeMake(2*660, self.frame.size.height); //TODO
}

@end
