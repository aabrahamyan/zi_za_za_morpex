//
//  DetailsExploreScrollView.m
//  Joomag
//
//  Created by Armen Abrahamyan on 9/20/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "DetailsExploreScrollView.h"
#import "UIImageView+WebCache.h"
#import "MainDataHolder.h"
#import "MagazinRecord.h"

#define TILE_WIDTH_IPHONE 160
#define TILE_HEIGHT_IPHONE 200
#define TILE_WIDTH_IPAD 180
#define TILE_HEIGHT_IPAD 240



@implementation DetailsExploreScrollView {
  
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        
        // Set BackGround Color
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;        
        //self.backgroundColor = [UIColor redColor];
        // Load the initial set of pages that are on screen
        
    }
    
    return self;
}

- (void) redrawData {
    self.entries = [MainDataHolder getInstance].testData;
    entriesLength = self.entries.count;    
    
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
    
    for (int i = 0; i < entriesLength; i++) {
        MagazinRecord * mRec = [[MagazinRecord alloc] init]; 
        mRec = [self.entries objectAtIndex: i];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(xPosition, yPosition, TILE_WIDTH_IPAD, TILE_HEIGHT_IPAD)];
        
        [imageView setImageWithURL: [NSURL URLWithString: mRec.magazinDetailsImageURL] placeholderImage: nil options:SDWebImageProgressiveDownload];
        
        [self addSubview: imageView];
        
        xPosition += 235;
        if(xPosition >= self.frame.size.width) {
            xPosition = 0;
            yPosition += TILE_HEIGHT_IPAD+30;
        }
        
        imageView.tag = i+1;
    }
    
    [self setContentSize:CGSizeMake(self.frame.size.width, yPosition+260)];
}

- (void)changeImagesFrame {
    UIInterfaceOrientation iOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (iOrientation == UIDeviceOrientationPortrait) {
        NSLog(@"11111111");
    } else {
        NSLog(@"22222222");
    }
}

/*

 - (void)loadVisibleImages {
 // First, determine which page is currently visible
 
 // With some valid UIView *view:
 for(UIView *subview in [self subviews]) {
 if (subview.tag > 0) {
 [subview removeFromSuperview];  //TODO: change subview frame
 }
 }
 
 int yPosition = 0;
 int xPosition = 50;
 
 //NSLog(@"self.frame.size.width: %f", self.frame.size.width);
 
 for (int i = 0; i < entriesLength; i++) {
 MagazinRecord * mRec = [[MagazinRecord alloc] init];
 mRec = [self.entries objectAtIndex: i];
 
 UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(xPosition, yPosition, 180, 240)];
 
 [imageView setImageWithURL: [NSURL URLWithString: mRec.magazinDetailsImageURL] placeholderImage: nil options:SDWebImageProgressiveDownload];
 
 [self addSubview: imageView];
 
 xPosition += 210;
 if(xPosition >= self.frame.size.width - 100) {
 xPosition = 50;
 yPosition += 260;
 }
 
 imageView.tag = i+1;
 }
 
 [self setContentSize:CGSizeMake(self.frame.size.width, yPosition+260)];
 }
 
*/



@end
