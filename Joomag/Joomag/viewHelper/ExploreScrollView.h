//
//  ExploreScrollView.h
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-08-05.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExploreScrollView : UIScrollView <UIScrollViewDelegate> {
    
}

// the main data model for our UIScrollView
@property (nonatomic, strong) NSArray *entries;
@property (nonatomic, assign) NSInteger currentPage;

- (void)reloadScroll;

@end
