//
//  ExploreViewController.m
//  Joomag
//
//  Created by Armen Abrahamyan on 7/19/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "ExploreViewController.h"
#import "Util.h"
#import "MainDataHolder.h"
#import "SearchViewController.h"
#import "ConnectionManager.h"
#import "MagazinRecord.h"
#import "ReadViewController.h"

#define TOP_VIEW_HEIGHT 44
#define NAV_SCROLL_HEIGHT 130

@interface ExploreViewController () {
    MainDataHolder *dataHolder;
    UILabel        *label1;
    UILabel        *label2;
    UILabel        *label3;
    UIView         *border;
    
    int hierarchy;
}

@end

@implementation ExploreViewController

- (void) backAction {
    if(hierarchy > 0) {
        scrollView.entries = firstBreadCrumbData;
        [scrollView redrawData];
        [categoriesTable reloadExploreTable];
        hierarchy--;
        secondBreadCrumb.text=@"";
        det.hidden = YES;
        scrollView.hidden = NO;
        pageControl.hidden = NO;
        categoriesTable.hidden = NO;
    } else if (hierarchy == 0) {
        label1.hidden = NO;
        label2.hidden = NO;
        label3.hidden = NO;
        border.hidden = NO;
        
        ConnectionManager * connManager = [[ConnectionManager alloc] init];
        [connManager constructGetMagazinesListRequest:self:@"featured":nil:nil:nil];
    }
}

- (void) loadView {
    [super loadView];
    hierarchy = 0;
    dataHolder = [MainDataHolder getInstance];
    
    ConnectionManager * connManager = [[ConnectionManager alloc] init];
    [connManager constrcutAndGetCategoriesTypesRequest: self];
    
    self.view.backgroundColor = RGBA(49, 49, 49, 1);
    
    //-------------------------------- Top Bar ------------------------------------
    topBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topTabBarBg.png"]];
    [topBar addSubview:backgroundView];
    [topBar sendSubviewToBack: backgroundView];
    [self.view addSubview: topBar];
    
    //-------------------------------- Top Bar Title ------------------------------------
    topBarTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 170, 44)];
    topBarTitleLabel.backgroundColor = [UIColor clearColor];
    topBarTitleLabel.textColor = [UIColor whiteColor];
    topBarTitleLabel.text = @"Magazines";
    
    [topBar addSubview: topBarTitleLabel];
    
    firstBreadCrumb = [[UILabel alloc] init];
    firstBreadCrumb.font = [UIFont fontWithName:@"proximanovaregular" size:20.0f];
    firstBreadCrumb.backgroundColor = [UIColor clearColor];
    firstBreadCrumb.textColor = [UIColor whiteColor];
    firstBreadCrumb.text = @"";
    
    [topBar addSubview: firstBreadCrumb];
    
    secondBreadCrumb = [[UILabel alloc] init];
    firstBreadCrumb.font = [UIFont fontWithName:@"proximanovaregular" size:20.0f];
    secondBreadCrumb.backgroundColor = [UIColor clearColor];
    secondBreadCrumb.textColor = [UIColor whiteColor];
    secondBreadCrumb.text = @"";
    
    [topBar addSubview: secondBreadCrumb];
    
    //-------------------------------- Search Botton ------------------------------------
    searchBtn = [[UIButton alloc] init];
    [searchBtn addTarget:self  action:@selector(searchHandler) forControlEvents:UIControlEventTouchDown];
    [searchBtn setBackgroundImage: [Util imageNamedSmart:@"searchIconeTopBar"] forState:UIControlStateNormal];
    searchBtn.showsTouchWhenHighlighted = YES;
    [topBar addSubview: searchBtn];
    
    backButtonView = [UIButton buttonWithType:UIButtonTypeCustom];
    backButtonView.frame = CGRectMake(0, 0, TOP_VIEW_HEIGHT, TOP_VIEW_HEIGHT);  //TODO
    [backButtonView setBackgroundImage:[Util imageNamedSmart:@"backButton"] forState:UIControlStateNormal];
    //[backButtonView setBackgroundImage:[Util imageNamedSmart:@"backButton"] forState:UIControlStateSelected];
    //[backButtonView setBackgroundImage:[Util imageNamedSmart:@"backButton"] forState:UIControlStateHighlighted];
    backButtonView.showsTouchWhenHighlighted = YES;
    [backButtonView addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    // backButtonView.hidden = YES;
    
    [topBar addSubview: backButtonView];

    //---------------------------- Scroll View ------------------------------------
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        scrollView = [[ExploreScrollView alloc] initWithFrame:CGRectMake(15, 100, 320, 180)];
    } else {
        scrollView = [[ExploreScrollView alloc] initWithFrame:CGRectMake(70, 130, 720, 450)];
    }
    
    scrollView.exploreDelegate = self;
    scrollView.entries = dataHolder.testData;
    
    [self.view addSubview: scrollView];
    
    //Notify When Page Changes
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePageControl2) name:@"updatePageControl2" object:nil];
    
    //----------------------------Title Labels With Border ------------------------
    titleLabels = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 320, 44)];
    [titleLabels addSubview: [self titleLabelsWithBorder]];
    titleLabels.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:titleLabels];
    
    
    //--------------------------- Categories Table -----------------------------
    if(IS_IPHONE_5) {
        categoriesTable = [[ExploreTableView alloc] initWithFrame: CGRectMake(0, self.view.frame.size.height-245, 320, 200)];
    } else {
        categoriesTable = [[ExploreTableView alloc] initWithFrame: CGRectMake(0, self.view.frame.size.height-157, 320, 112)];
    }
    categoriesTable.callbacker = self;
    
    [self.view addSubview: categoriesTable];
}

