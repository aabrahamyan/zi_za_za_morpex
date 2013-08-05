//
//  FeaturedViewController.h
//  Joomag
//
//  Created by Armen Abrahamyan on 7/19/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResponseTrackerDelegate.h"
#import "FeaturedScrollView.h"
#import "FeaturedDetailsView.h"

@class FeaturedScrollView;
@class FeaturedDetailsView;

@interface FeaturedViewController : UIViewController <ResponseTrackerDelegate>  {
    
@protected
    FeaturedScrollView    *scrollView;
    UIPageControl *pageControl;
    FeaturedDetailsView *detailsView;
}

- (void)showDetailsView: (NSInteger)page;


@end
