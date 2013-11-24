//
//  FeaturedViewController.m
//  Joomag
//
//  Created by Armen Abrahamyan on 7/19/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "FeaturedViewController.h"
#import "DataHolder.h"
#import "MagazinRecord.h"
#import "ReadViewController.h"
#import "Util.h"
#import "AFNetworking.h"
#import "MainDataHolder.h"
#import "ConnectionManager.h"
#import "NoInternetView.h"
#import "UIImageView+WebCache.h"

@interface FeaturedViewController (){
    MainDataHolder *dataHolder;
    MagazinRecord *mRecord;
    UILabel *testLabel;
}

@end

@implementation FeaturedViewController

- (void) loadView {
    [super loadView];
    
    ConnectionManager * connManager = [[ConnectionManager alloc] init];
    [connManager constructGetMagazinesListRequest:self:@"featured":nil:nil:nil];
    
    //-------------------------------- Top Bar ------------------------------------
    topBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topTabBarBg.png"]];
    [topBar addSubview:backgroundView];
    
    [self.view addSubview: topBar];
    
    UILabel *topBarTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 170, 44)];
    topBarTitleLabel.backgroundColor = [UIColor clearColor];
    topBarTitleLabel.textColor = [UIColor whiteColor];
    topBarTitleLabel.text = @"Featured Magazines";
    
    [topBar addSubview: topBarTitleLabel];
    
    //---------------------------- Scroll View ------------------------------------
    scrollView = [[FeaturedScrollView alloc] initWithFrame:CGRectMake(0, 46.5, self.view.frame.size.width,
                                                                      self.view.frame.size.height-90)];
    
    [self.view addSubview: scrollView];
    
    
    //---------------------------- Page Control ------------------------------------
    CGRect pageControlFrame = CGRectMake(0, 50, 320, 30);
    pageControl = [[UIPageControl alloc] init];
    pageControl.frame = pageControlFrame;
    pageControl.currentPage = 0;
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview: pageControl];
    
    //Notify When Page Changes
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePageControl) name:@"updatePageControl" object:nil];
    
    //Notify When Data Changes
    // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMagazineData) name:@"updateMagazineData" object:nil];
    
    //---------------------------- Details View ------------------------------------
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        if (IS_IPHONE_5) {
            detailsView = [[FeaturedDetailsView alloc] initWithFrame:CGRectMake(5, 325, 305, 160)];
        } else {
            detailsView = [[FeaturedDetailsView alloc] initWithFrame:CGRectMake(5, 245, 305, 160)];
        }
        
    } else {
        detailsView = [[FeaturedDetailsView alloc] initWithFrame:CGRectMake(0, 0, 520, 220)];
    }
    detailsView.alpha = 0;
    detailsView.delegate = self;
    
    [self.view addSubview: detailsView];
    
    // Hide Details view when start dragging
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideDetailsView) name:@"hideDetailsView" object:nil];
    
    //Create and add the Activity Indicator to first view
    loader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    loader.alpha = 1.0;
    loader.center = self.view.center;
    loader.hidesWhenStopped = YES;
    [self.view addSubview:loader];
    [self.view bringSubviewToFront:loader];
    [loader startAnimating];
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
    [self showDetailsView];
}

// -------------------------------------------------------------------------------
// showDetailsView:
// Show details view with alpha value animating
// -------------------------------------------------------------------------------
- (void)showDetailsView {
    
    if (scrollView.currentPage < 0) {
        scrollView.currentPage = 0;
    }
    
    mRecord = [dataHolder.testData objectAtIndex:scrollView.currentPage];
    
    dataHolder.currentMagazineNumber = scrollView.currentPage;
    
    detailsView.date.text = mRecord.magazinDate;
    detailsView.title.text = mRecord.magazinTitle;
    detailsView.text.text = mRecord.magazinDetailsText;
    
    //if (!mRecord.magazinDetailsIcon) {
        //detailsView.imageView.image = [UIImage imageNamed:@"placeholder.png"];
        //detailsView.imageView.image = nil;
        [self startIconDownload:mRecord forIndexPath:scrollView.currentPage];
    //} else {
        
        
//detailsView.imageView.image = mRecord.magazinDetailsIcon;
  //  }
    
    
    [UIView animateWithDuration:0.3 animations:^() {
        detailsView.alpha = 1;
    }];
}

