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
#import "DetailsExploreScrollView.h"

@class ExploreScrollView;
@class ExploreTableView;
@class DetailsExploreScrollView;
@class BuyIssueViewController;

@interface ExploreViewController : UIViewController <ResponseTrackerDelegate, ExploreScrollViewDelegate, DetailsExploreScrollViewDelegate, UITextFieldDelegate> {
    
@protected
    UIView  *topBar;
    UILabel *topBarTitleLabel;
    UIView  *searchBarView;
    UILabel *firstBreadCrumb;
    UILabel *secondBreadCrumb;
    
    UIButton *searchBtn;
    UIView *titleLabels;
    UIPageControl *pageControl;
    ExploreScrollView *scrollView;
    ExploreTableView *categoriesTable;
    UIButton     *backButtonView;
    
    NSMutableArray * firstBreadCrumbData;
    
    DetailsExploreScrollView * det;
    UIActivityIndicatorView * activityIndicator;
}

@property (nonatomic, strong) BuyIssueViewController * buyIssueVC;

- (void) redrawData;
- (void) redrawDataAndTopBar: (NSString *) breadcrumb withHierarchy : (NSInteger) hierarchy;

@end
