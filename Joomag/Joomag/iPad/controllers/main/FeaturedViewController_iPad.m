//
//  FeaturedViewController_iPad.m
//  Joomag
//
//  Created by Armen Abrahamyan on 7/19/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "FeaturedViewController_iPad.h"
#import "DataHolder.h"

@interface FeaturedViewController_iPad () {
    DataHolder *dataHolder;
    CGRect detailsViewFrame, pageControlFrame, scrollViewFrame;
}

@end

@implementation FeaturedViewController_iPad

- (void)loadView { // TODO landscape
    [super loadView];
    
    //NSLog(@"FeaturedViewController_iPad:");
    
    dataHolder = [DataHolder sharedData];
}

- (void)viewDidLayoutSubviews {
    
    UIInterfaceOrientation iOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    switch(iOrientation) {
            
        case UIDeviceOrientationPortrait:
            scrollViewFrame = CGRectMake(0, -20, 768, 959);
            detailsViewFrame = CGRectMake(230, 700, 500, 200);
            pageControlFrame = CGRectMake(0, 30, 768, 30);
            break;
            
        case UIDeviceOrientationLandscapeLeft:
            scrollViewFrame = CGRectMake(0, -20, 1024, 704);
            detailsViewFrame = CGRectMake(490, 450, 540, 220);
            pageControlFrame = CGRectMake(0, 30, 1024, 30);
            break;
            
        case UIDeviceOrientationLandscapeRight:
            //scrollViewFrame = CGRectMake(0, 0, dataHolder.screenHeight, dataHolder.screenWidth);
            //[scrollView setContentSize:CGSizeMake(scrollViewFrame.size.width*11, dataHolder.screenWidth)];
            //detailsViewFrame = CGRectMake(500, 430, 500, 200);
            //pageControlFrame = CGRectMake(0, 30, 1024, 30);
            break;
            
        default:
            break;
    };
    
    scrollView.frame = scrollViewFrame;
    pageControl.frame = pageControlFrame;
    detailsView.frame = detailsViewFrame;
    
    [scrollView redrawData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
