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
#import "MagazinRecord.h"
#import "ImageDownloader.h"
#import <QuartzCore/QuartzCore.h>

@interface ExploreViewController (){
    DataHolder *dataHolder;
    ScrollView *scrollView;
    MagazinRecord *mRecord;
    
    UIPageControl *pageControl;
    
    UIView *detailsView;
    UILabel *detailsText;
    UILabel *detailsTitle;
    UILabel *detailsDate;
    UIImageView *detailsImageView;
    UIButton *readBtn;
    UIButton *buyIssueBtn;
    UIView *detailsViewBackGround;
}

// the set of ImageDownloader objects for each app
@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;

@end

@implementation ExploreViewController

- (void) loadView {
    [super loadView];
    
    NSLog(@"ExploreViewController");
    
    dataHolder = [DataHolder sharedData];
    
    //---------------------------- Scroll View ------------------------------------
    scrollView = [[ScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, dataHolder.screenHeight)];
    
    [self.view addSubview:scrollView];
    scrollView.entries = dataHolder.testData;
    
    //---------------------------- Page Control ------------------------------------
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(50, 40, 220, 30)];
    pageControl.numberOfPages = dataHolder.testData.count;
    pageControl.currentPage = 0;
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:pageControl];
    
    //---------------------------- Details View ------------------------------------
    detailsView = [[UIView alloc] initWithFrame:CGRectMake(5, 285, 305, 160)];
    detailsView.alpha = 0;
    
    detailsViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 160)];
    detailsViewBackGround.backgroundColor = [UIColor blackColor];
    detailsViewBackGround.alpha = 0.8;
    [detailsView addSubview:detailsViewBackGround];
    
    detailsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 135)];
    detailsImageView.alpha = 1;
    [detailsView addSubview:detailsImageView];
    
    detailsTitle = [[UILabel alloc] initWithFrame:CGRectMake(140, 15, 150, 20)];
    detailsTitle.backgroundColor = [UIColor clearColor];
    detailsTitle.font = [UIFont systemFontOfSize:18];
    //detailsTitle.font = [UIFont boldSystemFontOfSize:20];
    detailsTitle.textColor = [UIColor whiteColor];
    [detailsView addSubview:detailsTitle];
    
    detailsDate = [[UILabel alloc] initWithFrame:CGRectMake(145, 50, 130, 20)];
    detailsDate.backgroundColor = [UIColor clearColor];
    detailsDate.font = [UIFont systemFontOfSize:14];
    detailsDate.textColor = [UIColor grayColor];
    [detailsView addSubview:detailsDate];
    
    
    readBtn = [[UIButton alloc] initWithFrame:CGRectMake(145, 75, 100, 30)];
    readBtn.backgroundColor = [UIColor clearColor];
    [readBtn addTarget:self  action:@selector(readHandler) forControlEvents:UIControlEventTouchDown];
    [readBtn setTitle:@"READ" forState:UIControlStateNormal];
    readBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    readBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [[readBtn layer] setBorderWidth:1.5f];
    [[readBtn layer] setBorderColor:[UIColor grayColor].CGColor];
    
    [detailsView addSubview:readBtn];
    
    buyIssueBtn = [[UIButton alloc] initWithFrame:CGRectMake(145, 115, 100, 30)];
    buyIssueBtn.backgroundColor = [UIColor clearColor];
    [buyIssueBtn addTarget:self  action:@selector(readHandler) forControlEvents:UIControlEventTouchDown];
    [buyIssueBtn setTitle:@"BUY ISSUE" forState:UIControlStateNormal];
    buyIssueBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    buyIssueBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [[buyIssueBtn layer] setBorderWidth:1.5f];
    [[buyIssueBtn layer] setBorderColor:[UIColor grayColor].CGColor];
    
    [detailsView addSubview:buyIssueBtn];
    
    /*
     for (UIView *subView in detailsView.subviews) {
     subView.alpha = 1.0;
     }
     */
    
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
    mRecord = [dataHolder.testData objectAtIndex:page];
    detailsText.text = mRecord.magazinDetailsText;
    detailsDate.text = mRecord.magazinAutor;
    detailsTitle.text = mRecord.magazinTitle;
    
    if (!mRecord.magazinDetailsIcon) {
        [self startIconDownload:mRecord forIndexPath:page];
    } else {
        detailsImageView.image = mRecord.magazinDetailsIcon;
    }
    
    [UIView animateWithDuration:0.3 animations:^() {
        detailsView.alpha = 1;
    }];
}

- (void)startIconDownload:(MagazinRecord *)magazinRecord forIndexPath:(NSInteger)page {
    NSNumber *index = [NSNumber numberWithInteger:page];
    
    ImageDownloader *imageDownloader = [self.imageDownloadsInProgress objectForKey:index];
    if (imageDownloader == nil) {
        imageDownloader = [[ImageDownloader alloc] init];
        imageDownloader.magazinRecord = magazinRecord;
        UIImageView *newPageView = [[UIImageView alloc] init];
        
        [imageDownloader setCompletionHandler:^{
            NSLog(@"Details Download Image: %i",page);
            
            // Display the newly loaded image
            detailsImageView.image = magazinRecord.magazinDetailsIcon;
            
            // Remove the IconDownloader from the in progress list.
            // This will result in it being deallocated.
            [self.imageDownloadsInProgress removeObjectForKey:index];
        }];
        
        [self.imageDownloadsInProgress setObject:imageDownloader forKey:index];
        [imageDownloader startDownloadDetailsImageWithImageView:newPageView];
    }
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

- (void)readHandler {
    NSLog(@"R E A D");
}

- (void)buyIssueHandler {
    NSLog(@"buy Issue");
}

@end
