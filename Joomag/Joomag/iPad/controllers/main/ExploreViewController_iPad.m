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
    CGRect titleLabelsViewFrame, pageControlFrame, scrollViewFrame;
}

@end

@implementation ExploreViewController_iPad

- (void)loadView {
    [super loadView];
    
    NSLog(@"ExploreViewController_iPad");
    
    dataHolder = [DataHolder sharedData];
}



- (void)viewDidLayoutSubviews {
    
    UIInterfaceOrientation iOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    switch(iOrientation)
    {
        case UIDeviceOrientationPortrait:
            
            titleLabelsViewFrame = CGRectMake(0, 30, 768, 30);
            pageControlFrame = CGRectMake(0, 30, 768, 30);
            
            break;
            
        case UIDeviceOrientationLandscapeLeft:
            scrollViewFrame = CGRectMake(70, 80, 660, 520);
            titleLabelsViewFrame = CGRectMake(70, 30, 300, 30);
            pageControlFrame = CGRectMake(70, 600, 610, 30);
            break;
            
        case UIDeviceOrientationLandscapeRight:
            
            pageControlFrame = CGRectMake(0, 30, 1024, 30);
            break;
            
        default:
            break;
    };
    
    titleLabels.frame = titleLabelsViewFrame;
    scrollView.frame = scrollViewFrame;
    pageControl.frame = pageControlFrame;
}


@end
