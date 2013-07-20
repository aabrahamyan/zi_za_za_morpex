//
//  ExploreViewController.m
//  Joomag
//
//  Created by Armen Abrahamyan on 7/19/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "ExploreViewController.h"
#import "DataHolder.h"
#import "ScrollView.h"

@interface ExploreViewController (){
    ScrollView *scrollView;
}

@end

@implementation ExploreViewController

- (void) loadView {
    [super loadView];
    NSLog(@"ExploreViewController");
    
    DataHolder *dataHolder = [DataHolder sharedData];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568) {
        scrollView = [[ScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    } else {
        scrollView = [[ScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    }
    [self.view addSubview:scrollView];
    scrollView.entries = dataHolder.testData;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