- (void) redrawDataAndTopBar: (NSString *) breadcrumb withHierarchy : (NSInteger) hier {
    if([dataHolder.testData count] != 0) {
        if (hier == 0) {
            firstBreadCrumb.text = [NSString stringWithFormat:@"|  %@", breadcrumb];
//            firstBreadCrumb.frame = [Util calculateLabelFrame:firstBreadCrumb];
        } else if (hier > 0) {
            secondBreadCrumb.text = [NSString stringWithFormat:@"|  %@", breadcrumb];
//            secondBreadCrumb.frame = [Util calculateLabelFrame:firstBreadCrumb];                       
            
            scrollView.hidden = YES;
            pageControl.hidden = YES;
            label1.hidden = YES;
            label2.hidden = YES;
            label3.hidden = YES;
            border.hidden = YES;
            
            if(!det && !det.hidden)
                det = [[DetailsExploreScrollView alloc] initWithFrame:CGRectMake(10, 64, 300, 400)];
            else
                det.hidden = NO;
            det.entries = dataHolder.testData;
            
            [self.view addSubview:det];
            [det redrawData];
            
            hierarchy = hier;
        }
    }
}

- (void) setupScrollTableView {
    
}

- (void) redrawData {
    if([dataHolder.testData count] != 0) {
        if(hierarchy == 0) {
            scrollView.entries = dataHolder.testData;
            firstBreadCrumbData = dataHolder.testData;
            [scrollView redrawData];
            
            if(activityIndicator) {
                [activityIndicator removeFromSuperview];
                activityIndicator = nil;
            }
        } else {
            
        }
    }
}

- (UIView *)titleLabelsWithBorder {
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(15, 0, 290, 44)];

    label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 77, 44)]; label1.text = @"FEATURED";
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 69, 44)]; label2.text = @"POPULAR";
    label3 = [[UILabel alloc] initWithFrame:CGRectMake(190, 0, 98, 44)]; label3.text = @"HIGHLIGHTED";
    
    NSArray *labelArr = [NSArray arrayWithObjects:label1, label2, label3, nil];
    
    for (int i = 0; i < labelArr.count; i ++) {
        [container addSubview:[labelArr objectAtIndex:i]];
        
        ((UILabel *)[labelArr objectAtIndex:i]).backgroundColor = [UIColor clearColor];
        ((UILabel *)[labelArr objectAtIndex:i]).textColor = [UIColor whiteColor];
        ((UILabel *)[labelArr objectAtIndex:i]).font = [UIFont boldSystemFontOfSize:14.0];
        ((UILabel *)[labelArr objectAtIndex:i]).numberOfLines = 1;
        ((UILabel *)[labelArr objectAtIndex:i]).tag = i;
        ((UILabel *)[labelArr objectAtIndex:i]).userInteractionEnabled = YES;
        //[((UILabel *)[labelArr objectAtIndex:i]) sizeToFit];
        
        // Add Gesture Recognizer To Label
        UITapGestureRecognizer *labelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleLabelTapHandler:)];
        [((UILabel *)[labelArr objectAtIndex:i]) addGestureRecognizer: labelTap];
    }
    
    border = [[UIView alloc] initWithFrame:CGRectMake(0, 31, label1.frame.size.width, 2)];
    border.backgroundColor = [UIColor redColor];
    
    [container addSubview:border];
    
    return container;
}

