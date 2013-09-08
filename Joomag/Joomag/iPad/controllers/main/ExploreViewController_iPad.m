//
//  ExploreViewController_iPad.m
//  Joomag
//
//  Created by Armen Abrahamyan on 7/19/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "ExploreViewController_iPad.h"
#import "DataHolder.h"
#import "Util.h"

@interface ExploreViewController_iPad () {
    DataHolder *dataHolder;
    CGRect topBarFrame, topBarTitleLabelFrame, searchBtnFrame, titleLabelsViewFrame, pageControlFrame, scrollViewFrame, categoriesTableFrame;
    NSArray *data;
}

@end

@implementation ExploreViewController_iPad

- (void)loadView {
    [super loadView];
    
    //NSLog(@"ExploreViewController_iPad");
    
    data = [NSArray arrayWithObjects: @"Categories",@"Art",@"Automotive",
            @"Entertainment",@"Home",@"Lifestyle", @"Men",@"News",@"Science and Tech",
            @"Business",@"Sports",@"Travel", @"Women", nil];
    
    dataHolder = [DataHolder sharedData];
}

- (void)viewDidLayoutSubviews {
    
    UIInterfaceOrientation iOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    switch(iOrientation)
    {
        case UIDeviceOrientationPortrait:
            topBarFrame = CGRectMake(0, 0, 768, 44);
            topBarTitleLabelFrame = CGRectMake(20, 0, 150, 44);
            searchBtnFrame = CGRectMake(768-145, 0, 122, 44);
            scrollViewFrame = CGRectMake(70, 130, 660, 520);
            titleLabelsViewFrame = CGRectMake(70, 80, 300, 30);
            pageControlFrame = CGRectMake(70, 650, 610, 30);
            categoriesTableFrame = CGRectMake(0, 1024-315, 768, 250);
            
            break;
            
        case UIDeviceOrientationLandscapeLeft:
            topBarFrame = CGRectMake(0, 0, 1024, 44);
            topBarTitleLabelFrame = CGRectMake(20, 0, 150, 44);
            searchBtnFrame = CGRectMake(1024-145, 0, 122, 44);
            scrollViewFrame = CGRectMake(70, 110, 660, 520);
            titleLabelsViewFrame = CGRectMake(70, 60, 300, 30);
            pageControlFrame = CGRectMake(70, 630, 610, 30);
            categoriesTableFrame = CGRectMake(1024-260, 46, 240, 768);
            
            break;
            
        case UIDeviceOrientationLandscapeRight:
            
            break;
            
        default:
            break;
    };
    
    CGRect frm = CGRectMake(0, -20, self.view.bounds.size.width, self.view.bounds.size.height);
    self.view.frame = frm;
    topBar.frame = topBarFrame;
    topBarTitleLabel.frame = topBarTitleLabelFrame;
    searchBtn.frame = searchBtnFrame;
    titleLabels.frame = titleLabelsViewFrame;
    scrollView.frame = scrollViewFrame;
    pageControl.frame = pageControlFrame;
    categoriesTable.frame = categoriesTableFrame;
}


@end
