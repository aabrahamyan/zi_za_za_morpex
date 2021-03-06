//
//  ReadViewController.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-08-12.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "ReadViewController.h"
#import "MagazinRecord.h"
#import "DataHolder.h"
#import "Util.h"
#import "ImageDownloader.h"
#import "DataHolder.h"
#import "ConnectionManager.h"
#import "MainDataHolder.h"
#import "UIImageView+WebCache.h"
#import "ReaderView.h"
#import "TiledView.h"
#import "CustomTabBarController.h"
#import "CustomTabBarController_iPad.h"




#define TOP_VIEW_HEIGHT 44
#define NAV_SCROLL_HEIGHT 130

#define VIEW_FOR_ZOOM_TAG (1)

@interface ReadViewController () {
    MagazinRecord *mRecord;
    DataHolder *dataHolder;
    ImageDownloader *imageDownloader;
    // SDWebImageManager *imageManager;
    UIScrollView *navScrollView;
    int pageCount;
    bool isNavigationVisible;
    int loadedPercentage;
    UILabel *progresLabel;
    UIView *progressBgView;
    UIView *progressView;
    TiledView * tlView;
    
    //----- Private Primitives for Calculations ------//
    int xItemPos;
    int pagXPos;
    int pageWidth;
    int itemWidth;
    int itemContentWidth;
    int pageContentWidth;
    int firstPageIndex;
    int secondPageIndex;
    int scrollViewIndex;
    int currentMagazinePageCount;
    int globalPage;
    int scrollViewInd1;
    int scrollViewInd2;
    int oldScrollViewIndex;
    int pageNumberYouWantToGoTo;
    
    //----- Read Properties ------//
    CGFloat magazineWidth;
    CGFloat magazineHeight;
    
    CGFloat magazineZoomWidth;
    CGFloat magazineZoomHeight;
    
    NSInteger horizontalBlocks;
    NSInteger verticalBlocks;
    
    CGFloat tileWidth;
    CGFloat tileHeight;
    CGSize oldCVSize;
    
    float _scalingFactor;
    
    BOOL didEnterLoadView;
    NSInteger MAIN_MAG_ID;
    
    UIInterfaceOrientation currentOrientation;
    UIInterfaceOrientation currentInResponseOrientation;
    BOOL orientationChanged;
}

@end

@implementation ReadViewController


- (id) init {
    self = [super init];
    if (self) {

        self.view.backgroundColor = [UIColor clearColor];
        didEnterLoadView = YES;
        MAIN_MAG_ID = 0;
        pageNumberYouWantToGoTo = 0;
        currentInResponseOrientation = [UIApplication sharedApplication].statusBarOrientation;
    }
    
    return self;
}

- (void) calculateScalingFactor : (NSArray *) pageData {
    NSLog(@"pageData = %@",pageData);
    
    if(UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
        magazineWidth = 768;
        magazineHeight = 1004;
        pageScrollView.frame = CGRectMake(0, 0, 768, 1004);
    } else {
        magazineWidth = 1024;
        magazineHeight = 748;
        pageScrollView.frame = CGRectMake(0, 0, 1024, 748);
    }
    
    UIImage * bgImg = [Util imageWithImage:[UIImage imageNamed:@"placeholder.png"] scaledToSize:pageScrollView.frame.size];
    
    pageScrollView.backgroundColor = [UIColor colorWithPatternImage:bgImg];
        
}

#pragma mark requests part--

- (void) didFailResponse:(id)responseObject {

}

