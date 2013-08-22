//
//  ExploreViewController.h
//  Joomag
//
//  Created by Armen Abrahamyan on 7/19/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExploreScrollView.h"

@class ExploreScrollView;

@interface ExploreViewController : UIViewController {
    
@protected
    UIView *topBar;
    UILabel *topBarTitleLabel;
    UIButton *searchBtn;
    UIView *titleLabels;
    UIPageControl *pageControl;
    ExploreScrollView *scrollView;
}

- (void) redrawData;

@end
