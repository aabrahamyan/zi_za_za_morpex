//
//  ExploreScrollView.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-08-05.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "ExploreScrollView.h"
#import "MainDataHolder.h"
#import "ImageDownloader.h"
#import "MagazinRecord.h"
#import "UIImageView+WebCache.h"

#define TILE_WIDTH_IPHONE 160
#define TILE_HEIGHT_IPHONE 200
#define TILE_WIDTH_IPAD 220
#define TILE_HEIGHT_IPAD 280

@interface ExploreScrollView () {
    NSInteger entriesLength;
    int tileW;
    int tileH;
    int index;
}

// the set of ImageDownloader objects for each magazine
@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;
@property (nonatomic, strong) NSMutableArray *pageViews;

@end
@implementation ExploreScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        // Set BackGround Color
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        
        self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
        self.pageViews = [[NSMutableArray alloc] init];
        
        
        // Load the initial set of pages that are on screen
        [self loadVisibleImages];
    }
    return self;
}

- (void) redrawData {
    self.entries = [MainDataHolder getInstance].testData;
    entriesLength = self.entries.count;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        NSArray *arrayIPhone = @[ @[@0, @0], @[@1, @0], @[@0, @1], @[@1, @1] ];
        tileH = 170; tileW = 130;
        [self setTilesWithArray: arrayIPhone tileWidth: TILE_WIDTH_IPHONE andHeight: TILE_HEIGHT_IPHONE];
    }
    else
    {
        NSArray *arrayIPad = @[ @[@0, @0], @[@1, @0], @[@2, @0], @[@0, @1], @[@1, @1], @[@2, @1] ];
        tileH = 220; tileW = 170;
        [self setTilesWithArray: arrayIPad tileWidth: TILE_WIDTH_IPAD andHeight: TILE_HEIGHT_IPAD];
    }
    
    // Load the initial set of pages that are on screen
    [self loadVisibleImages];
}

// -------------------------------------------------------------------------------
// setTilesWithArray: tileWidth: andHeight:
// Set the images in scroll view
// -------------------------------------------------------------------------------
- (void)setTilesWithArray: (NSArray *)arr tileWidth: (int) width andHeight: (int)height {
    
    int xPosition = 0;
    int yPosition = 0;
    int offsetX = 0;
    index = [arr count];
    
    for (int i = 0; i < entriesLength; i ++) {
        
        if(i%index == 0 && i!=0){
            offsetX += index/2*width;
        }
        
        xPosition = offsetX + [arr[i%index][0] intValue]*width;
        yPosition = [arr[i%index][1] intValue]*height;
        
        //NSLog(@"x: %d y: %d index: %i",xPosition, yPosition, index);
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(xPosition, yPosition, tileW, tileH)];
        imageView.image = [UIImage imageNamed:@"placeholder.png"];
        imageView.tag = i+1;
        
        [self addSubview:imageView];
    }
    
    // Set up the content size of the scroll view for IPHONE
    self.contentSize = CGSizeMake(2*660, self.frame.size.height); //TODO
}

// -------------------------------------------------------------------------------
// loadVisibleImages
// Load the images which are now on screen
// -------------------------------------------------------------------------------
- (void)loadVisibleImages {
    // First, determine which page is currently visible
    int page = [self currentPage:self.contentOffset.x];
    [self loadPage:page];
}

// -------------------------------------------------------------------------------
// loadPage:
// Load an individual page
// -------------------------------------------------------------------------------
- (void)loadPage:(int)page {
    int len = index*page+index;
    
    for (UIImageView *subview in [self subviews]) {
        if (subview.tag < len+1 && subview.tag != 0) {
            // Load an individual page, first seeing if we've already loaded it
            MagazinRecord *mRecord = [self.entries objectAtIndex:subview.tag-1];
            if(!mRecord.magazinDetailsIcon)
                [self startIconDownload:mRecord:subview];
            else
                subview.image = mRecord.magazinDetailsIcon;
        }
    }
}