- (void) bindArrayToMappingObject: (NSString *) magType {
    NSArray * list = nil;
    
    [[MainDataHolder getInstance].testData removeAllObjects];
    
    if([magType isEqualToString:@"featured"]) {
        list = [MainDataHolder getInstance].magazinesList;
    } else if ([magType isEqualToString:@"Popular"]) {
        list =  [MainDataHolder getInstance].popularMagList;
    } else if ([magType isEqualToString:@"Highlighted"]) {
        list =  [MainDataHolder getInstance].highlightedMagList;
    }
    
    for (int counter = 0; counter < [list count]; counter ++) {
        NSDictionary * currentMagazine = [list objectAtIndex:counter];
        
        if(currentMagazine) {
            MagazinRecord * mgRecord = [[MagazinRecord alloc] init];
            mgRecord.magazinTitle = [currentMagazine objectForKey:@"title"];
            mgRecord.magazinDate = [currentMagazine objectForKey:@"date"];
            mgRecord.magazinImageURL = [currentMagazine objectForKey:@"featured_spread"];
            mgRecord.magazinDetailsImageURL = [currentMagazine objectForKey:@"firstpage"];
            mgRecord.magazinDetailsText = [currentMagazine objectForKey:@"desc"];
            mgRecord.magazineID = [[currentMagazine objectForKey:@"ID"] intValue];
            
            [[MainDataHolder getInstance].testData addObject:mgRecord];
        }
    }
    
    [self redrawData];
}

- (void) createActivityIndicator {
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    if(UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
    
        activityIndicator.frame = CGRectMake(384, 512 + 120, activityIndicator.frame.size.width, activityIndicator.frame.size.height);
    } else {
        activityIndicator.frame = CGRectMake(512 - 65 ,384 - 25 , activityIndicator.frame.size.width, activityIndicator.frame.size.height);
    }
    
    [self.view addSubview:activityIndicator];
    [activityIndicator startAnimating];

}


-(void)titleLabelTapHandler :(id) sender {
    UITapGestureRecognizer *gesture = (UITapGestureRecognizer *) sender;
    
    ConnectionManager * connManager = [[ConnectionManager alloc] init];
    
    if (gesture.view.tag == 0) {
        
        if([[MainDataHolder getInstance].magazinesList count] == 0) {
           
            [self createActivityIndicator];
            
            [connManager constructGetMagazinesListRequest:self:@"featured":nil:nil:nil];
        } else {
            [self bindArrayToMappingObject:@"featured"];
            scrollView.entries = [MainDataHolder getInstance].testData;
        }
        
        [self animateLabelBorder: label1];
    } else if(gesture.view.tag == 1){
        
        if([[MainDataHolder getInstance].popularMagList count] == 0) {
           
            [self createActivityIndicator];
            
            [connManager constructGetMagazinesListRequest:self:@"Popular":nil:nil:nil];
        } else {
            [self bindArrayToMappingObject:@"Popular"];
            scrollView.entries = [MainDataHolder getInstance].testData;
        }
        
        [self animateLabelBorder: label2];
    } else if(gesture.view.tag == 2) {
        
        if([[MainDataHolder getInstance].highlightedMagList count] == 0) {
            [self createActivityIndicator];
            [connManager constructGetMagazinesListRequest:self:@"Highlighted":nil:nil:nil];
        } else {
            [self bindArrayToMappingObject:@"Highlighted"];
            scrollView.entries = [MainDataHolder getInstance].testData;
        }
        
        [self animateLabelBorder: label3];
    }
}

