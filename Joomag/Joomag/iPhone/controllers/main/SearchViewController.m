//
//  SearchViewController.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-08-18.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "SearchViewController.h"
#import "MainDataHolder.h"
#import "Util.h"
#import "MagazinRecord.h"
#import "UIImageView+WebCache.h"
#import "ReadViewController.h"

@interface SearchViewController () {
    MainDataHolder *dataHolder;
    NSInteger entriesLength;
    UITextField *searchTextField;
    NSArray *arrSerach;
    int tileW;
    int tileH;
    
    CGRect searchBarViewFrame, searchScrollViewFrame;
    UIInterfaceOrientation iOrientation;
}

@property (nonatomic, strong) NSArray *entries;
@property (nonatomic, strong) NSArray *searchResult;
// the set of ImageDownloader objects for each magazine
@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;
@property (nonatomic, strong) NSMutableArray *workingArray;


@end

@implementation SearchViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        dataHolder = [MainDataHolder getInstance];
        self.entries = dataHolder.testData;
        entriesLength = self.entries.count;
        self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
        self.view.backgroundColor = RGBA(64, 64, 65, 1);
        arrSerach = [[NSArray alloc] init];
        self.workingArray = [NSMutableArray array];
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    //-------------------------------- Top Bar ------------------------------------
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 44)]; //TODO
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"buyIssueBg.png"]];
    [topView addSubview:backgroundView];
    [topView sendSubviewToBack: backgroundView];
    [self.view addSubview: topView];
    
    //-------------------------- Close Search Botton -------`----------------------
    closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(0, 0, 44, 44);
    [closeButton setImage:[Util imageNamedSmart:@"closeButton"] forState:UIControlStateNormal];
    [closeButton setImage:[Util imageNamedSmart:@"closeButton"] forState:UIControlStateSelected];
    [closeButton setImage:[Util imageNamedSmart:@"closeButton"] forState:UIControlStateHighlighted];
    closeButton.showsTouchWhenHighlighted = YES;
    [closeButton addTarget:self action:@selector(closeSearchHandler) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview: closeButton];
    
    //------------------------------ Scroll View ----------------------------------
    searchScrollView = [[UIScrollView alloc] init];
    //searchScrollView.pagingEnabled = YES;
    searchScrollView.backgroundColor = [UIColor clearColor];
    searchScrollView.delegate = self;
    
    [self.view addSubview: searchScrollView];
    
    
    tileH = 220; tileW = 170;
    [self setTiles: self.entries];
    
    searchBarView = [[UIView alloc] init];
    UIImageView *searchBarbackgroundView = [[UIImageView alloc] initWithImage:[Util imageNamedSmart:@"searchBarBg"]];
    [searchBarView addSubview:searchBarbackgroundView];
    [searchBarView sendSubviewToBack: searchBarbackgroundView];
    [self.view addSubview: searchBarView];
    
    CGRect frame = CGRectMake(70, 13, 340, 30);
    searchTextField = [[UITextField alloc] initWithFrame:frame];
    searchTextField.textColor = [UIColor whiteColor];
    searchTextField.font = [UIFont systemFontOfSize:17.0];
    searchTextField.placeholder = @"Search Joomag Store";
    searchTextField.backgroundColor = [UIColor clearColor];
    searchTextField.autocorrectionType = UITextAutocorrectionTypeYes;
    searchTextField.keyboardType = UIKeyboardTypeDefault;
    searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchTextField.delegate = self;
    
    [searchBarView addSubview:searchTextField];
    
    UIButton *closeSearchBarBtn =  [[UIButton alloc] initWithFrame:CGRectMake(470-53, 0, 53, 53)];
    [closeSearchBarBtn addTarget:self  action:@selector(closeSearchBar) forControlEvents:UIControlEventTouchDown];
    [closeSearchBarBtn setBackgroundImage: [Util imageNamedSmart:@"searchBarClose"] forState:UIControlStateNormal];
    
    [searchBarView addSubview: closeSearchBarBtn];
}

- (void)viewDidLayoutSubviews {
    iOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (iOrientation == UIDeviceOrientationPortrait) {
        searchBarViewFrame = CGRectMake(149, 90, 470, 53);
        searchScrollViewFrame = CGRectMake(60, 46, 648, 840);
    } else {
        searchBarViewFrame = CGRectMake(277, 90, 470, 53);
        searchScrollViewFrame = CGRectMake(70, 46, 884, 640);
    }
    
    searchBarView.frame = searchBarViewFrame;
    searchScrollView.frame = searchScrollViewFrame;
}

