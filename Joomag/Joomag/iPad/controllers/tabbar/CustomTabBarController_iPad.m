//
//  CustomTabBarController_iPad.m
//  Joomag
//
//  Created by Armen Abrahamyan on 8/7/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "CustomTabBarController_iPad.h"
#import "FeaturedViewController_iPad.h"
#import "ExploreViewController_iPad.h"
#import "LibraryViewController_iPad.h"
#import "SettingsViewController_iPad.h"
#import "BookMarkViewController_iPad.h"
#import "BuyIssueViewController_iPad.h"
#import "Util.h"

@implementation CustomTabBarController_iPad

static CustomTabBarController_iPad * customTabBar_iPad;

- (id) initWithSpecifics:(UIImage *)bgImage withWidth:(CGFloat)width withHeight:(CGFloat)height {
    if((self = [super initWithSpecifics:bgImage withWidth:width withHeight:height])) {

    }
    
    return self;
}

+ (CustomTabBarController_iPad *) getInstance {
    return customTabBar_iPad;  
}

+ (CustomTabBarController *) getInstance:(UIImage *) bgImage withWidth: (CGFloat) width withHeight: (CGFloat) height {
        [super getInstance:bgImage withWidth:width withHeight:height];
    
    if(customTabBar_iPad == nil) {
        customTabBar_iPad = [[CustomTabBarController_iPad alloc] initWithSpecifics:bgImage withWidth:width withHeight:height];
    }
    
    return customTabBar_iPad;
    
}

- (FeaturedViewController *) getFeaturedViewController {
    return [[FeaturedViewController_iPad alloc] init];
}

- (ExploreViewController *) getExploreViewController {
    return [[ExploreViewController_iPad alloc] init];
}

- (LibraryViewController *) getLibraryViewController {
    return [[LibraryViewController_iPad alloc] init];  
}


- (void) createTabBarContent {
    FeaturedViewController * featuredVC = [self getFeaturedViewController]; 
    ExploreViewController * exploreVC = [self getExploreViewController];
    LibraryViewController * libraryVC = [self getLibraryViewController];
    
    self.featuredNavigationController = [[UINavigationController alloc] initWithRootViewController:featuredVC];
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
    
    [self centerAlignImageAndTextForButton: self.featuredButton frame: CGRectMake(35, 2, 140, 44)];
    [self centerAlignImageAndTextForButton: self.exploreButton frame: CGRectMake(200, 3, 140, 44)];
    [self centerAlignImageAndTextForButton: self.myLibButton frame: CGRectMake(380, 2, 140, 44)];
    self.moreButton.hidden = YES;
 
    [self.view bringSubviewToFront: self.backGroundView];
}

- (void)centerAlignImageAndTextForButton: (UIButton *)button frame: (CGRect)frm {
    button.frame = frm;
    button.titleLabel.font = [UIFont fontWithName:@"proximanovalight" size:16.0f];
    button.titleLabel.font = [UIFont systemFontOfSize:18.0];
    CGSize imageSize = button.imageView.frame.size;
    button.titleEdgeInsets = UIEdgeInsetsMake(-imageSize.width, -10, -24, -imageSize.height);
    button.imageEdgeInsets = UIEdgeInsetsMake(-10, -10, -10, 10);
}

- (void)viewDidLayoutSubviews {
    //TODO: Handle Settings VC Orientation Change
    UIInterfaceOrientation iOrientation = [UIApplication sharedApplication].statusBarOrientation;

    if (iOrientation == UIDeviceOrientationPortrait) {
        self.view.frame = CGRectMake(0, 0, 768, 1024);
        self.backGroundView.frame = CGRectMake(0, 959, self.width, self.height);
        self.gearButton.frame = CGRectMake(680, 15, 20, 20);
        self.noteButton.frame = CGRectMake(720, 15, 20, 20);
        
        if (self.settingsVC.isOpen) {
            self.settingsVC.view.frame = CGRectMake(0, 0, 768, 1024);
        } else {
            self.settingsVC.view.frame = CGRectMake(1024, 0, 768, 1024);
        }

        if (self.bookMarksVC.isOpen) {
            self.bookMarksVC.view.frame = CGRectMake(0, 0, 768, 1024);
        } else {
            self.bookMarksVC.view.frame = CGRectMake(0, 1024, 768, 1024);
        }
        
        if (self.buyIssueVC.isOpen) {
            self.buyIssueVC.view.frame = CGRectMake(0, 0, 768, 1024);
        } else {
            self.buyIssueVC.view.frame = CGRectMake(0, 1024, 768, 1024);
        }
        
    } else {
        self.view.frame = CGRectMake(0, 0, 1024, 768);
        self.backGroundView.frame = CGRectMake(0, 704, self.width, self.height);
        self.gearButton.frame = CGRectMake(900, 15, 20, 20);
        self.noteButton.frame = CGRectMake(950, 15, 20, 20);

        if (self.settingsVC.isOpen) {
            self.settingsVC.view.frame = CGRectMake(0, 0, 1024, 768);
        } else {
            self.settingsVC.view.frame = CGRectMake(0, 1024, 1024, 768);
        }
        
        if (self.bookMarksVC.isOpen) {
            self.bookMarksVC.view.frame = CGRectMake(0, 0, 1024, 768);
        } else {
            self.bookMarksVC.view.frame = CGRectMake(0, 1024, 1024, 768);
        }
        
        if (self.buyIssueVC.isOpen) {
            self.buyIssueVC.view.frame = CGRectMake(0, 0, 1024, 768);
        } else {
            self.buyIssueVC.view.frame = CGRectMake(0, 1024, 1024, 768);
        }
    }
    
}

- (SettingsViewController *) getSettingsViewController {
    return [[SettingsViewController_iPad alloc] init];
}

- (BookMarkViewController *) getBookMarksViewController {
    return [[BookMarkViewController_iPad alloc] init];
}

- (BuyIssueViewController *) getBuyIssueViewController {
    return [[BuyIssueViewController_iPad alloc] init];
}



@end
