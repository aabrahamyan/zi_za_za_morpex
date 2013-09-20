//
//  CustomTabBarController.m
//  Joomag
//
//  Created by Armen Abrahamyan on 8/7/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "CustomTabBarController.h"
#import "SettingsViewController.h"
#import "BookMarkViewController.h"
#import "AppDelegate.h"
#import "ExploreViewController.h"
#import "FeaturedViewController.h"
#import "LibraryViewController.h"
#import "MoreViewController.h"
#import "Util.h"

@interface CustomTabBarController ()

@end

@implementation CustomTabBarController

static CustomTabBarController * customTabBarController; 

- (id) initWithSpecifics: (UIImage * ) bgImage withWidth: (CGFloat) width withHeight: (CGFloat) height {
    
    if((self=[super init])) {
        if(bgImage) {
            self.bgImage = bgImage;
        }
        
        if(width != -1.0 && height != -1.0) {
            self.width = width;
            self.height = height; 
        }
    }
    
    return self;
}

+ (CustomTabBarController *) getInstance:(UIImage *) bgImage withWidth: (CGFloat) width withHeight: (CGFloat) height {

    if(customTabBarController == nil) {
        customTabBarController = [[CustomTabBarController alloc] initWithSpecifics:bgImage withWidth:width withHeight:height];        
    } 
    
    return customTabBarController;
    
}

- (SettingsViewController *) getSettingsViewController {
    return [[SettingsViewController alloc] init];
}

- (BookMarkViewController *) getBookMarksViewController {
    return [[BookMarkViewController alloc] init];
}

- (FeaturedViewController *) getFeaturedViewController {
    return [[FeaturedViewController alloc] init];
}

- (ExploreViewController *) getExploreViewController {
    return [[ExploreViewController alloc] init];
}

- (LibraryViewController *) getLibraryViewController {
    return [[LibraryViewController alloc] init];
}


- (void) createTabBarContent {
    FeaturedViewController * featuredVC = [self getFeaturedViewController];
    ExploreViewController * exploreVC = [self getExploreViewController];
    LibraryViewController * libraryVC = [self getLibraryViewController];
    
    self.featuredNavigationController = [[UINavigationController alloc] initWithRootViewController:featuredVC];
    self.featuredNavigationController.view.frame = CGRectMake(0, -20, 320, 568);
    
    NSLog(@"nav y: %f",self.featuredNavigationController.view.frame.origin.y);
    
    self.featuredNavigationController.navigationBarHidden = YES;

    self.exploreNavigationController = [[UINavigationController alloc] initWithRootViewController:exploreVC];
    self.exploreNavigationController.navigationBarHidden = YES;
    
    self.exploreNavigationController.view.hidden = YES;
    self.myBookshelfNavigationController = [[UINavigationController alloc] initWithRootViewController:libraryVC];
    
    self.myBookshelfNavigationController.navigationBarHidden = YES;
    self.myBookshelfNavigationController.view.hidden = YES;
    
    [self.view addSubview:self.featuredNavigationController.view];
    [self.view addSubview:self.exploreNavigationController.view];
    [self.view addSubview:self.myBookshelfNavigationController.view];
}

