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
    UIPageControl *pageControl;
    UIView *detailsView;
}

@end

@implementation ExploreViewController

- (void) loadView {
    [super loadView];
    NSLog(@"ExploreViewController");
    
    DataHolder *dataHolder = [DataHolder sharedData];
    
    
    //---------------------------- Scroll View ------------------------------------
    scrollView = [[ScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, dataHolder.screenHeight)];
    
    [self.view addSubview:scrollView];
    scrollView.entries = dataHolder.testData;
    
    //---------------------------- Page Control ------------------------------------
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(50, 40, 220, 30)];
    pageControl.numberOfPages = dataHolder.testData.count;
    pageControl.currentPage = 0;
    pageControl.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:pageControl];
    
    //---------------------------- Details View ------------------------------------
    detailsView = [[UIView alloc] init];
    detailsView.frame = CGRectMake(30, 284, 260, 150); //TODO
    detailsView.backgroundColor = [UIColor blackColor];
    detailsView.alpha = 0;
    
    [self.view addSubview:detailsView];
    [self showDetailsView:0];
    
    //Notify When Page Changes
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePageControl) name:@"updatePageControl" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideDetailsView) name:@"hideDetailsView" object:nil];
}

// -------------------------------------------------------------------------------
// updatePageControl
// Update UIPageControl and show details view with current page
// -------------------------------------------------------------------------------
- (void)updatePageControl {
    pageControl.currentPage = scrollView.currentPage;
    [self showDetailsView: scrollView.currentPage];
}

// -------------------------------------------------------------------------------
// showDetailsView:
// Show details view with alpha value animating
// -------------------------------------------------------------------------------
- (void)showDetailsView: (NSInteger)page {
    [UIView animateWithDuration:0.6 animations:^() {
        detailsView.alpha = 0.5;
    }];
}

// -------------------------------------------------------------------------------
// hideDetailsView
// -------------------------------------------------------------------------------
- (void)hideDetailsView {
    detailsView.alpha = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