- (void) animateLabelBorder: (UILabel *)label {
    NSValue * from = [NSNumber numberWithFloat:border.layer.position.x];
    NSValue * to = [NSNumber numberWithFloat:label.layer.position.x];
    NSString * keypath = @"position.x";
    [border.layer addAnimation:[self animationFrom:from to:to forKeyPath:keypath withDuration:.2] forKey:@"bounce"];
    [border.layer setValue:to forKeyPath:keypath];
    
    CGRect frm = border.frame;
    frm.origin.x = label.frame.origin.x;
    frm.size.width = label.frame.size.width;
    border.frame = frm;
}

#pragma mark - CAAnimations

-(CABasicAnimation *)animationFrom:(NSValue *)from
                                to:(NSValue *)to
                        forKeyPath:(NSString *)keypath
                      withDuration:(CFTimeInterval)duration
{
    CABasicAnimation * result = [CABasicAnimation animationWithKeyPath:keypath];
    [result setFromValue:from];
    [result setToValue:to];
    [result setDuration:duration];
    
    return  result;
}

-(void)searchHandler {
    SearchViewController *serachVC = [[SearchViewController  alloc] init];
    
    [UIView transitionWithView: self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromBottom animations:nil completion:nil];
    
    [self.navigationController pushViewController:serachVC animated: NO];
}

// -------------------------------------------------------------------------------
// updatePageControl
// Update UIPageControl and show details view with current page
// -------------------------------------------------------------------------------
- (void)updatePageControl2 {
    pageControl.currentPage = scrollView.currentPage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (void)readHandlerWithMagazineId:(int)magazineId {
    NSLog(@"Make Request with magazine ID: %i", magazineId);
    ReadViewController *readVC = [[ReadViewController alloc] init];
    [readVC hitPageDescriptionWithMagazineId:magazineId];
    
    UIViewAnimationOptions animationType;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    if (screenHeight > screenWidth) {
        animationType = UIViewAnimationOptionTransitionFlipFromLeft;
    } else {
        animationType = UIViewAnimationOptionTransitionFlipFromBottom;
    }
    
    [UIView transitionWithView: self.navigationController.view duration:1 options:animationType animations:nil completion:nil];
    
    [self.navigationController pushViewController: readVC animated: NO];
}




#pragma Response Tracker Delegates ---

- (void) didFailResponse: (id) responseObject {
    NSLog(@"Failed getting Response !");
}

- (void) didFinishResponse: (id) responseObject {
    dataHolder = [MainDataHolder getInstance];
    
    scrollView.entries = dataHolder.testData;
    
    [scrollView setNeedsDisplay];
    
    [categoriesTable reloadExploreTable];
    [self redrawData];
    
    // NSLog(@"entries: %i", dataHolder.testData.count);
    
    //---------------------------- Page Control ------------------------------------
    if(pageControl && !pageControl.hidden) {
        pageControl = [[UIPageControl alloc] init];
        pageControl.currentPage = 0;
        pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        pageControl.pageIndicatorTintColor = [UIColor grayColor];
        pageControl.backgroundColor = [UIColor clearColor];
        CGRect pageControlFrame = CGRectMake(0, 270, 320, 30);
        pageControl.frame = pageControlFrame;
    } else {
        pageControl.hidden = NO;
    }
    
    if (IS_IPAD) { //TODO: page numbers
        pageControl.numberOfPages = 2;
    } else {
        
        NSInteger numberOfItems = [dataHolder.testData count];
        
        if (numberOfItems % 2) { //odd
        } else {
            numberOfItems = numberOfItems/2;
        }
        
        pageControl.numberOfPages = 4;
    }
    
    [self.view addSubview: pageControl];
}

- (void) viewWillLayoutSubviews {    
    
    if (IS_IPAD) {
        if([categoriesTable.data count] > 0) {
            [categoriesTable removeFromSuperview];
            categoriesTable = nil;
            categoriesTable = [[ExploreTableView alloc] init];
            
            categoriesTable.callbacker = self;
            [self.view addSubview: categoriesTable];
            
            categoriesTable.data = [MainDataHolder getInstance].categoriesList;
            
            [categoriesTable reloadData];
        }
    }
}

@end