// -------------------------------------------------------------------------------
// setTilesWithArray: tileWidth: andHeight:
// Set the images in scroll view
// -------------------------------------------------------------------------------
- (void)setTiles: (NSArray *)arr {
    
    int xPosition = 0;
    int yPosition = 10;
    
    for (int i = 0; i < arr.count; i++) {
        /*
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(xPosition, yPosition, tileW, tileH)];
        imageView.image = [UIImage imageNamed:@"placeholder.png"];
        imageView.tag = i+1;
        
        [searchScrollView addSubview:imageView];
        */
        
        MagazinRecord * mRec = [[MagazinRecord alloc] init];
        mRec = [self.entries objectAtIndex: i];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(xPosition, yPosition, tileW, tileH)];
        imageView.userInteractionEnabled = YES;
        imageView.tag = mRec.magazineID;
        [imageView setImageWithURL: [NSURL URLWithString: mRec.magazinDetailsImageURL] placeholderImage: nil options:SDWebImageProgressiveDownload];
        
        [searchScrollView addSubview: imageView];
        
        UITapGestureRecognizer *tapOnImageView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnImage:)];
        tapOnImageView.delegate = self;
        [imageView addGestureRecognizer: tapOnImageView];
        
        xPosition = xPosition + tileW + 70;
        
        if(xPosition >= ((iOrientation == UIDeviceOrientationPortrait) ? 650 : 800)){
            xPosition = 0;
            yPosition = yPosition + tileH + 50;
        }
    }
    
    // Set up the content size of the scroll view for IPHONE
    searchScrollView.contentSize = CGSizeMake(searchScrollView.frame.size.width, yPosition+tileH);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [self reloadScroll];
    NSArray *arr = [self searchMagazineByText: textField.text];
    [self setTiles: arr];
    
    return YES;
}

- (NSArray *)searchMagazineByText: (NSString *)textStr {
    
    for (int i = 0; i < entriesLength; i++) {
        if ([((MagazinRecord *)[self.entries objectAtIndex: i]).magazinTitle rangeOfString: textStr options:NSCaseInsensitiveSearch].location == NSNotFound) {
        } else {
            [self.workingArray addObject: ((MagazinRecord *)[self.entries objectAtIndex: i])];
        }
    }
    
    NSArray *result = [NSArray arrayWithArray: self.workingArray];
    [self.workingArray removeAllObjects];
    
    return result;
}

// -------------------------------------------------------------------------------
//	reloadScroll
// -------------------------------------------------------------------------------
- (void)reloadScroll {
    for (UIImageView *subview in [searchScrollView subviews]) {
        if([subview isKindOfClass:[UIImageView class]]) {
            [subview removeFromSuperview];
        }
    }
}


// -------------------------------------------------------------------------------
//	currentPage:
//  return current page by offset x
// -------------------------------------------------------------------------------
- (int)currentPage: (float)offsetX {
    return (int)floor((offsetX * 2.0f + searchScrollView.frame.size.width) / (searchScrollView.frame.size.width * 2.0f));
}

// -------------------------------------------------------------------------------
//	currentPage:
//  return frame by current page
// -------------------------------------------------------------------------------
- (CGRect)currentFrame: (NSInteger)page {
    CGRect frame = searchScrollView.bounds;
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

- (void)closeSearchBar {
    [self reloadScroll];
    [self setTiles: dataHolder.testData];
    searchTextField.text = @"";
}


- (void)tapOnImage:(UITapGestureRecognizer *)gesture {
    UIImageView *imageView = (UIImageView *)gesture.view;
    ReadViewController *readVC = [[ReadViewController alloc] init];
    [readVC hitPageDescriptionWithMagazineId:imageView.tag];
    
    [UIView transitionWithView: self.navigationController.view duration:1 options:[Util getFlipAnimationType] animations:nil completion:nil];
    
    [self.navigationController pushViewController: readVC animated: NO];
}

- (void)closeSearchHandler {
    [UIView transitionWithView: self.navigationController.view duration:1 options:[Util getFlipAnimationType] animations:nil completion:nil];
    [self.navigationController popViewControllerAnimated: NO];
}

#pragma mark - UIScrollViewDelegate

// -------------------------------------------------------------------------------
//	scrollViewDidEndDecelerating:
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

// -------------------------------------------------------------------------------
// scrollViewDidScroll:
// any offset changes. Load the pages which are now on screen
// -------------------------------------------------------------------------------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //self.currentPage = [self currentPage:self.contentOffset.x];
}



@end
