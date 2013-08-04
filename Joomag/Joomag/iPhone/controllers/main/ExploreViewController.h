//
//  ExploreViewController.h
//  Joomag
//
//  Created by Armen Abrahamyan on 7/19/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResponseTrackerDelegate.h"
#import "ScrollView.h"
#import "ExploreDetailsView.h"

@class ScrollView;
@class ExploreDetailsView;

@interface ExploreViewController : UIViewController <ResponseTrackerDelegate>  {
    
@protected
    ScrollView    *scrollView;
    UIPageControl *pageControl;
    ExploreDetailsView *detailsView;
}

- (void)showDetailsView: (NSInteger)page;


@end
