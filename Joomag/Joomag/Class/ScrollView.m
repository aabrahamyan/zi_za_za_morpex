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
@property (nonatomic, strong) NSMutableArray *pageViews;

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
        
        // Set up the array to hold the views for each page
        self.pageViews = [[NSMutableArray alloc] init];
        
        for (NSInteger i = 0; i < entriesLength; ++i) {
            [self.pageViews addObject:[NSNull null]];
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
    NSInteger page = [self currentPage:self.contentOffset.x];
    
    // Work out which pages we want to load
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    // Purge anything before the first page
    for (NSInteger i = 0; i < firstPage; i++) {
        [self purgePage:i];
    }
    
    for (NSInteger i = firstPage; i <= lastPage; i++) {
        [self loadPage:i];
    }
    
    // Purge anything after the last page
    for (NSInteger i = lastPage+1; i < entriesLength; i++) {
        [self purgePage:i];
    }
}

// -------------------------------------------------------------------------------
// loadPage:
// Load an individual page
// -------------------------------------------------------------------------------
- (void)loadPage:(NSInteger)page {
    if (page < 0 || page >= entriesLength) {
        // If it's outside the range of what we have to display, then do nothing
        return;
    }
    
    // Load an individual page, first seeing if we've already loaded it
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView == [NSNull null]) {
        // Set up the page...
        MagazinRecord *mRecord = [self.entries objectAtIndex:page];
        if (!mRecord.magazinIcon) {
            [self startIconDownload:mRecord forIndexPath:page];
        } else {
            UIImageView *newPageView = [[UIImageView alloc] initWithImage:mRecord.magazinIcon];
            newPageView.frame = [self currentFrame:page];
            [self addSubview:newPageView];
            [self.pageViews replaceObjectAtIndex:page withObject:newPageView];
        }
    }
}

// -------------------------------------------------------------------------------
// purgePage:
// Purge an individual page
// -------------------------------------------------------------------------------
- (void)purgePage:(NSInteger)page {
    if (page < 0 || page >= entriesLength) {
        // If it's outside the range of what we have to display, then do nothing
        return;
    }
    
    // Remove a page from the scroll view and reset the container array
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [self.pageViews replaceObjectAtIndex:page withObject:[NSNull null]];
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
            NSLog(@"Download Image: %i",page);
            
            // Display the newly loaded image
            UIImageView *newPageView = [[UIImageView alloc] initWithImage:magazinRecord.magazinIcon];
            newPageView.frame = [self currentFrame:page];
            [self addSubview:newPageView];
            [self.pageViews replaceObjectAtIndex:page withObject:newPageView];
            
            // Remove the IconDownloader from the in progress list.
            // This will result in it being deallocated.
            [self.imageDownloadsInProgress removeObjectForKey:index];
        }];
        
        [self.imageDownloadsInProgress setObject:imageDownloader forKey:index];
        [imageDownloader startDownload];
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
    [self loadVisiblePages];
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
