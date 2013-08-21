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
    CGRect topBarFrame, topBarTitleLabelFrame, searchBtnFrame, titleLabelsViewFrame, pageControlFrame, scrollViewFrame;
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
    
    //--------------------- Settings --------------------
    settingsTable = [[ExploreTableView alloc] init];
    
    [self.view addSubview:settingsTable];
}

- (void)viewDidLayoutSubviews {
    
    UIInterfaceOrientation iOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    switch(iOrientation)
    {
        case UIDeviceOrientationPortrait:
            
            break;
            
        case UIDeviceOrientationLandscapeLeft:
            topBarFrame = CGRectMake(0, 0, 1024, 44);
            topBarTitleLabelFrame = CGRectMake(20, 0, 150, 44);
            searchBtnFrame = CGRectMake(1024-145, 7, 122, 25);
            scrollViewFrame = CGRectMake(70, 110, 660, 520);
            titleLabelsViewFrame = CGRectMake(70, 60, 300, 30);
            pageControlFrame = CGRectMake(70, 630, 610, 30);
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
    settingsTable.frame = CGRectMake(self.view.frame.size.width-260, 46, 240, self.view.frame.size.height);
}


@end
