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

#define TOP_VIEW_HEIGHT 44

@interface ReadViewController () {
    MagazinRecord *mRecord;
    DataHolder *dataHolder;
    ImageDownloader *imageDownloader;
    UIScrollView *navScrollView;
    int pageCount;
    bool isNavigationVisible;
}

@end

@implementation ReadViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor clearColor];
        dataHolder = [[DataHolder alloc] init];
    }
    return self;
}

- (void)loadView
{
    [super loadView];  //TODO
	// Do any additional setup after loading the view.
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnScreenHandler)];
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:tapOnScreen];
    
    isNavigationVisible = YES;
    
    pageScrollView = [[UIScrollView alloc] init];
    pageScrollView.frame = CGRectMake(0, 0, 1024, 768-TOP_VIEW_HEIGHT); // TODO
    pageScrollView.pagingEnabled = YES;
    pageScrollView.backgroundColor = [UIColor clearColor];
    pageScrollView.delegate = self;
    
    [self.view addSubview: pageScrollView];
    
    
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
    
    int scrollViewHeight = 130;
    
    navScrollViewContainer = [[UIView alloc]  initWithFrame:CGRectMake(0, 768-TOP_VIEW_HEIGHT-130, 1024, scrollViewHeight)];
    
    UIView *navScrollViewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, scrollViewHeight)]; //TODO
    navScrollViewBG.backgroundColor = [UIColor blackColor];
    navScrollViewBG.alpha = 0.7;
    
    [navScrollViewContainer addSubview: navScrollViewBG];
    
    navScrollView = [[UIScrollView alloc] init];
    navScrollView.frame = CGRectMake(0, 0, 1024, scrollViewHeight); // TODO
    navScrollView.tag = 1111;
    navScrollView.backgroundColor = [UIColor clearColor];
    
    [navScrollViewContainer addSubview: navScrollView];
    
    [self.view addSubview: navScrollViewContainer];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(tapOnScreenHandler) userInfo:nil repeats:NO];
    
    buyView = [[UIView alloc] initWithFrame:CGRectMake(1024-150, 0, 150, 768)];
    buyView.backgroundColor = [UIColor blackColor];
    buyView.alpha = 0;
    [self.view addSubview: buyView];
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
    [self animateView: topView toPos: -TOP_VIEW_HEIGHT];
    [self animateView: navScrollViewContainer toPos: 768];
}

- (void)showTopAndBottomView {
    [self animateView: topView toPos: 0];
    [self animateView: navScrollViewContainer toPos: 768-TOP_VIEW_HEIGHT-130];
}

- (void)animateView: (UIView *)view toPos: (int)pos {
    [UIView animateWithDuration: 0.3
                     animations:^{
                         view.frame = CGRectMake(0, pos, 1024, TOP_VIEW_HEIGHT);
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
    
    
    int xItemPos = 0;
    int pagXPos = 0;
    bool changePos = YES;
    int width = 0;
    int pageWidth = 512;
    CGRect itemFrm;
    int itemContentWidth = 0;
    int pageContentWidth = 0;
    
    for (int i = 0; i < pageCount; i++) {
        UIImageView *pageImage = [[UIImageView alloc] init];
        UIImageView *itemImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder.png"]];
        
        itemImage.tag = i;
        pageImage.tag = i;
        
        if (changePos == YES) {
            xItemPos = xItemPos + width + 20;
            width = 70;
            itemFrm = CGRectMake(xItemPos, 10, width, 90);
            changePos = NO;
        } else {
            xItemPos = xItemPos + width;
            itemFrm = CGRectMake(xItemPos, 10, width, 90);
            changePos = YES;
        }
        
        itemContentWidth = xItemPos + width;
        pageContentWidth = pagXPos + pageWidth;
        
        pageImage.frame = CGRectMake(pagXPos, 0, pageWidth, 768);;
        [pageScrollView addSubview: pageImage];
        
        pagXPos += pageWidth;
        
        itemImage.frame = itemFrm;
        [navScrollView addSubview: itemImage];
        
        [self startDownloadItems: [mRecord.pageImageURLsArray objectAtIndex:i] pageImage: pageImage andItem: itemImage];
    }
    
    pageScrollView.contentSize = CGSizeMake(pageContentWidth, 768-2*44);
    navScrollView.contentSize = CGSizeMake(itemContentWidth, 130);
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
         //NSLog(@"img: %@",image);
         page.image = image;
         item.image = image;
     }
                              failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
     {
         NSLog(@"ImageDownloader READ failure");
     }];
    
}

-(void)downloadShowingProgress
{
    /*
     NSMutableArray *opArr = [[NSMutableArray alloc] init];
     NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
     
     for (NSInteger i = 0; i <= 3; i++)
     {
     NSLog(@"i --- : %i", i);
     
     __block int x = i;
     
     NSURL *url = [[NSURL alloc] initWithString: [mRecord.pageImageURLsArray objectAtIndex:i]];
     NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
     
     AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
     
     [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
     NSLog(@"success");
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     NSLog(@"failure");
     }];
     
     [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
     NSLog(@"item: %i progres: %f",x, (float)totalBytesRead / (float)totalBytesExpectedToRead);
     }];
     
     [opArr addObject: operation];
     // [operation2 addDependency:operation1];
     // Add the operation to a queue
     // It will start once added
     // [operationQueue addOperation: operation];
     }
     
     //NSLog(@"opArr: %@", opArr);
     [operationQueue setMaxConcurrentOperationCount:3];
     [operationQueue addOperations: opArr waitUntilFinished:NO];
     */
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
