//
//  SearchViewController.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-08-18.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "SearchViewController.h"
#import "DataHolder.h"
#import "Util.h"
#import "MagazinRecord.h"
#import "ImageDownloader.h"

@interface SearchViewController () {
    DataHolder *dataHolder;
    NSInteger entriesLength;
    UITextField *searchTextField;
    NSArray *arrSerach;
    int tileW;
    int tileH;
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
        dataHolder = [[DataHolder alloc] init];
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
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, dataHolder.screenWidth, 44)];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchTopBarBg.png"]];
    [topView addSubview:backgroundView];
    [topView sendSubviewToBack: backgroundView];
    [self.view addSubview: topView];
    
    //-------------------------- Close Search Botton -------`----------------------
    closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 46, 44)];
    [closeButton addTarget:self  action:@selector(closeSearch) forControlEvents:UIControlEventTouchDown];
    [closeButton setBackgroundImage: [Util imageNamedSmart:@"searchTabBarClose"] forState:UIControlStateNormal];
    [topView addSubview: closeButton];
    
    //------------------------------ Scroll View ----------------------------------
    searchScrollView = [[UIScrollView alloc] init];
    searchScrollView.frame = CGRectMake(70, 46, 884, 640); // TODO
    //searchScrollView.pagingEnabled = YES;
    searchScrollView.backgroundColor = [UIColor clearColor];
    searchScrollView.delegate = self;
    
    [self.view addSubview: searchScrollView];
    
    
    tileH = 220; tileW = 170; //TODO
    [self setTiles: self.entries];
    
    searchBarView = [[UIView alloc] initWithFrame:CGRectMake(277, 90, 470, 53)];
    UIImageView *searchBarbackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchBarBg.png"]];
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
    
    [self loadMagazines: self.entries];
}

// -------------------------------------------------------------------------------
// setTilesWithArray: tileWidth: andHeight:
// Set the images in scroll view
// -------------------------------------------------------------------------------
- (void)setTiles: (NSArray *)arr {
    
    int xPosition = 0;
    int yPosition = 10;
    
    for (int i = 0; i < arr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(xPosition, yPosition, tileW, tileH)];
        imageView.image = [UIImage imageNamed:@"placeholder.png"];
        imageView.tag = i+1;
        
        [searchScrollView addSubview:imageView];
        
        xPosition = xPosition + tileW + 70;
        
        if(xPosition >= 800){
            xPosition = 0;
            yPosition = yPosition + tileH + 50;
        }
    }
    
    // Set up the content size of the scroll view for IPHONE
    searchScrollView.contentSize = CGSizeMake(searchScrollView.frame.size.width, yPosition+tileH);
}

// -------------------------------------------------------------------------------
// loadPage:
// Load an individual page
// -------------------------------------------------------------------------------
- (void)loadMagazines: (NSArray *)arr {
    for (UIImageView *subview in [searchScrollView subviews]) {
        if (subview.tag != 0) {
            // Load an individual page, first seeing if we've already loaded it
            MagazinRecord *mRecord = [arr objectAtIndex:subview.tag-1];
            if (!mRecord.magazinDetailsIcon) {
                // NSLog(@"index: %i",subview.tag);
                [self startIconDownload:mRecord forIndexPath:subview.tag-1];
            } else {
                subview.image = mRecord.magazinDetailsIcon;
            }
        }
    }
}

// -------------------------------------------------------------------------------
//	startIconDownload:forIndexPath:
// -------------------------------------------------------------------------------
- (void)startIconDownload:(MagazinRecord *)magazinRecord forIndexPath:(NSInteger)page {
    NSNumber *indexP = [NSNumber numberWithInteger:page];
    
    //NSLog(@"imageview: %i",page);
    
    ImageDownloader *imageDownloader = [self.imageDownloadsInProgress objectForKey:indexP];
    
    if (imageDownloader == nil) {
        
        imageDownloader = [[ImageDownloader alloc] init];
        imageDownloader.magazinRecord = magazinRecord;
        
        [imageDownloader setCompletionHandler:^{
            //NSLog(@"Download Image: %i",page);
            ((UIImageView *)[[searchScrollView subviews] objectAtIndex:page]).image = magazinRecord.magazinDetailsIcon;
            [self setShadow:((UIImageView *)[[searchScrollView subviews] objectAtIndex:page])];
        }];
        
        [self.imageDownloadsInProgress setObject:imageDownloader forKey:indexP];
        [imageDownloader startDownloadDetailsImageWithImageView:((UIImageView *)[[searchScrollView subviews] objectAtIndex:page])];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [self reloadScroll];
    NSArray *arr = [self searchMagazineByText: textField.text];
    //NSLog(@"arr: %@", arr);
    
    [self setTiles: arr];
    [self loadMagazines: arr];
    
    return YES;
}

- (NSArray *)searchMagazineByText: (NSString *)textStr {
    
    for (int i = 0; i < entriesLength; i++) {
        // [textStr isEqualToString: ((MagazinRecord *)[self.entries objectAtIndex: i]).magazinTitle]
        
        if ([textStr rangeOfString: ((MagazinRecord *)[self.entries objectAtIndex: i]).magazinTitle options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
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

- (void)closeSearch {
    [UIView transitionWithView: self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromTop animations:nil completion:nil];
    [self.navigationController popViewControllerAnimated: NO];
}

- (void)closeSearchBar {
    NSLog(@"close search bar");
}

@end