- (void) didFinishResponse: (id)responseObject {
    
    
        NSArray * pageData = (NSArray*) responseObject;            
    
        [self calculateScalingFactor:pageData];
        
        if([pageData count] == 1) {
            NSInteger counter = [[[pageData objectAtIndex:0] objectForKey:@"page_count"] intValue];
        
        
        if(counter > 0) {
            pageCount = counter;
            
            xItemPos = 0;
            pagXPos = 0;
            if(UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
                pageWidth = 768;
            } else {
                pageWidth = 1024;
            }
            if(UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
                itemWidth = 100;
            } else {
                itemWidth = 200;
            }
            itemContentWidth = 0;
            pageContentWidth = 0;
            firstPageIndex = 1;
            secondPageIndex = 2;
            scrollViewIndex = 0;
            //currentMagazinePageCount = counter;
            

            
            [self generatePageStringAndHit:counter];
            
            for (int i = 0; i < counter; i++) {
                
                //ConnectionManager * conManager = [[ConnectionManager alloc] init];
                //[conManager constructGetMapagzinePage:self.currentMagazineId withPageNumber:i andWithDelegate:self];
            }
        }
        
    } else {
        
        
    }
 
    UIInterfaceOrientation orient = [UIApplication sharedApplication].statusBarOrientation;
    
    if(currentInResponseOrientation != orient) {
        CGRect frame = pageScrollView.frame; 
        frame.origin.x = frame.size.width * pageNumberYouWantToGoTo;
        frame.origin.y = 0;
        [pageScrollView scrollRectToVisible:frame animated:NO];
        scrollViewIndex = pageNumberYouWantToGoTo;
        [self loadVisiblePages];
    }
    
}

- (void) generatePageStringAndHit: (NSInteger) numberOfPages {
    NSString * page = @"";
    
        if(UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
            pageScrollView.contentSize = CGSizeMake((numberOfPages/2)*768, magazineHeight);
        } else {
            pageScrollView.contentSize = CGSizeMake((numberOfPages/2)*1024, magazineHeight);
        }
    
    for (int i = 0;i < numberOfPages; i++) {
        
        NSString * currentNumberString = [NSString stringWithFormat:@"%d", i];
        if([currentNumberString length] == 1) {
            page = [NSString stringWithFormat:@"0%@",currentNumberString];
        } else {
            page = [NSString stringWithFormat:@"%@", currentNumberString];
        }
        
        [pageImages setObject:[NSNull null] forKey:currentNumberString];
    }
    
    
        for (int i = 0;i < numberOfPages; i++) {
    
            NSString * currentNumberString = [NSString stringWithFormat:@"%d", i];
            if([currentNumberString length] == 1) {
                page = [NSString stringWithFormat:@"0%@",currentNumberString];
            } else {
                page = [NSString stringWithFormat:@"%@", currentNumberString];
            }
        
            //[pageImages setObject:[NSNull null] forKey:currentNumberString];
        
            NSString * queryUri = [Util generateRequestBlock:page withMagazineId:self.currentMagazineId];
            queryUri = [@"http://www.joomag.com/Frontend/WebService/getPageG.php?token=" stringByAppendingFormat:@"%@%@", queryUri, @"&si=1"];
                
            [self startDownloadMagazine:i withImageUrl:queryUri];
         
    }
    
        
}

- (void) hitPageDescription : (NSInteger) magazineId {
    MagazinRecord * currentMagazine = [[MainDataHolder getInstance].testData objectAtIndex:magazineId];
    
    if(currentMagazine) {
        NSInteger magId = currentMagazine.magazineID;
        self.currentMagazineId = magId;
        MAIN_MAG_ID = magazineId;
        ConnectionManager * conManager = [[ConnectionManager alloc] init];
        [conManager constructGetMagazineRequest:magId withCallback:self];
    }
    
}

- (void) hitPageDescriptionWithMagazineId: (NSInteger) magazineId {
    self.currentMagazineId = magazineId;
    ConnectionManager * conManager = [[ConnectionManager alloc] init];
    [conManager constructGetMagazineRequest:magazineId withCallback:self];
}


- (void) startDownloadingPages {
    
        
}

