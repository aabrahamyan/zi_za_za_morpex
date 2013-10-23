//
//  DetailsExploreScrollView.h
//  Joomag
//
//  Created by Armen Abrahamyan on 9/20/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsExploreScrollView : UIScrollView <UIScrollViewDelegate, UIGestureRecognizerDelegate> {
    NSInteger entriesLength;
    int tileW;
    int tileH;
    int index;
    
}

// the main data model for our UIScrollView
@property (nonatomic, strong) NSArray *entries;

- (void) redrawData;

- (void)loadVisibleImages;

@end






