//
//  DetailsExploreScrollView.h
//  Joomag
//
//  Created by Armen Abrahamyan on 9/20/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DetailsExploreScrollViewDelegate <NSObject>
@optional
- (void)readHandlerWithMagazineId: (int)magazineId;
@end

@interface DetailsExploreScrollView : UIScrollView <UIScrollViewDelegate, UIGestureRecognizerDelegate, DetailsExploreScrollViewDelegate> {
    NSInteger entriesLength;
    int tileW;
    int tileH;
    int index;
    
}

@property (weak, nonatomic) id <DetailsExploreScrollViewDelegate> detailsExploreDelegate;

// the main data model for our UIScrollView
@property (nonatomic, strong) NSArray *entries;

- (void) redrawData;

- (void)loadVisibleImages;

@end






