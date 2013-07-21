//
//  ScrollView.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-07-20.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "ScrollView.h"
#import "DataHolder.h"
#import "ImageDownloader.h"
#import "MagazinRecord.h"

@interface ScrollView () {
    CGFloat pageWidth;
    NSInteger entriesLength;
}

// the set of ImageDownloader objects for each app
@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;

@end


@implementation ScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //Init DataHolder
        DataHolder *dataHolder = [DataHolder sharedData];
        self.entries = dataHolder.testData;
        
        self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
        
        //Set BackGround Color
        self.backgroundColor = [UIColor blackColor];
        
        self.delegate = self;
        self.pagingEnabled = YES;
        
        entriesLength = self.entries.count;
        
        CGSize pagesScrollViewSize = self.frame.size;
        pageWidth = pagesScrollViewSize.width;
        
        // Set up the content size of the scroll view
        self.contentSize = CGSizeMake(pagesScrollViewSize.width * [self.entries count], pagesScrollViewSize.height);
        
        // Set Container Views With Placholder Image
        for (NSInteger i = 0; i < entriesLength; ++i) {
            UIImageView *containerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder.png"]];
            containerView.frame = [self currentFrame:i];
            [self addSubview:containerView];
        }
        
        // Load the initial set of pages that are on screen
        [self loadVisiblePages];
    }
    return self;
}

#pragma mark -

// -------------------------------------------------------------------------------
// loadVisiblePages
// Load the pages which are now on screen
// -------------------------------------------------------------------------------
- (void)loadVisiblePages {
    // First, determine which page is currently visible
    for (NSInteger i = 0; i < 5; i++) {
            [self loadPage:i];
    }
}

// -------------------------------------------------------------------------------
// loadPage:
// Load an individual page
// -------------------------------------------------------------------------------
- (void)loadPage: (NSInteger)page{
    if(entriesLength > 0){
        // Set up the page...
        MagazinRecord *mRecord = [self.entries objectAtIndex:page];
        if (!mRecord.magazinIcon) {
            if (self.dragging == NO && self.decelerating == NO) {
                [self startIconDownload:mRecord forIndexPath:page];
            }
        } else {
            NSLog(@"else");
            UIImageView *oldPageView = [self.subviews objectAtIndex:page];
            oldPageView.image = mRecord.magazinIcon;
        }
    }
}

// -------------------------------------------------------------------------------
//	startIconDownload:forIndexPath:
// -------------------------------------------------------------------------------
- (void)startIconDownload:(MagazinRecord *)magazinRecord forIndexPath:(NSInteger)page {
    NSNumber *index = [NSNumber numberWithInteger:page];
    
    ImageDownloader *imageDownloader = [self.imageDownloadsInProgress objectForKey:index];
    if (imageDownloader == nil) {
        imageDownloader = [[ImageDownloader alloc] init];
        imageDownloader.magazinRecord = magazinRecord;
        [imageDownloader setCompletionHandler:^{
            // Display the newly loaded image
            UIImageView *newPageView = [self.subviews objectAtIndex:page];
            newPageView.image = magazinRecord.magazinIcon;
            
            // Remove the IconDownloader from the in progress list.
            // This will result in it being deallocated.
            [self.imageDownloadsInProgress removeObjectForKey:index];
        }];
        
        [self.imageDownloadsInProgress setObject:imageDownloader forKey:index];
        [imageDownloader startDownload];
    }
}

// -------------------------------------------------------------------------------
//	loadImagesForOnscreenRows
//  This method is used in case the user scrolled into a set of cells that don't
//  have their app icons yet.
// -------------------------------------------------------------------------------
- (void)loadImagesForOnscreenRows: (NSInteger)page
{
    if ([self.entries count] > 0)
    {
        MagazinRecord *magazinRecord = [self.entries objectAtIndex:page];
        
        if (!magazinRecord.magazinIcon)
            // Avoid the app icon download if the app already has an icon
        {
            [self startIconDownload:magazinRecord forIndexPath:page];
        }
    }
}

// -------------------------------------------------------------------------------
//	currentPage:
//  return current page by offset x
// -------------------------------------------------------------------------------
- (NSInteger)currentPage: (float)offsetX {
    return (NSInteger)floor((offsetX * 2.0f + pageWidth) / (pageWidth * 2.0f));
}

// -------------------------------------------------------------------------------
//	currentPage:
//  return frame by current page
// -------------------------------------------------------------------------------
- (CGRect)currentFrame: (NSInteger)page {
    CGRect frame = self.bounds;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0.0f;
    
    return frame;
}

#pragma mark - UIScrollViewDelegate

// -------------------------------------------------------------------------------
//	scrollViewDidEndDecelerating:
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows:[self currentPage:self.contentOffset.x]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updatePageControl" object:nil];
}

// -------------------------------------------------------------------------------
// scrollViewDidScroll:
// any offset changes. Load the pages which are now on screen
// -------------------------------------------------------------------------------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.currentPage = [self currentPage:self.contentOffset.x];
}

// any zoom scale changes
- (void)scrollViewDidZoom:(UIScrollView *)scrollView NS_AVAILABLE_IOS(3_2)
{
    
}

// called on start of dragging (may require some time and or distance to move)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideDetailsView" object:nil];
}

// called on finger up if the user dragged. velocity is in points/second. targetContentOffset may be changed to adjust where the scroll view comes to rest. not called when pagingEnabled is YES
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0)
{
    
}

// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}

// called on finger up as we are moving
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    
}

// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
}

// return a view that will be scaled. if delegate returns nil, nothing happens
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return scrollView;
}

// called before the scroll view begins zooming its content
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view NS_AVAILABLE_IOS(3_2)
{
    
}

// scale between minimum and maximum. called after any 'bounce' animations
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    
}

// return a yes if you want to scroll to the top. if not defined, assumes YES
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    return 0;
}

// called when scrolling animation finished. may be called immediately if already at top
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    
}

@end