- (void) drawAllBorshesHere {
    dataHolder = [[DataHolder alloc] init];   
    
    isNavigationVisible = YES;
    loadedPercentage = 0;
    
    if(UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
        self.view.frame = CGRectMake(0, 0, 768, 1004);
        oldCVSize = self.view.frame.size;
    } else {
        self.view.frame = CGRectMake(0, 0, 1024, 748);
        oldCVSize = self.view.frame.size;
    }

    pageScrollView = [[UIScrollView alloc] init];
    if(UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
        pageScrollView.frame = CGRectMake(0, 0, 768, 1004);
    } else {
        pageScrollView.frame = CGRectMake(0, 0, 1024, 748);
    }
    
    NSLog(@"pageScrollView = %@",NSStringFromCGRect(pageScrollView.frame));
    
    pageScrollView.tag = 7658943;
    pageScrollView.delegate = self;
    pageScrollView.pagingEnabled = YES;
    pageScrollView.backgroundColor = [UIColor clearColor];

    
    [self.view addSubview: pageScrollView];
    
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnScreenHandler)];
    pageScrollView.userInteractionEnabled = YES;
    [pageScrollView addGestureRecognizer: tapOnScreen];
    
    topView = [[UIView alloc] init];
    CGRect frame = CGRectMake(0, 0, 1024, TOP_VIEW_HEIGHT);
    topView.frame = frame;
    topView.backgroundColor = RGBA(43, 43, 44, 1);
    
    [self.view addSubview: topView];
    
    backButtonView = [UIButton buttonWithType:UIButtonTypeCustom];
    backButtonView.frame = CGRectMake(0, 0, TOP_VIEW_HEIGHT, TOP_VIEW_HEIGHT);
    [backButtonView setBackgroundImage:[Util imageNamedSmart:@"backButton"] forState:UIControlStateNormal];
    backButtonView.showsTouchWhenHighlighted = YES;
    [backButtonView addTarget:self action:@selector(backToFeaturedView) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview: backButtonView];
    
    titleLabelWithDate = [[UILabel alloc] init];
    titleLabelWithDate.frame = CGRectMake(50, 10, 150, 40);
    titleLabelWithDate.backgroundColor = [UIColor clearColor];
    titleLabelWithDate.font = [UIFont systemFontOfSize:20.0];
    titleLabelWithDate.textColor = [UIColor whiteColor];
    titleLabelWithDate.numberOfLines = 1;
    
    [topView addSubview: titleLabelWithDate];
    
    progresLabel = [[UILabel alloc] init];
    progresLabel.frame = CGRectMake(370, 0, 60, 44);
    progresLabel.backgroundColor = [UIColor clearColor];
    progresLabel.font = [UIFont systemFontOfSize:20.0];
    progresLabel.textColor = [UIColor whiteColor];
    progresLabel.numberOfLines = 1;
    
    [topView addSubview: progresLabel];
    
    if(UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
    
        navScrollViewContainer = [[UIView alloc]  initWithFrame:CGRectMake(0, 1024-TOP_VIEW_HEIGHT-NAV_SCROLL_HEIGHT, 768, NAV_SCROLL_HEIGHT)]; //TODO
        
    } else {
    
        navScrollViewContainer = [[UIView alloc]  initWithFrame:CGRectMake(0, 768-TOP_VIEW_HEIGHT-NAV_SCROLL_HEIGHT, 1024, NAV_SCROLL_HEIGHT)]; //TODO
        
    }
    
    navScrollViewContainer.userInteractionEnabled = YES;
    
    UIView *navScrollViewBG = nil;
    if(UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
        navScrollViewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 768, NAV_SCROLL_HEIGHT)]; //TODO
    } else {
        navScrollViewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, NAV_SCROLL_HEIGHT)]; //TODO
    }
    navScrollViewBG.backgroundColor = [UIColor blackColor];
    navScrollViewBG.alpha = 0.7;
    navScrollViewBG.userInteractionEnabled = YES;
    
    [navScrollViewContainer addSubview: navScrollViewBG];
    
    navScrollView = [[UIScrollView alloc] init];
    navScrollView.userInteractionEnabled = YES;
    
    if(UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
        navScrollView.frame = CGRectMake(0, 0, 768, NAV_SCROLL_HEIGHT); // TODO
    } else {
        navScrollView.frame = CGRectMake(0, 0, 1024, NAV_SCROLL_HEIGHT); // TODO
    }
    
    navScrollView.tag = 1111;
    navScrollView.backgroundColor = [UIColor clearColor];

    [navScrollViewContainer addSubview: navScrollView];
    
    [self.view addSubview: navScrollViewContainer];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(tapOnScreenHandler) userInfo:nil repeats:NO];
    if(UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
        buyView = [[UIView alloc] initWithFrame:CGRectMake(768-150, 0, 150, 768)];
    } else {
        buyView = [[UIView alloc] initWithFrame:CGRectMake(1024-150, 0, 150, 768)];
    }
    
    buyView.backgroundColor = [UIColor blackColor];
    buyView.alpha = 0;
    [self.view addSubview: buyView];
    
    if(UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
        progressBgView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 768, 2)]; // TODO
    } else {
        progressBgView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 1024, 2)]; // TODO
    }
    
    progressBgView.backgroundColor = [UIColor whiteColor];
    
    [navScrollViewContainer addSubview: progressBgView];
    
    progressView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 1, 2)]; // TODO
    progressView.backgroundColor = [UIColor redColor];
    
    [navScrollViewContainer addSubview: progressView];    
  
    // [self startDownloadMagazine: 0]; //TODO set scroll View current page
}


