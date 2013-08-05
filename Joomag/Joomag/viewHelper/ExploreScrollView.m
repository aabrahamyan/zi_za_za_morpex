//
//  ExploreScrollView.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-08-05.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "ExploreScrollView.h"
#import "DataHolder.h"
#import "ImageDownloader.h"
#import "MagazinRecord.h"

@interface ExploreScrollView () {
    CGFloat pageHeight;
    NSInteger entriesLength;
    int yPosition;
    int xPosition;
}

// the set of ImageDownloader objects for each app
@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;

@end
@implementation ExploreScrollView

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
        self.backgroundColor = [UIColor clearColor];
        
        self.delegate = self;
        //self.pagingEnabled = YES;
        
        entriesLength = self.entries.count;
        
        CGSize pagesScrollViewSize = self.frame.size;
        pageHeight = pagesScrollViewSize.height;
        
        yPosition = 0;
        xPosition = 20;
        
        for (int i = 0; i < entriesLength; i ++) {
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(xPosition, yPosition, 130, 170)];
            imageView.image = [UIImage imageNamed:@"placeholder.png"];
            
            [self addSubview:imageView];
            
            xPosition += 150;
            if(xPosition >=300){
                xPosition = 20;
                yPosition += 220;
            }
        }
        
        // Set up the content size of the scroll view
        self.contentSize = CGSizeMake(pagesScrollViewSize.width, yPosition+180);
        
        NSLog(@"self.contentSize: %f",self.contentSize.width);
        
        // Load the initial set of pages that are on screen
    }
    return self;
}

// -------------------------------------------------------------------------------
//	currentPage:
//  return current page by offset x
// -------------------------------------------------------------------------------
- (NSInteger)currentPage: (float)offsetY {
    return (NSInteger)floor((offsetY * 2.0f + pageHeight) / (pageHeight * 2.0f));
}

// -------------------------------------------------------------------------------
//	currentPage:
//  return frame by current page
// -------------------------------------------------------------------------------
- (CGRect)currentFrame: (NSInteger)page {
    CGRect frame = self.bounds;
    frame.size.width = 80.0f;
    frame.origin.x = frame.size.width * page +10;
    frame.origin.y = 10.0f;
    
    return frame;
}

#pragma mark - UIScrollViewDelegate

// -------------------------------------------------------------------------------
//	scrollViewDidEndDecelerating:
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //[self loadVisiblePages];
}

// -------------------------------------------------------------------------------
// scrollViewDidScroll:
// any offset changes. Load the pages which are now on screen
// -------------------------------------------------------------------------------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
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
