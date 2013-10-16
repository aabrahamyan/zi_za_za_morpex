//
//  FeaturedFeaturedScrollView.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-07-20.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "FeaturedScrollView.h"
#import "MainDataHolder.h"
#import "MagazinRecord.h"
#import "UIImageView+WebCache.h"
#import "Util.h"

@interface FeaturedScrollView () {
    CGFloat pageWidth;
    NSInteger entriesLength;
    bool didDataExist;
}

// the set of ImageDownloader objects for each app
@property (nonatomic, strong) NSMutableArray *pageViews;
@property (nonatomic, strong) NSMutableArray *cropImages;

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
        
        self.cropImages = [[NSMutableArray alloc] init];
        
        self.currentPage = 0;
        
        didDataExist = NO;
    }
    
    return self;
}

- (void) redrawData {

    if([[MainDataHolder getInstance].testData count] != 0) {
        
        if (!didDataExist) {
            
            // Populate Array With NSNull
            for (NSInteger i = 0; i < [[MainDataHolder getInstance].testData count]; ++i) {
                [self.pageViews addObject:[NSNull null]];
            }
            
            // Get Data
            self.entries = [MainDataHolder getInstance].testData;
            entriesLength = self.entries.count;
            
            didDataExist = YES;
        }
        
        // Get Scroll View Size
        CGSize pagesScrollViewSize = self.frame.size;
        pageWidth = pagesScrollViewSize.width;
        
        // Set up the content size of the scroll view
        self.contentSize = CGSizeMake(pageWidth * entriesLength, pagesScrollViewSize.height);
        
        UIInterfaceOrientation iOrientation = [UIApplication sharedApplication].statusBarOrientation;
        
        for (UIImageView *subview in [self subviews]) {
            
            if ([subview isKindOfClass:[UIImageView class]] && subview.tag > 0) {

                CGRect frame = self.frame;
                
                if (iOrientation == UIDeviceOrientationPortrait) {
                    self.contentOffset = CGPointMake(self.currentPage*768, 0);
                    frame.origin.x = 768 * (subview.tag-1);
                } else {
                    self.contentOffset = CGPointMake(self.currentPage*1024, 0);
                    frame.origin.x = 1024 * (subview.tag-1);
                }
                
                frame.origin.y = 0.0f;
                subview.frame = frame;
            }
        }
        
        [self loadVisiblePage: self.currentPage];
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
    } else {
        [self cropImageWhitOriginalSize: ((UIImage *)[self.cropImages objectAtIndex: page])
                           andImageView: ((UIImageView *)[self.pageViews objectAtIndex: page])];
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

    __block UIImageView *imageView = newPageView;

    // Here we use the new provided setImageWithURL: method to load the web image
    [newPageView setImageWithURL: [NSURL URLWithString: magazinRecord.magazinImageURL]
                placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                         success:^(UIImage *image, BOOL dummy) {
                                if (image) {
                                    [self.cropImages addObject: image];
                                    [self cropImageWhitOriginalSize: image andImageView: imageView];
                                }
                         }
                         failure:^(NSError *error) {
                             
                         }
     ];
    
    CGRect frame = self.bounds;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0.0f;
    
    newPageView.tag = page+1;
    newPageView.frame = frame;
    
    [self addSubview: newPageView];
    
    [self.pageViews replaceObjectAtIndex: page withObject: newPageView];
}

- (void)cropImageWhitOriginalSize: (UIImage *)image andImageView: (UIImageView *)imageView {
    UIInterfaceOrientation iOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (iOrientation == UIDeviceOrientationPortrait) {
        //crop the image
        
        //cropRect = CGRectMake(0, 0, image.size.width, 2*image.size.height);
        
        CGRect cropRect; // TODO: iPad mini
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            
            //if ( [[UIScreen mainScreen] bounds].size.height != 1024) {
            //    cropRect = CGRectMake(0, 0, image.size.width, 2*image.size.height);
            //} else {
                cropRect = CGRectMake(0, 0, image.size.width/2, image.size.height);
           // }
            
        } else {
            cropRect = CGRectMake(0, 0, image.size.width, 2*image.size.height);
        }

        CGImageRef imageRef     = CGImageCreateWithImageInRect([imageView.image CGImage], cropRect);
        UIImage *croppedAvatar  = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
        
        [imageView setImage:croppedAvatar];
    } else {
        [imageView setImage: image];
    }

}

#pragma mark - UIScrollViewDelegate

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