- (void)loadView {
    [super loadView];
    
    didEnterLoadView = YES;
    orientationChanged = NO;
    pageImages = [[NSMutableDictionary alloc] init];
    pageViews = [[NSMutableArray alloc] init];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self drawAllBorshesHere];
    
    currentOrientation = [UIApplication sharedApplication].statusBarOrientation;
        
}

- (void)tapOnScreenHandler {
    if(isNavigationVisible){
        [self hideTopAndBottomView];
        isNavigationVisible = NO;
    } else {
        [self showTopAndBottomView];
        isNavigationVisible = YES;
    }
}

- (void)hideTopAndBottomView {
    
        if(UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
            
            [self animateView: topView withFrame: CGRectMake(0, -TOP_VIEW_HEIGHT, 768, TOP_VIEW_HEIGHT)];
           
            [self animateView: navScrollViewContainer withFrame: CGRectMake(0, 1024, 768, NAV_SCROLL_HEIGHT)];
            
        } else {
            
            [self animateView: topView withFrame: CGRectMake(0, -TOP_VIEW_HEIGHT, 1024, TOP_VIEW_HEIGHT)];

            [self animateView: navScrollViewContainer withFrame: CGRectMake(0, 768, 1024, NAV_SCROLL_HEIGHT)];
            
        }
    CustomTabBarController_iPad * costum = [CustomTabBarController_iPad getInstance];
    costum.backGroundView.hidden = YES;


}

- (void)showTopAndBottomView {
    if(UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
        [self animateView: topView withFrame: CGRectMake(0, 0, 768, TOP_VIEW_HEIGHT)];
        
        [self animateView: navScrollViewContainer withFrame: CGRectMake(0, 1024-TOP_VIEW_HEIGHT-NAV_SCROLL_HEIGHT, 768, NAV_SCROLL_HEIGHT)];
    } else {
        [self animateView: topView withFrame: CGRectMake(0, 0, 1024, TOP_VIEW_HEIGHT)];
       
        [self animateView: navScrollViewContainer withFrame: CGRectMake(0, 768-TOP_VIEW_HEIGHT - NAV_SCROLL_HEIGHT, 1024, NAV_SCROLL_HEIGHT)];
    }

    CustomTabBarController_iPad * costum = [CustomTabBarController_iPad getInstance];
    costum.backGroundView.hidden = NO;
}

- (void)animateView: (UIView *)view withFrame: (CGRect)frm {
    [UIView animateWithDuration: 0.3
                     animations:^{
                         view.frame = frm;
                     }];
}

