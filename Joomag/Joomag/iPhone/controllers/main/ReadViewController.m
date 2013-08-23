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
#import "UIImageView+AFNetworking.h"
#import "DataHolder.h"
#import "UIImageView+WebCache.h"

#define TOP_VIEW_HEIGHT 44
#define NAV_SCROLL_HEIGHT 130

@interface ReadViewController () {
    MagazinRecord *mRecord;
    DataHolder *dataHolder;
    ImageDownloader *imageDownloader;
    UIScrollView *navScrollView;
    int pageCount;
    bool isNavigationVisible;
    int loadedPercentage;
    UILabel *progresLabel;
    UIView *progressBgView;
    UIView *progressView;
}

@end

@implementation ReadViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)loadView
{
    [super loadView];  //TODO
    dataHolder = [[DataHolder alloc] init];
    
    isNavigationVisible = YES;
    loadedPercentage = 0;
    
    pageScrollView = [[UIScrollView alloc] init];
    pageScrollView.frame = CGRectMake(0, 0, 1024, 768-TOP_VIEW_HEIGHT); // TODO
    pageScrollView.pagingEnabled = YES;
    pageScrollView.backgroundColor = [UIColor clearColor];
    //pageScrollView.delegate = self;
    
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

- (void)startDownloadMagazine: (NSInteger)number {
    
    mRecord = [dataHolder.testData objectAtIndex: number];
    
    titleLabelWithDate.text = [NSString stringWithFormat:@"%@ | %@", mRecord.magazinTitle, mRecord.magazinDate];
    [titleLabelWithDate sizeToFit];
    
    pageCount = [mRecord.pageImageURLsArray count];
    NSLog(@"pageCount: %i",pageCount);
    
    int xItemPos = 0;
    int pagXPos = 0;
    int pageWidth = 1024;
    int itemWidth = 200;
    int itemContentWidth = 0;
    int pageContentWidth = 0;
    
    for (int i = 0; i < pageCount; i++) {
        UIImageView *pageImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder.png"]];
        UIImageView *itemImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder.png"]];
        
        itemImage.tag = i;
        pageImage.tag = i;
        
        xItemPos += 20;
        
        pageImage.frame = CGRectMake(pagXPos, 0, pageWidth, 768);;
        [pageScrollView addSubview: pageImage];
        
        itemImage.frame = CGRectMake(xItemPos, 10, itemWidth, 90);;
        UITapGestureRecognizer *tapOnNav = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnNavigation:)];
        tapOnNav.numberOfTapsRequired = 1;
        [itemImage addGestureRecognizer: tapOnNav];
        itemImage.userInteractionEnabled = YES;
        
        itemContentWidth = xItemPos + itemWidth;
        pageContentWidth = pagXPos + pageWidth;
        
        [navScrollView addSubview: itemImage];
        
        [self startDownloadItems: [mRecord.pageImageURLsArray objectAtIndex:i] pageImage: pageImage andItem: itemImage];
        
        pagXPos += pageWidth;
        xItemPos += itemWidth;
    }
    
    
    pageScrollView.contentSize = CGSizeMake(pageContentWidth, 768-2*44);
    navScrollView.contentSize = CGSizeMake(itemContentWidth, 130);
}

- (void)tapOnNavigation: (UITapGestureRecognizer *)gesture {
    NSLog(@"gesture.view: %i", gesture.view.tag);
    [pageScrollView setContentOffset:CGPointMake(1024*gesture.view.tag, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate

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
}

// -------------------------------------------------------------------------------
//	startIconDownload:forIndexPath:
// -------------------------------------------------------------------------------
- (void)startDownloadItems: (NSString *)imageStr  pageImage: (UIImageView *)pageImage andItem: (UIImageView *)itemImage {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: imageStr]];
    
    __block UIImageView *page = pageImage;
    __block UIImageView *item = itemImage;
    
    [pageImage setImageWithURLRequest:request
                     placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                              success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
     {
         page.image = image;
         item.image = image;
         [self showingDownloadProgress];
     }
                              failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
     {
         NSLog(@"ImageDownloader READ failure");
     }];
    
    //    [pageImage setImageWithURL: [NSURL URLWithString: imageStr] placeholderImage:nil options:SDWebImageProgressiveDownload];
    //    [itemImage setImageWithURL: [NSURL URLWithString: imageStr] placeholderImage:nil options:SDWebImageProgressiveDownload];
    //    pageImage.image = pageImage.image;
    //    itemImage.image = itemImage.image;
    //    [self showingDownloadProgress];
    
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

@end
