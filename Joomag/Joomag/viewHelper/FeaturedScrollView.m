//
//  FeaturedFeaturedScrollView.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-07-20.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "FeaturedScrollView.h"
#import "DataHolder.h"
#import "ImageDownloader.h"
#import "MagazinRecord.h"

@interface FeaturedScrollView () {
    CGFloat pageWidth;
    NSInteger entriesLength;
    int counter;
}

// the set of ImageDownloader objects for each app
@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;
@property (nonatomic, strong) NSMutableArray *pageViews;

@end


@implementation FeaturedScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        counter = 1;
        
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
        self.contentSize = CGSizeMake(pageWidth * [self.entries count], pagesScrollViewSize.height);
        
        // Set up the array to hold the views for each page
        self.pageViews = [[NSMutableArray alloc] init];
        
        // Load the initial set of pages that are on screen
        [self loadVisiblePage];
    }
    return self;
}

#pragma mark -

// -------------------------------------------------------------------------------
// loadVisiblePages
// Load the pages which are now on screen
// -------------------------------------------------------------------------------

- (void)loadVisiblePage {
    // First, determine which page is currently visible
    NSInteger page = [self currentPage:self.contentOffset.x];
    [self loadPage:page];
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
    MagazinRecord *mRecord = [self.entries objectAtIndex:page];
    if (!mRecord.magazinIcon) {
        [self startIconDownload:mRecord forIndexPath:page];
    } else {
        NSLog(@"exist: %i",page);
        ((UIImageView *)[self.pageViews objectAtIndex: page]).image = mRecord.magazinIcon;
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
        
        UIImageView *imageView = [[UIImageView alloc] init];
        
        [imageDownloader setCompletionHandler:^{
            NSLog(@"Download Featured Image: %i",page);
            
            // Display the newly loaded image
            imageView.image = magazinRecord.magazinIcon;
            imageView.frame = self.bounds;
            //imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            imageView.tag = counter; counter++;
            
            [self addSubview: imageView];
            
            // Remove the IconDownloader from the in progress list.
            // This will result in it being deallocated.
            [self.imageDownloadsInProgress removeObjectForKey:index];
        }];
        
        [self.imageDownloadsInProgress setObject: imageDownloader forKey:index];
        [self.pageViews insertObject:imageView atIndex: page];
        [imageDownloader startDownloadWithImageView: imageView];
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
    [self loadVisiblePage];
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
