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
#import "DetailsExploreScrollView.h"

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

- (void)loadView {
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
    topBarTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 170, 44)];
    topBarTitleLabel.backgroundColor = [UIColor clearColor];
    topBarTitleLabel.textColor = [UIColor whiteColor];
    topBarTitleLabel.text = @"Magazines";
    
    [topBar addSubview: topBarTitleLabel];
    
    firstBreadCrumb = [[UILabel alloc] init];
    firstBreadCrumb.backgroundColor = [UIColor clearColor];
    firstBreadCrumb.textColor = [UIColor whiteColor];
    firstBreadCrumb.text = @"";
    
    [topBar addSubview: firstBreadCrumb];
    
    secondBreadCrumb = [[UILabel alloc] init];
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

    
    //---------------------------- Scroll View ------------------------------------
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        scrollView = [[ExploreScrollView alloc] initWithFrame:CGRectMake(15, 100, 320, 180)];
    } else {
        scrollView = [[ExploreScrollView alloc] initWithFrame:CGRectMake(70, 130, 720, 450)];
    }
    
    scrollView.entries = dataHolder.testData;
    
    [self.view addSubview: scrollView];
    
    //Notify When Page Changes
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePageControl2) name:@"updatePageControl2" object:nil];
    
    //----------------------------Title Labels With Border ------------------------
    titleLabels = [self titleLabelsWithBorder];
    
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
        } else if (hier > 0) {
            secondBreadCrumb.text = [NSString stringWithFormat:@"|  %@", breadcrumb];
            scrollView.hidden = YES;
            pageControl.hidden = YES;
            label1.hidden = YES;
            label2.hidden = YES;
            label3.hidden = YES;
            border.hidden = YES;
            
            det = [[DetailsExploreScrollView alloc] initWithFrame:CGRectMake(67, 111, 877, 594)];
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
            [scrollView redrawData];
        } else {
            
        }
    }
}

- (UIView *)titleLabelsWithBorder {
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(20, 60, 280, 30)];
    
    label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 88, 20)]; label1.text = @"FEATURED";
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 80, 20)]; label2.text = @"POPULAR";
    label3 = [[UILabel alloc] initWithFrame:CGRectMake(185, 0, 81, 20)]; label3.text = @"HIGHLIGHTED";
    
    NSArray *labelArr = [NSArray arrayWithObjects:label1, label2, label3, nil];
    
    for (int i = 0; i < labelArr.count; i ++) {
        [container addSubview:[labelArr objectAtIndex:i]];
        
        ((UILabel *)[labelArr objectAtIndex:i]).backgroundColor = [UIColor clearColor];
        ((UILabel *)[labelArr objectAtIndex:i]).textColor = [UIColor whiteColor];
        ((UILabel *)[labelArr objectAtIndex:i]).font = [UIFont boldSystemFontOfSize:14.0];
        ((UILabel *)[labelArr objectAtIndex:i]).numberOfLines = 1;
        ((UILabel *)[labelArr objectAtIndex:i]).tag = i;
        ((UILabel *)[labelArr objectAtIndex:i]).userInteractionEnabled = YES;
        [((UILabel *)[labelArr objectAtIndex:i]) sizeToFit];
        
        // Add Gesture Recognizer To Label
        UITapGestureRecognizer *labelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleLabelTapHandler:)];
        [((UILabel *)[labelArr objectAtIndex:i]) addGestureRecognizer: labelTap];
    }
    
    border = [[UIView alloc] initWithFrame:CGRectMake(0, 20, label1.frame.size.width, 2)];
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
}


-(void)titleLabelTapHandler :(id) sender {
    UITapGestureRecognizer *gesture = (UITapGestureRecognizer *) sender;
    
    ConnectionManager * connManager = [[ConnectionManager alloc] init];
    
    if (gesture.view.tag == 0) {
        
        if([[MainDataHolder getInstance].magazinesList count] == 0) {
            [connManager constructGetMagazinesListRequest:self:@"featured":nil:nil:nil];
        } else {
            [self bindArrayToMappingObject:@"featured"];
            scrollView.entries = [MainDataHolder getInstance].testData;
        }
        
        [self animateLabelBorder: label1];
    } else if(gesture.view.tag == 1){
        
        if([[MainDataHolder getInstance].popularMagList count] == 0) {
            [connManager constructGetMagazinesListRequest:self:@"Popular":nil:nil:nil];
        } else {
            [self bindArrayToMappingObject:@"Popular"];
            scrollView.entries = [MainDataHolder getInstance].testData;
        }
        
        [self animateLabelBorder: label2];
    } else if(gesture.view.tag == 2) {
        
        if([[MainDataHolder getInstance].highlightedMagList count] == 0) {
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
    
    NSLog(@"entries: %i", dataHolder.testData.count);
    
    //---------------------------- Page Control ------------------------------------
    pageControl = [[UIPageControl alloc] init];
    pageControl.currentPage = 0;
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.backgroundColor = [UIColor clearColor];
    CGRect pageControlFrame = CGRectMake(0, 270, 320, 30);
    pageControl.frame = pageControlFrame;
    
    if (IS_IPAD) {
        pageControl.numberOfPages = 2;
    } else {
        
        NSInteger numberOfItems = [dataHolder.testData count];
        
        if (numberOfItems % 2) { //odd
            NSLog(@"pagecontroll odd: %i", numberOfItems/2);
        } else {
            NSLog(@"pagecontroll even: %i", numberOfItems/2);
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
