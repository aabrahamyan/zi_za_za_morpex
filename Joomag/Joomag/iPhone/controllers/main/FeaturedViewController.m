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
    
    //NSLog(@"FeaturedViewController:");
    self.view.backgroundColor = [UIColor blackColor];
    
    ConnectionManager * connManager = [[ConnectionManager alloc] init];
    [connManager constructGetMagazinesListRequest:self];
    
    //---------------------------- Scroll View ------------------------------------
    scrollView = [[FeaturedScrollView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)]; // TODO
    //scrollView.entries = dataHolder.testData;
    
    [self.view addSubview: scrollView];
    
    
    //---------------------------- Page Control ------------------------------------
    CGRect pageControlFrame = CGRectMake(0, 30, 320, 30);
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
        detailsView = [[FeaturedDetailsView alloc] initWithFrame:CGRectMake(5, 285, 305, 160)];
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
    [self showDetailsView: scrollView.currentPage];
}

// -------------------------------------------------------------------------------
// showDetailsView:
// Show details view with alpha value animating
// -------------------------------------------------------------------------------
- (void)showDetailsView: (NSInteger)page {
    
    mRecord = [dataHolder.testData objectAtIndex:page];
    
    detailsView.date.text = mRecord.magazinDate;
    detailsView.title.text = mRecord.magazinTitle;
    detailsView.text.text = mRecord.magazinDetailsText;
    
    if (!mRecord.magazinDetailsIcon) {
        //detailsView.imageView.image = [UIImage imageNamed:@"placeholder.png"];
        detailsView.imageView.image = nil;
        [self startIconDownload:mRecord forIndexPath:page];
    } else {
        detailsView.imageView.image = mRecord.magazinDetailsIcon;
    }
    
    //if(mRecord.magazinIcon){ // TODO check when magazin icon loaded
    [UIView animateWithDuration:0.3 animations:^() {
        detailsView.alpha = 1;
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
            detailsView.imageView.image = magazinRecord.magazinDetailsIcon;
            
            // Remove the IconDownloader from the in progress list.
            // This will result in it being deallocated.
            [self.imageDownloadsInProgress removeObjectForKey:index];
        }];
        
        [self.imageDownloadsInProgress setObject:imageDownloader forKey:index];
        //[imageDownloader startDownloadWithImageView:newPageView withURL:magazinRecord.magazinDetailsImageURL andSetIcon:magazinRecord.magazinDetailsIcon];
        [imageDownloader startDownloadDetailsImageWithImageView: newPageView];
    }
}


// -------------------------------------------------------------------------------
// hideDetailsView
// -------------------------------------------------------------------------------
- (void)hideDetailsView {
    detailsView.alpha = 0;
}

#pragma Explore Buttons Handlers

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
    
    //[self.view addSubview: loaderContainer];
    
    ReadViewController *readVC = [[ReadViewController alloc] init];
    // NSLog(@"current: %i", scrollView.currentPage);
    
    [readVC startDownloadMagazine: scrollView.currentPage];
    
    [UIView transitionWithView: self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromBottom animations:nil completion:nil];
    
    [self.navigationController pushViewController: readVC animated: NO];
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
    dataHolder = [MainDataHolder getInstance];
    [scrollView redrawData];
    [self showDetailsView: scrollView.currentPage];
    pageControl.numberOfPages = dataHolder.testData.count;
}

@end
