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
#import "ImageDownloader.h"
#import "ReadViewController.h"
#import "Util.h"
#import "AFNetworking.h"
#import "MainDataHolder.h"
#import "ConnectionManager.h"
#import "NoInternetView.h"

@interface FeaturedViewController (){
    MainDataHolder *dataHolder;
    MagazinRecord *mRecord;
    UILabel *testLabel;
}

// the set of ImageDownloader objects for each app
@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;

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
                                                                      self.view.frame.size.height-90)]; // TODO frmae size
    
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
    
    mRecord = [dataHolder.testData objectAtIndex:scrollView.currentPage];
    
    dataHolder.currentMagazineNumber = scrollView.currentPage;
    
    detailsView.date.text = mRecord.magazinDate;
    detailsView.title.text = mRecord.magazinTitle;
    detailsView.text.text = mRecord.magazinDetailsText;
    
    if (!mRecord.magazinDetailsIcon) {
        //detailsView.imageView.image = [UIImage imageNamed:@"placeholder.png"];
        detailsView.imageView.image = nil;
        [self startIconDownload:mRecord forIndexPath:scrollView.currentPage];
    } else {
        detailsView.imageView.image = mRecord.magazinDetailsIcon;
    }
    
    
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
    
    NSNumber *index = [NSNumber numberWithInteger:page];
    ImageDownloader *imageDownloader = [self.imageDownloadsInProgress objectForKey:index];
    
    if (imageDownloader == nil) {
        imageDownloader = [[ImageDownloader alloc] init];
        imageDownloader.magazinRecord = magazinRecord;
        UIImageView *newPageView = [[UIImageView alloc] init];
        
        [imageDownloader setCompletionHandler:^{
            //NSLog(@"Details Download Image: %i",page);
            
            // Display the newly loaded image
            detailsView.imageView.image = magazinRecord.magazinDetailsIcon;
            
            // Remove the IconDownloader from the in progress list.
            // This will result in it being deallocated.
            [self.imageDownloadsInProgress removeObjectForKey:index];
        }];
        
        [self.imageDownloadsInProgress setObject:imageDownloader forKey:index];
        [imageDownloader startDownloadDetailsImageWithImageView: newPageView];
        // [imageDownloader startDownloadWithImageView:newPageView withURL:magazinRecord.magazinDetailsImageURL andSetIcon:magazinRecord.magazinDetailsIcon];
    }
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
    
    NSLog(@"share currentMagazine Icone: %@", currentMagazine.magazinDetailsIcon);
    NSLog(@"share currentMagazine Title: %@", currentMagazine.magazinTitle);
    
    NSString *message = currentMagazine.magazinTitle;
    UIImage *imageToShare = currentMagazine.magazinDetailsIcon;
    
    NSArray *postItems = @[message, imageToShare];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]
                                            initWithActivityItems:postItems
                                            applicationActivities:nil];
    
    [self presentViewController:activityVC animated:YES completion:nil];
    
    /*
    NSLog(@"shareBtn.frame: %@", NSStringFromCGRect(shareBtn.frame));
    
    _popover = [[UIPopoverController alloc] initWithContentViewController:activityVC];
    _popover.delegate = self;
    [_popover presentPopoverFromRect:self.view.frame inView:self.view permittedArrowDirections:0 animated:YES];
    */
}

#pragma Response Tracker Delegates ---

- (void) didFailResponse: (id) responseObject {
    
}

- (void) didFinishResponse: (id) responseObject {
    dataHolder = [MainDataHolder getInstance];
    [scrollView redrawData];
    [self showDetailsView];
    pageControl.numberOfPages = dataHolder.testData.count;
}

@end
