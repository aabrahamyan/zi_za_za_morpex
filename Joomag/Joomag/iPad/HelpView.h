//
//  HelpView.h
//  Joomag
//
//  Created by Armen Abrahamyan on 10/4/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpView : UIScrollView <UIScrollViewDelegate> {
    NSInteger entriesLength;
    int tileW;
    int tileH;
    int index;
}

// the main data model for our UIScrollView
@property (nonatomic, strong) NSMutableArray *entries;

- (void) redrawData;

- (void)loadVisibleImages;

@end
