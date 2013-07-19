//
//  MainTabBarViewController.m
//  Joomag
//
//  Created by Armen Abrahamyan on 7/17/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "MainTabBarViewController.h"

#import "ExploreViewController.h"
#import "LibraryViewController.h"
#import "MyBookshelfViewController.h"
#import "SettingsViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

#define TAB_BAR_VIEW_COUNT 4

//------------------- init view controllers ----------------------//
- (void) setupTabBarViewControllers {
    
    exploreVC = [[ExploreViewController alloc] init];
    libraryVC = [[LibraryViewController alloc] init];
    myBookShelfVC = [[MyBookshelfViewController alloc] init];
    settingsVC = [[SettingsViewController alloc] init];
    
}

- (void) setupTabBar {    
    
    UITabBarItem * explorItem = [[UITabBarItem alloc] init];
    [explorItem setTitle:@"Explore"];
    
    UITabBarItem * libraryBarItem = [[UITabBarItem alloc] init];
    [libraryBarItem setTitle:@"Library"];
    
    UITabBarItem * myBookShelfBarItem = [[UITabBarItem alloc] init];
    [myBookShelfBarItem setTitle:@"My Bookshelf"];
    
    UITabBarItem * settingsfBarItem = [[UITabBarItem alloc] init];
    [settingsfBarItem setTitle:@"Settings"];
    
    [exploreVC setTabBarItem:explorItem];
    exploreVC.title = @"Explore";
    [libraryVC setTabBarItem:libraryBarItem];
    libraryVC.title = @"Library";
    [myBookShelfVC setTabBarItem:myBookShelfBarItem];
    myBookShelfVC.title = @"My Bookshelf";
    [settingsVC setTabBarItem:settingsfBarItem];
    settingsVC.title = @"Settings";
    
    UINavigationController * navCont = [[UINavigationController alloc] initWithRootViewController:exploreVC];
    
    navCont.navigationBar.tintColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0] ;
    
	NSMutableArray * viewArray = [NSMutableArray arrayWithCapacity:TAB_BAR_VIEW_COUNT];
	[viewArray addObject:navCont];
    
    navCont = [[UINavigationController alloc] initWithRootViewController:libraryVC];
    navCont.navigationBar.tintColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0] ;
    [viewArray addObject:navCont];
    
    navCont = [[UINavigationController alloc] initWithRootViewController:myBookShelfVC];
    navCont.navigationBar.tintColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0] ;
    [viewArray addObject:navCont];
    
    navCont = [[UINavigationController alloc] initWithRootViewController:settingsVC];
    navCont.navigationBar.tintColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0] ;
    [viewArray addObject:navCont];
    
    maintabBarController = [[UITabBarController alloc] init];
    maintabBarController.delegate = self;
    maintabBarController.viewControllers = viewArray;
    
    [self.view addSubview:maintabBarController.view];
    
}

#pragma mark -
#pragma mark TabBarController delegate methods

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    return YES;
}

- (void) loadView {
    [super loadView];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        if (screenBounds.size.height == 568) {
            self.view.frame = CGRectMake(0, 0, 320, 568);
        } else {
            self.view.frame = CGRectMake(0, 0, 320, 480);
        }
    } else {
        self.view.frame = CGRectMake(0, 0, 768, 1024);
    }
    
    
    [self setupTabBarViewControllers];
    
    [self setupTabBar];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