- (void)backToFeaturedView {
    [UIView transitionWithView: self.navigationController.view duration:1 options:[Util getFlipAnimationType] animations:nil completion:nil];
    [self.navigationController popViewControllerAnimated: NO];
}


- (void)startDownloadMagazine: (NSInteger)number withImageUrl : (NSString *) imgUrl {
    
        UIImageView *pageImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder.png"]];
        UIImageView *itemImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder.png"]];
    
       
    [self startDownloadItems: number: imgUrl pageImage: pageImage andItem: itemImage];
        
    
}

- (void) tapOnNavigation: (UITapGestureRecognizer *) gesture {
    if(UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
        [pageScrollView setContentOffset:CGPointMake(768 * gesture.view.tag, 0) animated:YES];
    } else {
        [pageScrollView setContentOffset:CGPointMake(1024 * gesture.view.tag, 0) animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate


- (UIView*) viewForZoomingInScrollView: (UIScrollView *) scrollView {
    
    return [scrollView viewWithTag:VIEW_FOR_ZOOM_TAG];
}


- (void) scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
    
    float comparableScale = 0.0f;
    if(UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        comparableScale = 1.955f;
    } else {
        comparableScale = 1.883f;
    }
    
    if(scrollView.tag != 7658943 && scale >= comparableScale) {
        
        if(UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {            
            tlView = [[TiledView alloc] initWithFrame:CGRectMake(0, 0, 1446.144f, 1928.192f)];
            
            scrollView.contentSize = CGSizeMake(1446.144f, 1928.192f);
        } else {
            tlView = [[TiledView alloc] initWithFrame:CGRectMake(0, 0, 3000, 2000)];           
            
            //scrollView.contentSize = CGSizeMake(3000, 2000);
        }
        
        
        if(scrollViewIndex == 0) {
            scrollViewInd1 = 1;
            scrollViewInd2 = 2;
        }
        
        oldScrollViewIndex = scrollViewIndex;
        
        scrollViewInd1 = scrollViewIndex + scrollViewIndex + 1;
        scrollViewInd2 = scrollViewIndex + scrollViewIndex + 2;
        
        tlView.pageIdLeft = scrollViewInd1;
        tlView.pageIdRight = scrollViewInd2;
        
        //tlView.pageIdLeft = scrollViewIndex+1;
        //tlView.pageIdRight = scrollViewIndex+2;
        tlView.magazineId = self.currentMagazineId;
    
        // TODO: Enable for drawing bigger image
        [scrollView addSubview:tlView];
        
    } else if (scale == 1.0) {
        [tlView removeFromSuperview];
        tlView = nil;
        scrollView.contentSize = oldCVSize;
        NSLog(@"oldCVSize = %@",NSStringFromCGSize(oldCVSize));
        scrollViewIndex = oldScrollViewIndex;
    }
}


- (void) scrollViewDidZoom:(UIScrollView *)scrollView {
      tlView.hidden = YES;
}


// any offset changes
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self hideTopAndBottomView];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    float leftEdge = scrollView.contentOffset.x + scrollView.frame.size.width;
    if (leftEdge >= scrollView.contentSize.width) {
        // we are at the end
        NSLog(@"SHOW BUY");
        [UIView animateWithDuration:1.0 animations:^() {
            //buyView.alpha = 0.8; TODO: Fix for end page
        }];
    } else {
        [UIView animateWithDuration:1.0 animations:^() {
            //buyView.alpha = 0;
        }];
    }
    
    scrollViewIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
    pageNumberYouWantToGoTo = scrollViewIndex;
    [self loadVisiblePages];
    
}

// -------------------------------------------------------------------------------
//	startIconDownload:forIndexPath:
// -------------------------------------------------------------------------------
- (void)startDownloadItems: (int) number : (NSString *)imageStr  pageImage: (UIImageView *)pageImage andItem: (UIImageView *)itemImage {
    // request image

    
    __block UIImageView *item = itemImage;
    //__block UIImageView *page = pageImage;
    
    __block int numberito = number;
    
    //SDWebImageManager *sharedManager = [SDWebImageManager sharedManager];

    //[sharedManager.imageDownloader setMaxConcurrentDownloads:1];
    //[sharedManager cancelAll]; //cancel all current queue

    
    [itemImage setImageWithURL:[NSURL URLWithString: imageStr] placeholderImage:[UIImage imageNamed:@"placeholder.png"] options: 0 success:^(UIImage *image, BOOL cached) {
            
        
            [self showingDownloadProgress];            
            
            [pageImages setValue:image forKey:[NSString stringWithFormat:@"%d",numberito]]; 
            [pageViews addObject:[NSNull null]];
        
            
            [self loadVisiblePages];
           
        
            
            item.image = image;
            
            if(UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
                
                item.frame = CGRectMake(xItemPos, 5, itemWidth, 100);
                itemContentWidth = xItemPos + itemWidth;
                
            } else {
                item.frame = CGRectMake(xItemPos, 5, itemWidth/2, 100);
                itemContentWidth = xItemPos + itemWidth/2;
            }
            
            [navScrollView addSubview: item];
            if(UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
                
                xItemPos += itemWidth+5;
                
            } else {
                
                xItemPos += itemWidth/2+5;
                
            }
            
            navScrollView.contentSize = CGSizeMake(itemContentWidth, 130);

        
        
    } failure:^(NSError *error) {
        NSLog(@"Failure = %@",[error localizedDescription]);
    }];

}

-(void)showingDownloadProgress {
    loadedPercentage++;
    
    
    [UIView animateWithDuration:0.5f animations:^{
        // NSLog(@"width: %i", (loadPercentage*100/pageCount)*1024/100);
        progresLabel.text = [NSString stringWithFormat: @"%i %%", loadedPercentage*100/pageCount];
        
        
        CGRect theFrame = progressView.frame;
        if(UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
            theFrame.size.width = (loadedPercentage*100/pageCount)*768/100;
        } else {
            theFrame.size.width = (loadedPercentage*100/pageCount)*1024/100;
        }
        
        progressView.frame = theFrame;
    }];
    
    if( (loadedPercentage*100/pageCount) == 100) {
        progresLabel.hidden = YES;
        progressView.hidden = YES;
        progressBgView.hidden = YES;                
        didEnterLoadView = NO;        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)loadVisiblePages {
    // First, determine which page is currently visible
    CGFloat pageWidth1 = pageScrollView.frame.size.width;
    NSInteger page = 0;
    if(UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
        page = (NSInteger)floor(pageScrollView.contentOffset.x / pageWidth1);
    } else {
       page = (NSInteger)floor((pageScrollView.contentOffset.x * 2.0f + pageWidth1) / (pageWidth1 * 2.0f));
    }
    

    
    // Work out which pages we want to load
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    // Purge anything before the first page

        for (NSInteger i=0; i<firstPage; i++) {
            [self purgePage:i];
        }        
    
        for (NSInteger i=firstPage; i<=lastPage; i++) {
            [self loadPage:i];
        }
    

        for (NSInteger i=lastPage+1; i < [self getPageImagesCount]; i++) {
            [self purgePage:i];
        }

}

- (int) getPageImagesCount {
    int count = 0;
    for (int i = 0; i < pageImages.count; i++) {
        id current = [pageImages objectForKey:[NSString stringWithFormat:@"%d",i]];
        
        if([current isKindOfClass:[UIImage class]]) {
            count++;
        }
    }
    
    return count;
}

- (void)loadPage:(NSInteger)page {
    if (page < 0 || page >= [self getPageImagesCount]) {
        // If it's outside the range of what we have to display, then do nothing
        return;
    }
                        
    // Load an individual page, first seeing if we've already loaded it
    UIView *pageView = [pageViews objectAtIndex:page];
    if ((NSNull*)pageView == [NSNull null]) {
        CGRect frame = pageScrollView.bounds;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0.0f;
        
        //UIImageView *newPageView = [[UIImageView alloc] initWithImage:[pageImages objectAtIndex:page]];
        
        
        globalPage = page;
        if(page == 0) {
            firstPageIndex = 1;
            secondPageIndex = 2;
        } else if (page == 1) {
            firstPageIndex = 3;
            secondPageIndex = 4;
        } else {
            firstPageIndex = page + page + 1;
            secondPageIndex = page + page + 2;
        }

        
        if([pageImages objectForKey:[NSString stringWithFormat:@"%d",firstPageIndex]] == [NSNull null]
           || [pageImages objectForKey:[NSString stringWithFormat:@"%d",secondPageIndex]] == [NSNull null]) {
            
            return;
            
        }
        

        UIImage * firstImage = [pageImages objectForKey:[NSString stringWithFormat:@"%d",firstPageIndex]];
        
        UIImage * secondImage = nil;
        secondImage = [pageImages objectForKey:[NSString stringWithFormat:@"%d",secondPageIndex]];
        
        ReaderView * newPageView = nil;
        if(UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
            
            newPageView = [[ReaderView alloc] initWithFrameAndImages:CGRectMake(pagXPos, 0, pageWidth, magazineHeight) withLeftImageView:firstImage withRightImageView:nil withLeftFrame:CGRectMake(0, 0, pageWidth, magazineHeight) withRightFrame:CGRectZero];
            
        } else {
            newPageView = [[ReaderView alloc] initWithFrameAndImages:CGRectMake(pagXPos, 0, pageWidth, 768) withLeftImageView:firstImage withRightImageView:secondImage withLeftFrame:CGRectMake(0, 0, pageWidth/2, 768) withRightFrame:CGRectMake(pageWidth/2, 0, pageWidth/2, 768)];
        }
        
        newPageView.delegate = self;
        newPageView.parentOfImages.tag = VIEW_FOR_ZOOM_TAG;
        
        
        
        newPageView.contentMode = UIViewContentModeScaleAspectFit;
        newPageView.frame = frame;
        
        [pageScrollView addSubview:newPageView];
        [pageViews replaceObjectAtIndex:page withObject:newPageView];
        
        pagXPos += pageWidth;
        

    }
}

- (void)purgePage:(NSInteger)page {
    if (page < 0 || page >= [self getPageImagesCount]) {
        // If it's outside the range of what we have to display, then do nothing
        return;
    }
    

    
    if([pageImages objectForKey:[NSString stringWithFormat:@"%d",firstPageIndex]] == [NSNull null]
       || [pageImages objectForKey:[NSString stringWithFormat:@"%d",secondPageIndex]] == [NSNull null]) {
        
        return;
        
    }
    
    // Remove a page from the scroll view and reset the container array
    UIView *pageView = [pageViews objectAtIndex:page];
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [pageViews replaceObjectAtIndex:page withObject:[NSNull null]];
        
//        pageContentWidth -= pageView.frame.size.width;
    }
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];        
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    NSLog(@"Rotation");
    
}

- (void) viewDidLayoutSubviews {
   if(!didEnterLoadView) {
       UIInterfaceOrientation iOrientation = [UIApplication sharedApplication].statusBarOrientation;
       
       if(currentOrientation != iOrientation) {
           currentOrientation = iOrientation;
           orientationChanged = YES;
       }
       
       if(orientationChanged) {
           [pageImages removeAllObjects];
           [pageViews removeAllObjects];
        
           [pageScrollView removeFromSuperview];
           pageScrollView = nil;
        
           [topView removeFromSuperview];
           topView = nil;
        
           [navScrollViewContainer removeFromSuperview];
           navScrollViewContainer = nil;
        
           [buyView removeFromSuperview];
           buyView = nil;
           
           [self hitPageDescription:MAIN_MAG_ID];
           
           if(iOrientation == UIInterfaceOrientationPortrait || iOrientation == UIInterfaceOrientationLandscapeRight) {
               [self drawAllBorshesHere];
               orientationChanged = NO;               
           }
       }
    }    
}



@end


