//
//  CustomTabBarController.m
//  Joomag
//
//  Created by Armen Abrahamyan on 8/7/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "CustomTabBarController.h"
#import "SettingsViewController_iPad.h"
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

+ (CustomTabBarController *) getInstance {
    return customTabBarController;
}

+ (CustomTabBarController *) getInstance:(UIImage *) bgImage withWidth: (CGFloat) width withHeight: (CGFloat) height {

    if(customTabBarController == nil) {
        customTabBarController = [[CustomTabBarController alloc] initWithSpecifics:bgImage withWidth:width withHeight:height];        
    } 
    
    return customTabBarController;
    
}

- (SettingsViewController_iPad *) getSettingsViewController {
    return [[SettingsViewController_iPad alloc] init];
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

- (MoreViewController *) getMoreViewController {
    return [[MoreViewController alloc] init];
}


- (void) createTabBarContent {
    FeaturedViewController * featuredVC = [self getFeaturedViewController];
    ExploreViewController  * exploreVC = [self getExploreViewController];
    LibraryViewController  * libraryVC = [self getLibraryViewController];
    MoreViewController     * moreVC = [self getMoreViewController];
    
    self.featuredNavigationController = [[UINavigationController alloc] initWithRootViewController:featuredVC];
    self.featuredNavigationController.view.frame = CGRectMake(0, 0, 320, (IS_IPHONE_5 ? 568 : 480));
    self.featuredNavigationController.navigationBarHidden = YES;

    self.exploreNavigationController = [[UINavigationController alloc] initWithRootViewController:exploreVC];
    self.exploreNavigationController.view.frame = CGRectMake(0, 0, 320, (IS_IPHONE_5 ? 568 : 480));
    self.exploreNavigationController.navigationBarHidden = YES;
    
    self.exploreNavigationController.view.hidden = YES;
    self.myBookshelfNavigationController = [[UINavigationController alloc] initWithRootViewController:libraryVC];
    self.myBookshelfNavigationController.view.frame = CGRectMake(0, 0, 320, (IS_IPHONE_5 ? 568 : 480));
    self.myBookshelfNavigationController.navigationBarHidden = YES;
    self.myBookshelfNavigationController.view.hidden = YES;
    
    self.moreNavigationController = [[UINavigationController alloc] initWithRootViewController: moreVC];
    self.moreNavigationController.view.frame = CGRectMake(0, 0, 320, (IS_IPHONE_5 ? 568 : 480));
    self.moreNavigationController.navigationBarHidden = YES;
    
    [self.view addSubview:self.moreNavigationController.view];
    [self.view addSubview:self.featuredNavigationController.view];
    [self.view addSubview:self.exploreNavigationController.view];
    [self.view addSubview:self.myBookshelfNavigationController.view];
    
}

- (void) loadView {
    [super loadView];
    
    self.view.frame = CGRectMake(0, 0, 320, 568);
    
    self.backGroundView = [[UIImageView alloc] initWithImage:self.bgImage];
    self.view.userInteractionEnabled = YES;
    self.backGroundView.userInteractionEnabled = YES;
    
    if (IS_IPHONE_5)
        self.backGroundView.frame = CGRectMake(0, 503, 320, 45);
    else
        self.backGroundView.frame = CGRectMake(0, 420, 320, 45);
    
    [self.view addSubview:self.backGroundView];
    
    [self createTabBarContent];
    
     
    self.featuredButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 1, 73, 45)];
    self.featuredButton.tag = 11111;
    [self centerAlignImageAndTextForButton: self.featuredButton
                                     title: @"Featured"
                                     icone:[UIImage imageNamed:@"featuredBarIcone.png"]
                             selectedIcone:[UIImage imageNamed:@"featuredBarIconeSelected.png"]
                                     space: 3];

    self.exploreButton = [[UIButton alloc] initWithFrame:CGRectMake(85, 2, 73, 45)];
    self.exploreButton.tag = 22222;
    [self centerAlignImageAndTextForButton: self.exploreButton
                                     title: @"Explore"
                                     icone:[UIImage imageNamed:@"exploreBarIcone.png"]
                             selectedIcone:[UIImage imageNamed:@"exploreBarIconeSelected.png"]
                                     space: 5];

    self.myLibButton = [[UIButton alloc] initWithFrame:CGRectMake(170, 2, 73, 45)];
    self.myLibButton.tag = 33333;
    [self centerAlignImageAndTextForButton: self.myLibButton
                                     title: @"My Library"
                                     icone:[UIImage imageNamed:@"myLibBarIcone.png"]
                             selectedIcone:[UIImage imageNamed:@"myLibBarIconeSelected.png"]
                                     space: 4];
    
    self.moreButton = [[UIButton alloc] initWithFrame:CGRectMake(240, 3, 73, 45)];
    self.moreButton.tag = 44444;
    [self centerAlignImageAndTextForButton: self.moreButton
                                     title: @"More"
                                     icone:[UIImage imageNamed:@"moreBarIcone.png"]
                             selectedIcone:[UIImage imageNamed:@"moreBarIconeSelected.png"]
                                     space: 16];
    self.moreButton.imageEdgeInsets = UIEdgeInsetsMake(-25,0,-14,-24);

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