- (void) loadView {
    [super loadView];
    
    self.view.frame = CGRectMake(0, 0, 320, 568);
    NSLog(@"%@", NSStringFromCGRect(self.view.frame));
    
    
    self.backGroundView = [[UIImageView alloc] initWithImage:self.bgImage];
    self.view.userInteractionEnabled = YES;
    self.backGroundView.userInteractionEnabled = YES;
    
    if (IS_IPHONE_5)
        self.backGroundView.frame = CGRectMake(0, 503, 320, 45);
    else
        self.backGroundView.frame = CGRectMake(0, 400, 320, 45);
    
    [self.view addSubview:self.backGroundView];
    
    [self createTabBarContent];
    
    self.featuredButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 1, 73, 45)];
    [self.featuredButton setImage: [Util imageNamedSmart:@"barFeatured"] forState:UIControlStateNormal];
    [self.featuredButton setImage: [Util imageNamedSmart:@"barFeatured"] forState:UIControlStateSelected];
    [self.featuredButton setImage: [Util imageNamedSmart:@"barFeatured"] forState:UIControlStateHighlighted];
    self.featuredButton.showsTouchWhenHighlighted = YES;
    self.featuredButton.tag = 11111;
    
    [self.featuredButton addTarget:self action:@selector(toggleTabs:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backGroundView addSubview:self.featuredButton];
    
    
    self.exploreButton = [[UIButton alloc] initWithFrame:CGRectMake(85, 2, 73, 45)];
    [self.exploreButton setImage: [Util imageNamedSmart:@"barExplore"] forState:UIControlStateNormal];
    [self.exploreButton setImage: [Util imageNamedSmart:@"barExplore"] forState:UIControlStateSelected];
    [self.exploreButton setImage: [Util imageNamedSmart:@"barExplore"] forState:UIControlStateHighlighted];
    self.exploreButton.showsTouchWhenHighlighted = YES;
    self.exploreButton.tag = 22222;
    
    [self.exploreButton addTarget:self action:@selector(toggleTabs:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backGroundView addSubview:self.exploreButton];
    
    
    self.myLibButton = [[UIButton alloc] initWithFrame:CGRectMake(170, 2, 73, 45)];
    [self.myLibButton setImage: [Util imageNamedSmart:@"barMyLib"] forState:UIControlStateNormal];
    [self.myLibButton setImage: [Util imageNamedSmart:@"barMyLib"] forState:UIControlStateSelected];
    [self.myLibButton setImage: [Util imageNamedSmart:@"barMyLib"] forState:UIControlStateHighlighted];
    self.myLibButton.showsTouchWhenHighlighted = YES;
    self.myLibButton.tag = 33333;
    
    [self.myLibButton addTarget:self action:@selector(toggleTabs:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backGroundView addSubview:self.myLibButton];
    
    self.moreButton = [[UIButton alloc] initWithFrame:CGRectMake(240, 3, 73, 45)];
    [self.moreButton setImage: [Util imageNamedSmart:@"barMore"] forState:UIControlStateNormal];
    [self.moreButton setImage: [Util imageNamedSmart:@"barMore"] forState:UIControlStateSelected];
    [self.moreButton setImage: [Util imageNamedSmart:@"barMore"] forState:UIControlStateHighlighted];
    self.moreButton.showsTouchWhenHighlighted = YES;
    
    [self.moreButton addTarget:self action:@selector(showMore) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backGroundView addSubview:self.moreButton];
    
    self.gearButton = [[UIButton alloc] init];
    [self.gearButton setImage: [Util imageNamedSmart:@"barGear"] forState:UIControlStateNormal];
    [self.gearButton setImage: [Util imageNamedSmart:@"barGear"] forState:UIControlStateSelected];
    [self.gearButton setImage: [Util imageNamedSmart:@"barGear"] forState:UIControlStateHighlighted];
    self.gearButton.showsTouchWhenHighlighted = YES;
    [self.gearButton addTarget:self action:@selector(showSettings) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backGroundView addSubview:self.gearButton];
    
    
    self.noteButton = [[UIButton alloc] init];
    [self.noteButton setImage:[Util imageNamedSmart:@"barBookMark"] forState:UIControlStateNormal];
    [self.noteButton setImage:[Util imageNamedSmart:@"barBookMark"] forState:UIControlStateSelected];
    [self.noteButton setImage:[Util imageNamedSmart:@"barBookMark"] forState:UIControlStateHighlighted];
    
    self.noteButton.showsTouchWhenHighlighted = YES;
    [self.noteButton addTarget:self action:@selector(showBookMarks) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backGroundView addSubview:self.noteButton];
    
    [self.view bringSubviewToFront:self.backGroundView];
}

- (void) toggleTabs: (id) target {
    
    NSInteger targetId = ((UIButton *)target).tag;
    
    switch (targetId) {
        case 11111: {
            
            self.featuredNavigationController.view.hidden = NO;
            self.exploreNavigationController.view.hidden = YES;            
            self.myBookshelfNavigationController.view.hidden = YES;
            
            break;
        }
        case 22222: {
            self.featuredNavigationController.view.hidden = YES;
            self.exploreNavigationController.view.hidden = NO;
            ExploreViewController * vc =  (ExploreViewController *)self.exploreNavigationController.visibleViewController;
            [vc redrawData];
            self.myBookshelfNavigationController.view.hidden = YES;
            
            break;
        }
        case 33333: {
            self.featuredNavigationController.view.hidden = YES;
            self.exploreNavigationController.view.hidden = YES;
            self.myBookshelfNavigationController.view.hidden = NO;
            
            break;
        }
        default:
            break;
    }
}

- (void)viewDidLayoutSubviews {
    // NSLog(@"LAYOUT ORIENTATION CHANGED");
}

- (void) showMore {
    self.moreVC = [[MoreViewController alloc] init];
    
    if (IS_IPHONE_5)
        self.moreVC.view.frame = CGRectMake(0, 0, 320, 483);
    else
        self.moreVC.view.frame = CGRectMake(0, 0, 320, 400);
    
    [self.view addSubview: self.moreVC.view];
    
    [self.moreVC animateUpAndDown:YES];
}

- (void) showSettings {
    self.settingsVC = [self getSettingsViewController];

    [self.view addSubview: self.settingsVC.view];
    
    [self.settingsVC animateUpAndDown:YES];
   
}

- (void) showBookMarks {
    self.bookMarksVC = [self getBookMarksViewController];
    
    [self.view addSubview: self.bookMarksVC.view];
    
    [self.bookMarksVC animateUpAndDown:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
