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

@implementation CustomTabBarController_iPad

static CustomTabBarController_iPad * customTabBar_iPad;

- (id) initWithSpecifics:(UIImage *)bgImage withWidth:(CGFloat)width withHeight:(CGFloat)height {
    if((self = [super initWithSpecifics:bgImage withWidth:width withHeight:height])) {

    }
    
    return self;
}

+ (CustomTabBarController *) getInstance:(UIImage *) bgImage withWidth: (CGFloat) width withHeight: (CGFloat) height {
        [super getInstance:bgImage withWidth:width withHeight:height];
    
    if(customTabBar_iPad == nil) {
        customTabBar_iPad = [[CustomTabBarController_iPad alloc] initWithSpecifics:bgImage withWidth:width withHeight:height];
    }
    
    return customTabBar_iPad;
    
}

- (void) loadView {
    [super loadView];
    
    self.view.frame = CGRectMake(0, 0, 768, 1024);
    self.backGroundView.frame = CGRectMake(0, 703, self.width, self.height); 
    
    self.featuredButton.frame = CGRectMake(50, 10, 99, 24);
    self.exploreButton.frame = CGRectMake(220, 15, 94, 20);
    self.myLibButton.frame = CGRectMake(390, 15, 112, 20);
    
    self.gearButton.frame = CGRectMake(900, 15, 20, 20);
    self.noteButton.frame = CGRectMake(950, 15, 20, 20);
    
    FeaturedViewController_iPad * featuredVC = [[FeaturedViewController_iPad alloc] init];
    ExploreViewController_iPad * exploreVC = [[ExploreViewController_iPad alloc] init];
    LibraryViewController_iPad * libraryVC = [[LibraryViewController_iPad alloc] init];
    
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
    
    [self.view bringSubviewToFront:self.backGroundView];
    
}

- (SettingsViewController *) getSettingsViewController {
    return [[SettingsViewController_iPad alloc] init];
}


@end
