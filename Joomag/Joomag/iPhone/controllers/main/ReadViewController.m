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
//#import "AFImageRequestOperation.h"
#import "ReaderView.h"  
#import "TiledView.h"




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
    
    TiledView * tlView;
}

@end

@implementation ReadViewController


- (id) init {
    self = [super init];
    if (self) {

        self.view.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark requests part--

- (void) didFailResponse:(id)responseObject {

}

- (void) didFinishResponse: (id)responseObject {
    @autoreleasepool {
        
    
    
    NSArray * pageData = (NSArray*) responseObject;
    
    if([pageData count] == 1) {
      NSInteger counter = [[[pageData objectAtIndex:0] objectForKey:@"page_count"] intValue];                
        
        
        if(counter > 0) {
            pageCount = counter;
            
            xItemPos = 0;
            pagXPos = 0;
            pageWidth = 1024;
            itemWidth = 200;
            itemContentWidth = 0;
            pageContentWidth = 0;
            firstPageIndex = 1;
            secondPageIndex = 2;
            scrollViewIndex = 0;
            //currentMagazinePageCount = counter;
            
            NSLog(@"Number of Pages = = = = = = = = %d",counter);
            
            [self generatePageStringAndHit:counter];
            
            for (int i = 0; i < counter; i++) {
                
                //ConnectionManager * conManager = [[ConnectionManager alloc] init];
                //[conManager constructGetMapagzinePage:self.currentMagazineId withPageNumber:i andWithDelegate:self];
            }
        }
        
    } else {
        
        
    }
    }
}

- (void) generatePageStringAndHit: (NSInteger) numberOfPages {
    NSString * page = @"";
    
    @autoreleasepool {
        pageScrollView.contentSize = CGSizeMake((numberOfPages/2)*1024, 768-2*44);
    for (int i = 0;i < numberOfPages; i++) {
    
        NSString * currentNumberString = [NSString stringWithFormat:@"%d", i];
        if([currentNumberString length] == 1) {
            page = [NSString stringWithFormat:@"0%@",currentNumberString];
        } else {
            page = [NSString stringWithFormat:@"%@", currentNumberString];
        }
        
        [pageImages setObject:[NSNull null] forKey:currentNumberString]; 
        
        NSString * queryUri = [Util generateRequestBlock:page withMagazineId:self.currentMagazineId];
        queryUri = [@"http://www.joomag.com/Frontend/WebService/getPageG.php?token=" stringByAppendingFormat:@"%@%@", queryUri, @"&si=1"];
        
        NSLog(@"QUERY URI + %@", queryUri);
        
        [self startDownloadMagazine:i withImageUrl:queryUri];
         
    }}
    
        
}

- (void) hitPageDescription : (NSInteger) magazineId {
    MagazinRecord * currentMagazine = [[MainDataHolder getInstance].testData objectAtIndex:magazineId];
    
    if(currentMagazine) {
        NSInteger magId = currentMagazine.magazineID;
        self.currentMagazineId = magId;
        ConnectionManager * conManager = [[ConnectionManager alloc] init];
        [conManager constructGetMagazineRequest:magId withCallback:self];
    }
    
}

- (void) startDownloadingPages {
    
        
}

- (void) drawAllBorshesHere {
    dataHolder = [[DataHolder alloc] init];   
    
    isNavigationVisible = YES;
    loadedPercentage = 0;
    

    pageScrollView = [[UIScrollView alloc] init];
    pageScrollView.frame = CGRectMake(0, 0, 1024, 768-TOP_VIEW_HEIGHT); // TODO
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
    backButtonView.frame = CGRectMake(0, 0, TOP_VIEW_HEIGHT, TOP_VIEW_HEIGHT);  //TODO
    [backButtonView setImage:[Util imageNamedSmart:@"backButton"] forState:UIControlStateNormal];
    [backButtonView setImage:[Util imageNamedSmart:@"backButton"] forState:UIControlStateSelected];
    [backButtonView setImage:[Util imageNamedSmart:@"backButton"] forState:UIControlStateHighlighted];
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
    
    navScrollViewContainer = [[UIView alloc]  initWithFrame:CGRectMake(0, 768-TOP_VIEW_HEIGHT-NAV_SCROLL_HEIGHT, 1024, NAV_SCROLL_HEIGHT)]; //TODO
    navScrollViewContainer.userInteractionEnabled = YES;
    
    UIView *navScrollViewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, NAV_SCROLL_HEIGHT)]; //TODO
    navScrollViewBG.backgroundColor = [UIColor blackColor];
    navScrollViewBG.alpha = 0.7;
    navScrollViewBG.userInteractionEnabled = YES;
    
    [navScrollViewContainer addSubview: navScrollViewBG];
    
    navScrollView = [[UIScrollView alloc] init];
    navScrollView.userInteractionEnabled = YES;
    navScrollView.frame = CGRectMake(0, 0, 1024, NAV_SCROLL_HEIGHT); // TODO
    navScrollView.tag = 1111;
    navScrollView.backgroundColor = [UIColor clearColor];
    
    [navScrollViewContainer addSubview: navScrollView];
    
    [self.view addSubview: navScrollViewContainer];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(tapOnScreenHandler) userInfo:nil repeats:NO];
    
    buyView = [[UIView alloc] initWithFrame:CGRectMake(1024-150, 0, 150, 768)];
    buyView.backgroundColor = [UIColor blackColor];
    buyView.alpha = 0;
    [self.view addSubview: buyView];
    
    progressBgView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 1024, 2)]; // TODO
    progressBgView.backgroundColor = [UIColor whiteColor];
    
    [navScrollViewContainer addSubview: progressBgView];
    
    progressView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 1, 2)]; // TODO
    progressView.backgroundColor = [UIColor redColor];
    
    [navScrollViewContainer addSubview: progressView];
    
  
    // [self startDownloadMagazine: 0]; //TODO set scroll View current page
}


