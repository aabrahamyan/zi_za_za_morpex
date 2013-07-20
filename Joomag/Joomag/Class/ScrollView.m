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

// the set of IconDownloader objects for each app
@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;

@end


@implementation ScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        DataHolder *dataHolder = [DataHolder sharedData];
        self.entries = dataHolder.testData;
        
        self.backgroundColor = [UIColor blackColor];
        self.delegate = self;
        self.pagingEnabled = YES;
        
        entriesLength = self.entries.count;
        NSLog(@"count: %@",self.entries);
        
        self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
        
        CGSize pagesScrollViewSize = self.frame.size;
        pageWidth = pagesScrollViewSize.width;
        
        self.contentSize = CGSizeMake(pagesScrollViewSize.width * [self.entries count], pagesScrollViewSize.height);
        
        for (NSInteger i = 0; i < entriesLength; ++i) {
            UIImageView *containerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder.png"]];
            containerView.frame = [self currentFrame:i];
            [self addSubview:containerView];
        }
        
        [self loadVisiblePages];
        
    }
    return self;
}

#pragma mark -

- (void)loadVisiblePages {
    
    NSInteger page = [self currentPage:self.contentOffset.x];
    //NSLog(@"page: %ld",(long)page);
    
    // Work out which pages we want to load
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 4;
    
    // First, determine which page is currently visible
    for (NSInteger i = firstPage; i < lastPage; i++) {
        if (i >= 0) {
            NSLog(@"loadPage: %i",i);// TODO
            [self loadPage:i];
        }
    }
}

- (void)loadPage: (NSInteger)page{
    if(entriesLength > 0){
        // Set up the page...
        MagazinRecord *mRecord = [self.entries objectAtIndex:page];
        if (!mRecord.magazinIcon) {
            if (self.dragging == NO && self.decelerating == NO) {
                [self startIconDownload:mRecord forIndexPath:page];
            }
            // if a download is deferred or in progress, return a placeholder image
            
        } else {
            // cell.imageView.image = appRecord.appIcon;
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
    NSLog(@"start download: %i",page);
    NSNumber *index = [NSNumber numberWithInteger:page];
    
    ImageDownloader *imageDownloader = [self.imageDownloadsInProgress objectForKey:index];
    if (imageDownloader == nil) {
        imageDownloader = [[ImageDownloader alloc] init];
        imageDownloader.magazinRecord = magazinRecord;
        [imageDownloader setCompletionHandler:^{
            NSLog(@"download finished");
            
            // Display the newly loaded image
            UIImageView *newPageView = [self.subviews objectAtIndex:page];
            newPageView.image = magazinRecord.magazinIcon;
            
            // Remove the IconDownloader from the in progress list.
            // This will result in it being deallocated.
            [self.imageDownloadsInProgress removeObjectForKey:index];
            NSLog(@"count: %i",[self.imageDownloadsInProgress count]);
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

- (NSInteger)currentPage: (float)offsetX {
    return (NSInteger)floor((offsetX * 2.0f + pageWidth) / (pageWidth * 2.0f));
}

- (CGRect)currentFrame: (NSInteger)page {
    CGRect frame = self.bounds;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0.0f;
    
    return frame;
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
    [self loadImagesForOnscreenRows:[self currentPage:self.contentOffset.x]];
}

@end
