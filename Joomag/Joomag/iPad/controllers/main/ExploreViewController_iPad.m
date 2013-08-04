//
//  ExploreViewController_iPad.m
//  Joomag
//
//  Created by Armen Abrahamyan on 7/19/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "ExploreViewController_iPad.h"
#import "DataHolder.h"

@interface ExploreViewController_iPad () {
    DataHolder *dataHolder;
    CGRect detailsViewFrame, pageControlFrame, scrollViewFrame;
}

@end

@implementation ExploreViewController_iPad

- (void)loadView { // TODO landscape
    [super loadView];
    
    NSLog(@"ExploreViewController_iPad:");
    
    dataHolder = [DataHolder sharedData];
    
    [self positioningExploreView];
}

- (void)positioningExploreView {
    NSLog(@"positioningExploreView");
    
    UIInterfaceOrientation iOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    switch(iOrientation)
    {
        case UIDeviceOrientationPortrait:
            scrollViewFrame = CGRectMake(0, 0, dataHolder.screenWidth, dataHolder.screenHeight);
            detailsViewFrame = CGRectMake(250, 700, 500, 200);
            pageControlFrame = CGRectMake(0, 30, 768, 30);
            break;
            
        case UIDeviceOrientationLandscapeLeft:
            detailsViewFrame = CGRectMake(500, 430, 500, 200);
            pageControlFrame = CGRectMake(0, 30, 1024, 30);
            break;
            
        case UIDeviceOrientationLandscapeRight:
            detailsViewFrame = CGRectMake(500, 430, 500, 200);
            pageControlFrame = CGRectMake(0, 30, 1024, 30);
            break;
            
        default:
            break;
    };
    
    scrollView.frame = scrollViewFrame;
    pageControl.frame = pageControlFrame;
    detailsView.frame = detailsViewFrame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
