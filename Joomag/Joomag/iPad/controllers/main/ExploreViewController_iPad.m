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
    CGRect titleLabelsViewFrame, pageControlFrame, scrollViewFrame;
    NSArray *data;
}

@end

@implementation ExploreViewController_iPad

- (void)loadView {
    [super loadView];
    
    NSLog(@"ExploreViewController_iPad");
    
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
    
    settingsTable.frame = CGRectMake(self.view.frame.size.width-260, 0, 260, self.view.frame.size.height);
}


@end