// -------------------------------------------------------------------------------
//	startIconDownload:ImageView:
// -------------------------------------------------------------------------------

- (void) startIconDownload: (MagazinRecord *) magazinRecord : (UIImageView *) view {
    
    //[view setImageWithURL: [NSURL URLWithString: magazinRecord.magazinDetailsImageURL] placeholderImage: nil options:SDWebImageProgressiveDownload];
    
    __block UIImageView *imageView = view;
    imageView.alpha = 0.0f;
    // Here we use the new provided setImageWithURL: method to load the web image

    [view setImageWithURL: [NSURL URLWithString: magazinRecord.magazinDetailsImageURL]
                placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                         success:^(UIImage *image, BOOL dummy) {
                             if (image) {
                                 imageView.image = image;
                                 
                                 [UIView animateWithDuration:0.3 animations:^{
                                        imageView.alpha = 1.0f;
                                 }];
                                 
                                 
                             } else {
                                 NSLog(@"NO IMAGE");
                             }
                         }
                         failure:^(NSError *error) {
                             NSLog(@"FAILED DOWNLOADING IMAGE !!!");
                         }
     ];
}


// -------------------------------------------------------------------------------
//	currentPage:
//  return current page by offset x
// -------------------------------------------------------------------------------
- (int)currentPage: (float)offsetX {
    return (int)floor((offsetX * 2.0f + self.frame.size.width) / (self.frame.size.width * 2.0f));
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

- (void)setShadow: (UIImageView *)imageView {
    imageView.layer.shadowColor = [UIColor blackColor].CGColor;
    imageView.layer.shadowOffset = CGSizeMake(3, 3);
    imageView.layer.shadowOpacity = 0.7;
    imageView.layer.shadowRadius = 1.0;
    imageView.clipsToBounds = NO;
}

#pragma mark - UIScrollViewDelegate

// -------------------------------------------------------------------------------
//	scrollViewDidEndDecelerating:
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self loadVisibleImages];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updatePageControl2" object:nil];
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

/*
 int arrIPhone[4][2] ={{0,0},{1,0},{0,1},{1,1}};
 int arrIpad[6][2] ={{0,0},{1,0},{2,0},{0,1},{1,1},{2,1}};
 
 if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
 tileW = 150;
 tileH = 200;
 
 for (int i = 0; i < 11; i ++) {
 if(i%4 == 0 && i!=0){
 offsetX += 2*tileW+20;
 }
 
 xPosition = offsetX + arrIPhone[i%4][0]*tileW;
 yPosition = arrIPhone[i%4][1]*tileH;
 
 //NSLog(@"x: %d y: %d",xPosition, yPosition);
 UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(xPosition+20, yPosition, 130, 170)];
 imageView.image = [UIImage imageNamed:@"placeholder.png"];
 imageView.tag = i+1;
 
 [self addSubview:imageView];
 }
 
 index = 4;
 
 // Set up the content size of the scroll view for IPHONE
 self.contentSize = CGSizeMake(3*320, self.frame.size.height);
 
 } else {
 tileW = 220;
 tileH = 280;
 
 for (int i = 0; i < 11; i ++) {
 if(i%6 == 0 && i!=0){
 NSLog(@"i: %i",i);
 offsetX += 3*tileW;
 }
 
 xPosition = offsetX + arrIpad[i%6][0]*tileW;
 yPosition = arrIpad[i%6][1]*tileH;
 
 //NSLog(@"x: %d y: %d",xPosition, yPosition);
 UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(xPosition, yPosition, 170, 220)];
 imageView.image = [UIImage imageNamed:@"placeholder.png"];
 imageView.tag = i+1;
 
 [self addSubview:imageView];
 }
 
 index = 6;
 
 // Set up the content size of the scroll view for IPHONE
 self.contentSize = CGSizeMake(6*320, self.frame.size.height);
 }
 */


@end
