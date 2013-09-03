//
//  FeaturedFeaturedScrollView.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-07-20.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "FeaturedScrollView.h"
#import "MainDataHolder.h"
//#import "ImageDownloader.h"
#import "MagazinRecord.h"
#import "UIImageView+WebCache.h"

@interface FeaturedScrollView () {
    CGFloat pageWidth;
    NSInteger entriesLength;
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
        
        self.backgroundColor = [UIColor blackColor];
        self.pagingEnabled = YES;
        //self.showsVerticalScrollIndicator = NO;
        //self.showsHorizontalScrollIndicator = NO;
        //self.bouncesZoom = YES;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.contentMode = UIViewContentModeTopRight;
        self.autoresizingMask =(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        self.delegate = self;
        
        // Set up the array to hold the views for each page
        self.pageViews = [[NSMutableArray alloc] init];
        
        // Populate Array With NSNull
        for (NSInteger i = 0; i < 10; ++i) { // TODO: entriesLength
            [self.pageViews addObject:[NSNull null]];
        }
        
        self.currentPage = 0;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //NSLog(@"layoutSubviews");
}

- (void) redrawData {
    NSLog(@"redrawData");
    if([[MainDataHolder getInstance].testData count] != 0) {
        
        // Get Data
        self.entries = [MainDataHolder getInstance].testData;
        entriesLength = self.entries.count;
        
        // Get Scroll View Size
        CGSize pagesScrollViewSize = self.frame.size;
        pageWidth = pagesScrollViewSize.width;
        
        // Set up the content size of the scroll view
        self.contentSize = CGSizeMake(pageWidth * entriesLength, pagesScrollViewSize.height);
        
        [self loadVisiblePage: self.currentPage];
        
        UIInterfaceOrientation iOrientation = [UIApplication sharedApplication].statusBarOrientation;
        
        for (UIImageView *subview in [self subviews]) {
            
            if ([subview isKindOfClass:[UIImageView class]] && subview.tag > 0) {
                CGRect frame = self.frame;
                
                if (iOrientation == UIDeviceOrientationLandscapeLeft) {
                    self.contentOffset = CGPointMake(self.currentPage*1024, 0);
                    frame.origin.x = 1024 * (subview.tag-1);
                } else if (UIDeviceOrientationPortrait) {
                    self.contentOffset = CGPointMake(self.currentPage*768, 0);
                    frame.origin.x = 768 * (subview.tag-1);
                }
                
                frame.origin.y = 0.0f;
                subview.frame = frame;
            }
        }
    }
}

#pragma mark -

// -------------------------------------------------------------------------------
// loadVisiblePages
// Load the pages which are now on screen
// -------------------------------------------------------------------------------
- (void)loadVisiblePage: (NSInteger)page {
    
    // Work out which pages we want to load
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    // Purge anything before the first page
    for (NSInteger i = 0; i < firstPage; i++) {
        [self purgePage:i];
    }
    
    // Load an individual pages
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
    MagazinRecord *mRecord = [self.entries objectAtIndex:page];
    
    if ((NSNull*)pageView == [NSNull null]) {
        [self startIconDownload: mRecord forIndexPath: page];
    }
}

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
    
    UIImageView *newPageView = [[UIImageView alloc] init];
    
    //    // Display the newly loaded image
    //    [newPageView setImageWithURL: [NSURL URLWithString: magazinRecord.magazinImageURL]
    //                placeholderImage: [UIImage imageNamed: @"placeholder.png"]
    //                         options: SDWebImageProgressiveDownload];
    
    
    // Here we use the new provided setImageWithURL: method to load the web image
    [newPageView setImageWithURL: [NSURL URLWithString: magazinRecord.magazinImageURL]
                placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                         success:^(UIImage *image, BOOL dummy) {
                             //                                if (image) {
                             //
                             //                                    CGSize imageSize = image.size;
                             //                                    CGFloat width = imageSize.width;
                             //                                    CGFloat height = imageSize.height;
                             //
                             //                                    NSLog(@"width: %f height: %f", width, height);
                             //
                             //                                }
                         }
                         failure:^(NSError *error) {
                             
                         }
     ];
    
    //    UIInterfaceOrientation iOrientation = [UIApplication sharedApplication].statusBarOrientation;
    //
    //    if (iOrientation == UIDeviceOrientationLandscapeLeft) {
    //        //crop the image
    //        CGRect cropRect         = CGRectMake(0, 0, 1536, 900);
    //        CGImageRef imageRef     = CGImageCreateWithImageInRect([newPageView.image CGImage], cropRect);
    //        UIImage *croppedAvatar  = [UIImage imageWithCGImage:imageRef];
    //        CGImageRelease(imageRef);
    //        [newPageView setImage:croppedAvatar];
    //
    //    } else if (UIDeviceOrientationPortrait) {
    //        //crop the image
    //        CGRect cropRect         = CGRectMake(0, 0, (1536 / 2), 900);
    //        CGImageRef imageRef     = CGImageCreateWithImageInRect([newPageView.image CGImage], cropRect);
    //        UIImage *croppedAvatar  = [UIImage imageWithCGImage:imageRef];
    //        CGImageRelease(imageRef);
    //        [newPageView setImage:croppedAvatar];
    //    }
    
    CGRect frame = self.bounds;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0.0f;
    
    newPageView.tag = page+1;
    newPageView.frame = frame;
    
    [self addSubview: newPageView];
    
    
    [self.pageViews replaceObjectAtIndex: page withObject: newPageView];
}

#pragma mark - UIScrollViewDelegate

// -------------------------------------------------------------------------------
// scrollViewDidScroll:
// any offset changes. Load the pages which are now on screen
// -------------------------------------------------------------------------------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

// -------------------------------------------------------------------------------
//	scrollViewDidEndDecelerating:
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.currentPage = (NSInteger)floor(self.contentOffset.x / pageWidth);
    
    [self loadVisiblePage: self.currentPage];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updatePageControl" object:nil];
}

// called on start of dragging (may require some time and or distance to move)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideDetailsView" object:nil];
}


@end