- (void)loadView {
    [super loadView];
    
    pageImages = [[NSMutableDictionary alloc] init];
    pageViews = [[NSMutableArray alloc] init];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self drawAllBorshesHere];
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
    [self animateView: topView withFrame: CGRectMake(0, -TOP_VIEW_HEIGHT, 1024, TOP_VIEW_HEIGHT)];
    [self animateView: navScrollViewContainer withFrame: CGRectMake(0, 768, 1024, NAV_SCROLL_HEIGHT)];
}

- (void)showTopAndBottomView {
    [self animateView: topView withFrame: CGRectMake(0, 0, 1024, TOP_VIEW_HEIGHT)];
    [self animateView: navScrollViewContainer withFrame: CGRectMake(0, 768-TOP_VIEW_HEIGHT-NAV_SCROLL_HEIGHT, 1024, NAV_SCROLL_HEIGHT)];
}

- (void)animateView: (UIView *)view withFrame: (CGRect)frm {
    [UIView animateWithDuration: 0.3
                     animations:^{
                         view.frame = frm;
                     }];
}

- (void)backToFeaturedView {
    [UIView transitionWithView: self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromTop animations:nil completion:nil];
    [self.navigationController popViewControllerAnimated: NO];
}


- (void)startDownloadMagazine: (NSInteger)number withImageUrl : (NSString *) imgUrl {
    
        UIImageView *pageImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder.png"]];
        UIImageView *itemImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder.png"]];
        
    [self startDownloadItems: number: imgUrl pageImage: pageImage andItem: itemImage];
        
    
}