// -------------------------------------------------------------------------------
// hideDetailsView
// -------------------------------------------------------------------------------
- (void)hideDetailsView {
    if(scrollView.currentPage != dataHolder.testData.count-1){
        [UIView animateWithDuration:0.3 animations:^() {
            detailsView.alpha = 0;
        }];
    }
}

- (void)startIconDownload:(MagazinRecord *)magazinRecord forIndexPath:(NSInteger)page {
    /*
    if (!magazinRecord.magazinDetailsIcon) {
        [detailsView.imageView setImageWithURL: [NSURL URLWithString: magazinRecord.magazinDetailsImageURL]
                              placeholderImage: [UIImage imageNamed:@"placeholder.png"]
                                       options: SDWebImageProgressiveDownload];
    } else {
    
    mRecord.magazinDetailsIcon = detailsView.imageView.image;
    
        NSLog(@"mRecord.magazinDetailsIcon: %@", mRecord.magazinDetailsIcon);
        detailsView.imageView.image = magazinRecord.magazinDetailsIcon;
    }
    */

    __block MagazinRecord *__blockRecord = mRecord;
    
    [detailsView.imageView setImageWithURL: [NSURL URLWithString: magazinRecord.magazinDetailsImageURL]
                placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                         success:^(UIImage *image, BOOL dummy) {
                             if (image) {
                                 __blockRecord.magazinDetailsIcon = image;
                             }
                         }
                         failure:^(NSError *error) {
                             
                         }
     ];
    
}

#pragma Featured Buttons Handlers

-(void)readHandler {
    
    UIView *loaderContainer = [[UIView alloc] initWithFrame:CGRectMake(0, -20, 1024, 768)]; //TODO
    loaderContainer.backgroundColor = RGBA(43, 43, 44, 1);
    //Create and add the Activity Indicator to first view
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.alpha = 1.0;
    activityIndicator.center = loaderContainer.center;
    activityIndicator.hidesWhenStopped = YES;
    [loaderContainer addSubview:activityIndicator];
    [loaderContainer bringSubviewToFront:activityIndicator];
    [activityIndicator startAnimating];
    
    
    ReadViewController *readVC = [[ReadViewController alloc] init];
    
    //[readVC startDownloadMagazine: scrollView.currentPage];
    [readVC hitPageDescription:scrollView.currentPage];
    
    [UIView transitionWithView: self.navigationController.view duration:1 options:[Util getFlipAnimationType] animations:nil completion:nil];
    
    [self.navigationController pushViewController: readVC animated: NO];
}

- (void)buyIssueHandler {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showBuyIssue" object:nil];
}

- (void)shareHandler:(UIButton *)shareBtn {
    
    MagazinRecord * currentMagazine = [[MainDataHolder getInstance].testData objectAtIndex: scrollView.currentPage];
   
    [self startIconDownload:currentMagazine forIndexPath:scrollView.currentPage];
    
    NSLog(@"share currentMagazine Icone: %@", mRecord.magazinDetailsIcon);
    NSLog(@"share currentMagazine Title: %@", currentMagazine.magazinTitle);
    
    NSString *message = currentMagazine.magazinTitle;
    UIImage *imageToShare = mRecord.magazinDetailsIcon;//currentMagazine.magazinDetailsIcon;
    
    NSArray *postItems = @[message, imageToShare];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]
                                            initWithActivityItems:postItems
                                            applicationActivities:nil];
    
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone) {
        _popover = [[UIPopoverController alloc] initWithContentViewController:activityVC];
        _popover.delegate = self;
        [_popover presentPopoverFromRect:CGRectMake(0, 0, 500, 500) inView:self.view permittedArrowDirections:0 animated:YES];
    } else {
        [self presentViewController:activityVC animated:YES completion:nil];
    }
    
}

/*
- (void)updateMagazineData {
    [scrollView reloadData];
}
*/

#pragma Response Tracker Delegates ---

- (void) didFailResponse: (id) responseObject {
    
}

- (void) didFinishResponse: (id) responseObject {
    dataHolder = [MainDataHolder getInstance];
    [scrollView redrawData];
    [self showDetailsView];
    pageControl.numberOfPages = dataHolder.testData.count;
    [loader stopAnimating];
}

@end
