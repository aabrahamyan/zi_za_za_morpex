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
@class DetailsExploreScrollView;

@interface ExploreViewController : UIViewController <ResponseTrackerDelegate> {
    
@protected
    UIView * topBar;
    UILabel * topBarTitleLabel;
    UILabel * firstBreadCrumb;
    UILabel * secondBreadCrumb;
    
    UIButton *searchBtn;
    UIView *titleLabels;
    UIPageControl *pageControl;
    ExploreScrollView *scrollView;
    ExploreTableView *categoriesTable;
    
    DetailsExploreScrollView * det; 

}

- (void) redrawData;

- (void) redrawDataAndTopBar: (NSString *) breadcrumb withHierarchy : (NSInteger) hierarchy;

@end
