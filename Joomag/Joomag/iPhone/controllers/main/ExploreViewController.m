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

@interface ExploreViewController () {
    MainDataHolder *dataHolder;
    UILabel        *label1;
    UILabel        *label2;
    UILabel        *label3;
    UIView         *border;
}

@end

@implementation ExploreViewController

- (void)loadView {
    [super loadView];
    
    dataHolder = [MainDataHolder getInstance];
    
    ConnectionManager * connManager = [[ConnectionManager alloc] init];
    [connManager constrcutAndGetCategoriesTypesRequest: self];
    
    self.view.backgroundColor = RGBA(49, 49, 49, 1);
    
    //-------------------------------- Top Bar ------------------------------------
    topBar = [[UIView alloc] init];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topTabBarBg.png"]];
    [topBar addSubview:backgroundView];
    [topBar sendSubviewToBack: backgroundView];
    [self.view addSubview: topBar];
    
    //-------------------------------- Top Bar Title ------------------------------------
    topBarTitleLabel = [[UILabel alloc] init];
    topBarTitleLabel.backgroundColor = [UIColor clearColor];
    topBarTitleLabel.textColor = [UIColor whiteColor];
    topBarTitleLabel.text = @"Magazines";
    
    [topBar addSubview: topBarTitleLabel];
    
    //-------------------------------- Search Botton ------------------------------------
    searchBtn = [[UIButton alloc] init];
    [searchBtn addTarget:self  action:@selector(searchHandler) forControlEvents:UIControlEventTouchDown];
    [searchBtn setBackgroundImage: [Util imageNamedSmart:@"searchIconeTopBar"] forState:UIControlStateNormal];
    searchBtn.showsTouchWhenHighlighted = YES;
    [topBar addSubview: searchBtn];
    
    //---------------------------- Page Control ------------------------------------
    pageControl = [[UIPageControl alloc] init];
    pageControl.currentPage = 0;
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview: pageControl];
    
    
    //---------------------------- Scroll View ------------------------------------
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        scrollView = [[ExploreScrollView alloc] initWithFrame:CGRectMake(15, 50, 320, 390)];
        pageControl.numberOfPages = 3;
    } else {
        scrollView = [[ExploreScrollView alloc] initWithFrame:CGRectMake(70, 110, 720, 450)];
        pageControl.numberOfPages = 2;
    }
    
    scrollView.entries = dataHolder.testData;
    
    [self.view addSubview: scrollView];
    
    CGRect pageControlFrame = CGRectMake(0, scrollView.frame.size.height+30, 320, 30);
    pageControl.frame = pageControlFrame;
    
    //Notify When Page Changes
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePageControl2) name:@"updatePageControl2" object:nil];
    
    //----------------------------Title Labels With Border ------------------------
    titleLabels = [self titleLabelsWithBorder];
    
    [self.view addSubview:titleLabels];
    
    
    //--------------------------- Categories Table -----------------------------
    categoriesTable = [[ExploreTableView alloc] init];
    
    [self.view addSubview: categoriesTable];
}



- (void) redrawData {
    if([dataHolder.testData count] != 0) {
        scrollView.entries = dataHolder.testData;
        [scrollView redrawData];
    }
}

- (UIView *)titleLabelsWithBorder {
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(20, 10, 280, 30)];
    
    label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 88, 20)]; label1.text = @"FEATURED";
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(92, 0, 80, 20)]; label2.text = @"POPULAR";
    label3 = [[UILabel alloc] initWithFrame:CGRectMake(175, 0, 81, 20)]; label3.text = @"NEW ARRIVALS";
    
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


-(void)titleLabelTapHandler :(id) sender
{
    UITapGestureRecognizer *gesture = (UITapGestureRecognizer *) sender;
    
    if (gesture.view.tag == 0) {
        [self animateLabelBorder: label1];
    } else if(gesture.view.tag == 1){
        [self animateLabelBorder: label2];
    } else if(gesture.view.tag == 2) {
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
    
}

- (void) didFinishResponse: (id) responseObject {
    dataHolder = [MainDataHolder getInstance];
    [categoriesTable reloadExploreTable];
    // NSLog(@"dataHolder: %@", dataHolder.categoriesList);
}

@end
