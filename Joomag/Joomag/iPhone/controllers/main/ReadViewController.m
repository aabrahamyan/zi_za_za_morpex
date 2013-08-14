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

@interface ReadViewController () {
    MagazinRecord *mRecord;
    DataHolder *dataHolder;
    ImageDownloader *imageDownloader;
    int pageCount;
}

@end

@implementation ReadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor clearColor];
        dataHolder = [[DataHolder alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];  //TODO
	// Do any additional setup after loading the view.
    
    int topViewHeight = 44;
    
    topView = [[UIView alloc] init];
    CGRect frame = CGRectMake(0, 0, 1024, topViewHeight);
    topView.frame = frame;
    topView.backgroundColor = RGBA(43, 43, 44, 1);
    
    [self.view addSubview: topView];
    
    backButtonView = [UIButton buttonWithType:UIButtonTypeCustom];
    backButtonView.frame = CGRectMake(0, 0, topViewHeight, topViewHeight);  //TODO
    [backButtonView setImage:[Util imageNamedSmart:@"closeButton"] forState:UIControlStateNormal];
    [backButtonView setImage:[Util imageNamedSmart:@"closeButton"] forState:UIControlStateSelected];
    [backButtonView setImage:[Util imageNamedSmart:@"closeButton"] forState:UIControlStateHighlighted];
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
    
    pageScrollView = [[UIScrollView alloc] init];
    pageScrollView.frame = CGRectMake(0, topViewHeight, 1024, 768-2*topViewHeight); // TODO
    pageScrollView.pagingEnabled = YES;
    pageScrollView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview: pageScrollView];
    
    int scrollViewHeight = 130;
    
    UIView *scrollViewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 768-topViewHeight-150, 1024, scrollViewHeight)]; //TODO
    scrollViewBG.backgroundColor = [UIColor blackColor];
    scrollViewBG.alpha = 0.7;
    
    [self.view addSubview: scrollViewBG];
    
    navScrollView = [[UIScrollView alloc] init];
    navScrollView.frame = CGRectMake(0, 768-topViewHeight-150, 1024, scrollViewHeight); // TODO
    navScrollView.pagingEnabled = YES;
    navScrollView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview: navScrollView];
}

- (void)backToFeaturedView {
    [UIView transitionWithView: self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromTop animations:nil completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)startDownloadMagazine: (NSInteger)number {
    
    mRecord = [dataHolder.testData objectAtIndex: number];
    //NSLog(@"pageCount: %@",mRecord.pageImageURLsArray);

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
    
        NSLog(@"pos: %i", pagXPos);
        
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
         NSLog(@"img: %@",image);
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
