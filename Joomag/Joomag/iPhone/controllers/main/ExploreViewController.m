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
    pageControl.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:pageControl];
    
    //---------------------------- Details View ------------------------------------
    detailsView = [[UIView alloc] init];
    detailsView.frame = CGRectMake(5, 295, 300, 150); //TODO
    detailsView.backgroundColor = [UIColor blackColor];
    detailsView.alpha = 0;
    
    detailsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 120, 130)];
    [detailsView addSubview:detailsImageView];
    
    detailsTitle = [[UILabel alloc] initWithFrame:CGRectMake(150, 10, 130, 20)];
    detailsTitle.backgroundColor = [UIColor clearColor];
    detailsTitle.font = [UIFont systemFontOfSize:20];
    //detailsTitle.font = [UIFont boldSystemFontOfSize:20];
    detailsTitle.textColor = [UIColor whiteColor];
    [detailsView addSubview:detailsTitle];
    
    detailsDate = [[UILabel alloc] initWithFrame:CGRectMake(150, 30, 130, 20)];
    detailsDate.backgroundColor = [UIColor clearColor];
    detailsDate.font = [UIFont systemFontOfSize:14];
    detailsDate.textColor = [UIColor whiteColor];
    [detailsView addSubview:detailsDate];
    
    /*
     detailsText = [[UILabel alloc] initWithFrame:CGRectMake(120, 80, 100, 30)];
     detailsText.backgroundColor = [UIColor clearColor];
     detailsText.textColor = [UIColor whiteColor];
     [detailsView addSubview:detailsText];
     */
    
    readBtn = [[UIButton alloc] initWithFrame:CGRectMake(160, 60, 110, 30)];
    readBtn.backgroundColor = [UIColor clearColor];
    [readBtn addTarget:self  action:@selector(readHandler) forControlEvents:UIControlEventTouchDown];
    [readBtn setTitle:@"READ" forState:UIControlStateNormal];
    readBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [[readBtn layer] setBorderWidth:1.5f];
    [[readBtn layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    [detailsView addSubview:readBtn];
    
    buyIssueBtn = [[UIButton alloc] initWithFrame:CGRectMake(160, 100, 110, 30)];
    buyIssueBtn.backgroundColor = [UIColor clearColor];
    [buyIssueBtn addTarget:self  action:@selector(buyIssueHandler) forControlEvents:UIControlEventTouchDown];
    [buyIssueBtn setTitle:@"BUY ISSUE" forState:UIControlStateNormal];
    buyIssueBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    buyIssueBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [[buyIssueBtn layer] setBorderWidth:1.5f];
    [[buyIssueBtn layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    [detailsView addSubview:buyIssueBtn];
    
    [self.view addSubview:detailsView];
    [self showDetailsView:0];
    
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
    }
    [UIView animateWithDuration:0.3 animations:^() {
        detailsView.alpha = 0.7;
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