- (void)centerAlignImageAndTextForButton:(UIButton*)button
                                   title: (NSString *)title
                                   icone: (UIImage *)icone
                           selectedIcone: (UIImage *)selectedIcone
                                   space: (float)space
{
    [button setTitle: title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"proximanovalight" size:10.0f];
    button.titleLabel.font = [UIFont systemFontOfSize:10.0];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:RGBA(214, 77, 76, 1) forState:UIControlStateHighlighted];
    [button setTitleColor:RGBA(214, 77, 76, 1) forState:UIControlStateSelected];
    [button setImage: icone forState:UIControlStateNormal];
    [button setImage: icone forState:UIControlStateHighlighted];
    [button setImage: selectedIcone forState:UIControlStateSelected];
    button.showsTouchWhenHighlighted = YES;
    CGFloat spacing = space;
    CGSize imageSize = button.imageView.frame.size;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, -(imageSize.height + spacing), 0);
    CGSize titleSize = button.titleLabel.frame.size;
    button.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0, 0, -titleSize.width);
    
    [button addTarget:self action:@selector(toggleTabs:) forControlEvents:UIControlEventTouchUpInside];
    [self.backGroundView addSubview: button];
}

- (void) toggleTabs: (id) target {
    
    NSInteger targetId = ((UIButton *)target).tag;
    
    switch (targetId) {
        case 11111: {
            
            self.featuredButton.selected = YES;
            self.exploreButton.selected = NO;
            self.myLibButton.selected = NO;
            self.moreButton.selected = NO;
            
            self.featuredNavigationController.view.hidden = NO;
            self.exploreNavigationController.view.hidden = YES;
            self.moreNavigationController.view.hidden = YES;
            self.myBookshelfNavigationController.view.hidden = YES;
            
            break;
        }
        case 22222: {
            
            self.featuredButton.selected = NO;
            self.exploreButton.selected = YES;
            self.myLibButton.selected = NO;
            self.moreButton.selected = NO;
            
            self.featuredNavigationController.view.hidden = YES;
            self.moreNavigationController.view.hidden = YES;
            self.exploreNavigationController.view.hidden = NO;
            ExploreViewController * vc =  (ExploreViewController *)self.exploreNavigationController.visibleViewController;
            [vc redrawData];
            self.myBookshelfNavigationController.view.hidden = YES;
            
            break;
        }
        case 33333: {
            
            self.featuredButton.selected = NO;
            self.exploreButton.selected = NO;
            self.myLibButton.selected = YES;
            self.moreButton.selected = NO;
            
            self.featuredNavigationController.view.hidden = YES;
            self.exploreNavigationController.view.hidden = YES;
            self.moreNavigationController.view.hidden = YES;
            self.myBookshelfNavigationController.view.hidden = NO;
            
            break;
        }
        case 44444: {
            
            self.featuredButton.selected = NO;
            self.exploreButton.selected = NO;
            self.myLibButton.selected = NO;
            self.moreButton.selected = YES;
            
            self.featuredNavigationController.view.hidden = YES;
            self.exploreNavigationController.view.hidden = YES;
            self.myBookshelfNavigationController.view.hidden = YES;
            self.moreNavigationController.view.hidden = NO;
            
            break;
        }
        default:
            break;
    }
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
