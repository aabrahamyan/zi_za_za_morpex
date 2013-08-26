//
//  ExploreViewController.h
//  Joomag
//
//  Created by Armen Abrahamyan on 7/19/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExploreScrollView.h"
#import "ResponseTrackerDelegate.h"
#import "ExploreTableView.h"

@class ExploreScrollView;
@class ExploreTableView;

@interface ExploreViewController : UIViewController <ResponseTrackerDelegate> {
    
@protected
    UIView *topBar;
    UILabel *topBarTitleLabel;
    UIButton *searchBtn;
    UIView *titleLabels;
    UIPageControl *pageControl;
    ExploreScrollView *scrollView;
    ExploreTableView *categoriesTable;
}

- (void) redrawData;

@end
