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

#define TAB_BAR_VIEW_COUNT 4

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

// -------------------------------------------------------------------------------
// setupIPhoneTabBarViewControllers
// -------------------------------------------------------------------------------
- (NSArray *) setupIPhoneTabBarViewControllers {
    
    ExploreViewController *exploreVC = [[ExploreViewController alloc] init];
    LibraryViewController *libraryVC = [[LibraryViewController alloc] init];
    MyBookshelfViewController *myBookShelfVC = [[MyBookshelfViewController alloc] init];
    SettingsViewController *settingsVC = [[SettingsViewController alloc] init];
    
    NSArray *arrVC = [NSArray arrayWithObjects: exploreVC, libraryVC, myBookShelfVC, settingsVC, nil];
    
    return arrVC;
}

// -------------------------------------------------------------------------------
// setupTabBar:
// Set up tab bar with iPhone view controllers.
// -------------------------------------------------------------------------------
- (void) setupTabBar:(NSArray *)arrayVC {
    //---------------------------- TODO ------------------------------
    UITabBarItem * explorItem = [[UITabBarItem alloc] init];
    [explorItem setTitle:@"Explore"];
    
    UITabBarItem * libraryBarItem = [[UITabBarItem alloc] init];
    [libraryBarItem setTitle:@"Library"];
    
    UITabBarItem * myBookShelfBarItem = [[UITabBarItem alloc] init];
    [myBookShelfBarItem setTitle:@"My Bookshelf"];
    
    UITabBarItem * settingsfBarItem = [[UITabBarItem alloc] init];
    [settingsfBarItem setTitle:@"Settings"];
    
    [[arrayVC objectAtIndex:0] setTabBarItem:explorItem];
    [[arrayVC objectAtIndex:0] setTitle: @"Explore"];
    
    [[arrayVC objectAtIndex:1] setTabBarItem:explorItem];
    [[arrayVC objectAtIndex:1] setTitle: @"Library"];
    
    [[arrayVC objectAtIndex:2] setTabBarItem:explorItem];
    [[arrayVC objectAtIndex:2] setTitle: @"My Bookshelf"];
    
    [[arrayVC objectAtIndex:3] setTabBarItem:explorItem];
    [[arrayVC objectAtIndex:3] setTitle: @"Settings"];
    
    NSMutableArray *viewArray = [NSMutableArray arrayWithCapacity:TAB_BAR_VIEW_COUNT];
    
    UINavigationController * navCont = [[UINavigationController alloc] initWithRootViewController:[arrayVC objectAtIndex:0]];
    navCont.navigationBar.tintColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0] ;
	[viewArray addObject:navCont];
    
    navCont = [[UINavigationController alloc] initWithRootViewController:[arrayVC objectAtIndex:1]];
    navCont.navigationBar.tintColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0] ;
    [viewArray addObject:navCont];
    
    navCont = [[UINavigationController alloc] initWithRootViewController:[arrayVC objectAtIndex:2]];
    navCont.navigationBar.tintColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0] ;
    [viewArray addObject:navCont];
    
    navCont = [[UINavigationController alloc] initWithRootViewController:[arrayVC objectAtIndex:3]];
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
        
        [self setupTabBar: [self setupIPhoneTabBarViewControllers]];
        
    } else {
        self.view.frame = CGRectMake(0, 0, 768, 1024);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
