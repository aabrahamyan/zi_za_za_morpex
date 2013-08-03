//
//  ExploreViewController.m
//  Joomag
//
//  Created by Armen Abrahamyan on 7/19/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "ExploreViewController.h"
#import "DataHolder.h"
#import "MagazinRecord.h"
#import "ImageDownloader.h"
#import <QuartzCore/QuartzCore.h>

@interface ExploreViewController (){
    DataHolder *dataHolder;
    MagazinRecord *mRecord;
}

// the set of ImageDownloader objects for each app
@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;

@end

@implementation ExploreViewController

- (void) loadView {
    [super loadView];
    
    NSLog(@"ExploreViewController:");
    
    dataHolder = [DataHolder sharedData];
    
    //---------------------------- Scroll View ------------------------------------
    scrollView = [[ScrollView alloc] initWithFrame:CGRectMake(0, 0, dataHolder.screenWidth, dataHolder.screenHeight)];
    scrollView.entries = dataHolder.testData;
    
    [self.view addSubview: scrollView];
    
    //---------------------------- Page Control ------------------------------------
    CGRect pageControlFrame = CGRectMake(0, 30, 320, 30);
    pageControl = [[UIPageControl alloc] init];
    pageControl.frame = pageControlFrame;
    pageControl.currentPage = 0;
    pageControl.numberOfPages = dataHolder.testData.count;
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview: pageControl];
    
    //Notify When Page Changes
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePageControl) name:@"updatePageControl" object:nil];
    
    //---------------------------- Details View ------------------------------------
    
    CGRect detailsViewFrame = CGRectMake(5, 285, 305, 160);
    detailsViewContainer = [[UIView alloc] initWithFrame:detailsViewFrame];
    detailsViewContainer.alpha = 0;
    
    detailsViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, detailsViewContainer.frame.size.width, detailsViewContainer.frame.size.height)];
    detailsViewBackGround.backgroundColor = [UIColor blackColor];
    detailsViewBackGround.alpha = 0.8;
    [detailsViewContainer addSubview: detailsViewBackGround];
    
    detailsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 135)];
    detailsImageView.image = [UIImage imageNamed:@"placeholder.png"];
    detailsImageView.alpha = 1;
    [detailsViewContainer addSubview: detailsImageView];
    
    detailsTitle = [[UILabel alloc] initWithFrame:CGRectMake(140, 15, 150, 20)];
    detailsTitle.backgroundColor = [UIColor clearColor];
    detailsTitle.font = [UIFont systemFontOfSize:18];
    detailsTitle.textColor = [UIColor whiteColor];
    [detailsViewContainer addSubview: detailsTitle];
    
    detailsDate = [[UILabel alloc] initWithFrame:CGRectMake(145, 50, 130, 20)];
    detailsDate.backgroundColor = [UIColor clearColor];
    detailsDate.font = [UIFont systemFontOfSize:14];
    detailsDate.textColor = [UIColor grayColor];
    [detailsViewContainer addSubview: detailsDate];
    
    detailsText = [[UITextView alloc] init];
    detailsText.backgroundColor = [UIColor clearColor];
    detailsText.font = [UIFont systemFontOfSize:12];
    detailsText.textColor = [UIColor whiteColor];
    [detailsViewContainer addSubview: detailsText];
    
    readBtn = [[UIButton alloc] initWithFrame:CGRectMake(145, 75, 100, 30)];
    readBtn.backgroundColor = [UIColor clearColor];
    [readBtn setTitle:@"READ" forState:UIControlStateNormal];
    readBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [[readBtn layer] setBorderWidth:1.5f];
    [[readBtn layer] setBorderColor:[UIColor grayColor].CGColor];
    [readBtn addTarget:self  action:@selector(readHandler) forControlEvents:UIControlEventTouchDown];
    [detailsViewContainer addSubview: readBtn];
    
    buyIssueBtn = [[UIButton alloc] initWithFrame:CGRectMake(145, 115, 100, 30)];
    buyIssueBtn.backgroundColor = [UIColor clearColor];
    [buyIssueBtn addTarget:self  action:@selector(readHandler) forControlEvents:UIControlEventTouchDown];
    [buyIssueBtn setTitle:@"BUY ISSUE" forState:UIControlStateNormal];
    buyIssueBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [[buyIssueBtn layer] setBorderWidth:1.5f];
    [[buyIssueBtn layer] setBorderColor:[UIColor grayColor].CGColor];
    [detailsViewContainer addSubview: buyIssueBtn];
    
    shareBtn = [[UIButton alloc] init];
    shareBtn.backgroundColor = [UIColor clearColor];
    [shareBtn addTarget:self  action:@selector(shareHandler) forControlEvents:UIControlEventTouchDown];
    [shareBtn setTitle:@"SHARE" forState:UIControlStateNormal]; // TODO
    shareBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [[shareBtn layer] setBorderWidth:1.5f];
    [[shareBtn layer] setBorderColor:[UIColor grayColor].CGColor];
    [detailsViewContainer addSubview: shareBtn];
    
    // Hide Details view when start dragging
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideDetailsView) name:@"hideDetailsView" object:nil];
    
    [self showDetailsView: scrollView.currentPage];
    [self.view addSubview: detailsViewContainer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    detailsDate.text = mRecord.magazinAutor;
    detailsTitle.text = mRecord.magazinTitle;
    detailsText.text = mRecord.magazinDetailsText;
    
    if (!mRecord.magazinDetailsIcon) {
        detailsImageView.image = [UIImage imageNamed:@"placeholder.png"];
        [self startIconDownload:mRecord forIndexPath:page];
    } else {
        detailsImageView.image = mRecord.magazinDetailsIcon;
    }
    
    //if(mRecord.magazinIcon){ // TODO check when magazin icon loaded
    [UIView animateWithDuration:0.3 animations:^() {
        detailsViewContainer.alpha = 1;
    }];
    //}
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
    detailsViewContainer.alpha = 0;
}

#pragma Explore Buttons Handlers

- (void)readHandler {
    NSLog(@"read");
}

- (void)buyIssueHandler {
    NSLog(@"buy Issue");
}

- (void)shareHandler {
    NSLog(@"share");
}

#pragma Response Tracker Delegates ---

- (void) didFailResponse: (id) responseObject {

}

- (void) didFinishResponse: (id) responseObject {

}

@end