- (void) tapOnNavigation: (UITapGestureRecognizer *) gesture {
    NSLog(@"gesture.view: %i", gesture.view.tag);
    [pageScrollView setContentOffset:CGPointMake(1024*gesture.view.tag, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate


- (UIView*) viewForZoomingInScrollView: (UIScrollView *) scrollView {
    
    return [scrollView viewWithTag:VIEW_FOR_ZOOM_TAG];
}


- (void) scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
    
    if(scrollView.tag != 7658943 && scale > 1.0) {
        tlView = [[TiledView alloc] initWithFrame:CGRectMake(10, -16, 3000, 2000)];
        
        /*if(globalPage == 0) {
            scrollViewInd1 = 1;
            scrollViewInd2 = 2;
        } else if (globalPage == 1) {
            scrollViewInd1 = 3;
            scrollViewInd2 = 4;
        } else {
            scrollViewInd1 = globalPage + globalPage + 1;
            scrollViewInd2 = globalPage + globalPage + 2;
        } */
        
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
        [tlView.layer setNeedsDisplay];
    } else if (scale == 1.0) {
        [tlView removeFromSuperview];
        scrollViewIndex = oldScrollViewIndex;
    }
}


- (void) scrollViewDidZoom:(UIScrollView *)scrollView {
//    UIView * view = (UIView*) [pageViews objectAtIndex:0];
//    pageScrollView.contentSize = view.bounds.size;
      tlView.hidden = YES;
}


// any offset changes
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self hideTopAndBottomView];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    float leftEdge = scrollView.contentOffset.x + scrollView.frame.size.width;
    if (leftEdge >= scrollView.contentSize.width) {
        // we are at the end
        NSLog(@"SHOW BUY");
        [UIView animateWithDuration:1.0 animations:^() {
            buyView.alpha = 0.8;
        }];
    } else {
        [UIView animateWithDuration:1.0 animations:^() {
            buyView.alpha = 0;
        }];
    }
    
    scrollViewIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
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

    
    [itemImage setImageWithURL:[NSURL URLWithString: imageStr] placeholderImage:nil options: 0 success:^(UIImage *image, BOOL cached) {
        @autoreleasepool {
            
        
            [self showingDownloadProgress];
            //item.image = image;
            //page.image = image;
        
            //[pageImages addObject:image];
            
            [pageImages setValue:image forKey:[NSString stringWithFormat:@"%d",numberito]]; 
            [pageViews addObject:[NSNull null]];
        
            //pageContentWidth += image.size.width;
        
            //if([pageImages count] > 2) {
                [self loadVisiblePages];
           // }
            
            item.image = image;
            item.frame = CGRectMake(xItemPos, 10, itemWidth, 90);
            itemContentWidth = xItemPos + itemWidth;
            
            [navScrollView addSubview: item];
            
             xItemPos += itemWidth;
            
            navScrollView.contentSize = CGSizeMake(itemContentWidth, 130);
        }
        
        } failure:^(NSError *error) {
            NSLog(@"Failure = %@",[error localizedDescription]);
        }];

     
    //NSURLRequest * req = [NSURLRequest requestWithURL:[NSURL URLWithString:imageStr]];

    
/*[AFImageRequestOperation imageRequestOperationWithRequest:req
                                                  success:^(UIImage *image) {
                            [pageImages addObject:image];
                            [pageViews addObject:[NSNull null]];
                                                      
                            pageContentWidth += image.size.width;
                            pageScrollView.contentSize = CGSizeMake(pageContentWidth, 768-2*44);
                                                      
                            if([pageImages count] > 2) {
                                [self loadVisiblePages];
                            }

}]; */
    
/*AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:req success:^(UIImage *image) {
    @autoreleasepool {
        [self showingDownloadProgress];
    
        [pageImages addObject:image];
        [pageViews addObject:[NSNull null]];
    
        pageContentWidth += image.size.width;
        pageScrollView.contentSize = CGSizeMake(pageContentWidth, 768-2*44);
    
        if([pageImages count] > 2) {
            [self loadVisiblePages];
        }
    }
    
    }];
    

    [operation start];*/
    


}

-(void)showingDownloadProgress
{
    loadedPercentage++;
    
    // NSLog(@"count: --------------------------- %i -----------------------------", (loadPercentage*100/pageCount));
    
    [UIView animateWithDuration:0.5f animations:^{
        // NSLog(@"width: %i", (loadPercentage*100/pageCount)*1024/100);
        progresLabel.text = [NSString stringWithFormat: @"%i %%", loadedPercentage*100/pageCount];
        CGRect theFrame = progressView.frame;
        theFrame.size.width = (loadedPercentage*100/pageCount)*1024/100; // TODO screen width
        progressView.frame = theFrame;
    }];
    
    if( (loadedPercentage*100/pageCount) == 100) {
        progresLabel.hidden = YES;
        progressView.hidden = YES;
        progressBgView.hidden = YES;
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
    NSInteger page = (NSInteger)floor((pageScrollView.contentOffset.x * 2.0f + pageWidth1) / (pageWidth1 * 2.0f));
    //pageWidth = pageWidth1;
    
    // Work out which pages we want to load
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    // Purge anything before the first page

        for (NSInteger i=0; i<firstPage; i++) {
            [self purgePage:i];
        }
    
    @autoreleasepool {
    
        for (NSInteger i=firstPage; i<=lastPage; i++) {
            [self loadPage:i];
        }
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
        UIImage * secondImage = [pageImages objectForKey:[NSString stringWithFormat:@"%d",secondPageIndex]]; 
        
        ReaderView * newPageView = [[ReaderView alloc] initWithFrameAndImages:CGRectMake(pagXPos, 0, pageWidth, 768) withLeftImageView:firstImage withRightImageView:secondImage withLeftFrame:CGRectMake(0, 0, pageWidth/2, 723) withRightFrame:CGRectMake(pageWidth/2, 0, pageWidth/2, 723)];
        
        newPageView.delegate = self;
        newPageView.parentOfImages.tag = VIEW_FOR_ZOOM_TAG;
        
        //pageContentWidth += newPageView.frame.size.width;
        
        
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


@end


