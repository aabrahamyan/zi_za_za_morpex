//
//  FeaturedViewController_iPad.m
//  Joomag
//
//  Created by Armen Abrahamyan on 7/19/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "FeaturedViewController_iPad.h"
#import "BuyIssueViewController_iPad.h"

@interface FeaturedViewController_iPad () {
    CGRect detailsViewFrame, pageControlFrame, scrollViewFrame;
}

@end

@implementation FeaturedViewController_iPad

- (void)loadView {
    [super loadView];
}

- (void)viewDidLayoutSubviews {
    
    UIInterfaceOrientation iOrientation = [UIApplication sharedApplication].statusBarOrientation;

    if (iOrientation == UIDeviceOrientationPortrait) {
        scrollViewFrame = CGRectMake(0, 0, 768, 959);
        detailsViewFrame = CGRectMake(230, 700, 500, 200);
        pageControlFrame = CGRectMake(0, 50, 768, 30);
    } else {
        scrollViewFrame = CGRectMake(0, 0, 1024, 704);
        detailsViewFrame = CGRectMake(490, 450, 540, 220);
        pageControlFrame = CGRectMake(0, 50, 1024, 30);
    }
    
    scrollView.frame = scrollViewFrame;
    pageControl.frame = pageControlFrame;
    detailsView.frame = detailsViewFrame;
    
    CGRect frm = CGRectMake(0, -20, self.view.bounds.size.width, self.view.bounds.size.height);
    self.view.frame = frm;
    
    [scrollView redrawData];
}

- (BuyIssueViewController_iPad *) getBuyIssueViewController {
    return [[BuyIssueViewController_iPad alloc] init];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
