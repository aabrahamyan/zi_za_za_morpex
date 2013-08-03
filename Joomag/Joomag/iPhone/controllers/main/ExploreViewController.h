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

@class ScrollView;

@interface ExploreViewController : UIViewController <ResponseTrackerDelegate>  {
    
@protected
    ScrollView    *scrollView;
    UIPageControl *pageControl;
    UIView        *detailsViewContainer;
    UIView        *detailsViewBackGround;
    UIImageView   *detailsImageView;
    UILabel       *detailsTitle;
    UILabel       *detailsDate;
    UITextView    *detailsText;
    UIButton      *readBtn;
    UIButton      *buyIssueBtn;
    UIButton      *shareBtn;
}

- (void)showDetailsView: (NSInteger)page;


@end
