//
//  MainTabBarViewController.m
//  Joomag
//
//  Created by Armen Abrahamyan on 7/17/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "MainTabBarViewController.h"

#import "FeaturedViewController.h"
#import "LibraryViewController.h"
#import "ExploreViewController.h"
#import "SettingsViewController.h"
#import "Util.h"
#import "CustomTabBarController.h"

#define TAB_BAR_VIEW_COUNT 4

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

// -------------------------------------------------------------------------------
// setupIPhoneTabBarViewControllers
// -------------------------------------------------------------------------------
- (NSArray *) setupIPhoneTabBarViewControllers {
    
    FeaturedViewController *featuredVC = [[FeaturedViewController alloc] init];
    ExploreViewController *exploreVC = [[ExploreViewController alloc] init];
    LibraryViewController *libraryVC = [[LibraryViewController alloc] init];
    SettingsViewController *settingsVC = [[SettingsViewController alloc] init];
    
    NSArray *arrVC = [NSArray arrayWithObjects: featuredVC, exploreVC, libraryVC, settingsVC, nil];
    
    return arrVC;
}

// -------------------------------------------------------------------------------
// setupTabBar:
// Set up tab bar with iPhone view controllers.
// -------------------------------------------------------------------------------
/*- (void) setupTabBar:(NSArray *)arrayVC {
    //---------------------------- TODO ------------------------------
    
    maintabBarController = [[UITabBarController alloc] init];
    maintabBarController.delegate = self;
    
    CGRect frame = CGRectMake(0.0, 0.0, maintabBarController.view.bounds.size.width, 48);
    UIView *v = [[UIView alloc] initWithFrame:frame];
    [v setBackgroundColor: RGBA(43, 43, 44, 1)];
    [[maintabBarController tabBar] addSubview:v];
    
    UITabBarItem * featured = [[UITabBarItem alloc] init];
    [featured setTitle:@"Featured"];
    
    UITabBarItem * explorItem = [[UITabBarItem alloc] init];
    [explorItem setTitle:@"Explore"];
    
    UITabBarItem * libraryBarItem = [[UITabBarItem alloc] init];
    [libraryBarItem setTitle:@"Library"];
    
    UITabBarItem * settingsfBarItem = [[UITabBarItem alloc] init];
    [settingsfBarItem setTitle:@"Settings"];
    
    [[arrayVC objectAtIndex:0] setTabBarItem:featured];
    [[arrayVC objectAtIndex:0] setTitle: @"Featured"];
    
    [[arrayVC objectAtIndex:1] setTabBarItem:explorItem];
    [[arrayVC objectAtIndex:1] setTitle: @"Explore"];
    
    [[arrayVC objectAtIndex:2] setTabBarItem:libraryBarItem];
    [[arrayVC objectAtIndex:2] setTitle: @"Library"];
    
    [[arrayVC objectAtIndex:3] setTabBarItem:settingsfBarItem];
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
    
    maintabBarController.viewControllers = viewArray;
    
    [self.view addSubview:maintabBarController.view];
}*/

#pragma mark -
#pragma mark TabBarController delegate methods

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    return YES;
}

- (CustomTabBarController *) createAndGetTabbar {
    return [CustomTabBarController getInstance: [Util imageNamedSmart:@"tabBg"] withWidth:220 withHeight:45];
}

- (void) setupTabBar {
    CustomTabBarController * customTabBarVC = [self createAndGetTabbar];
    
    [self.view addSubview:customTabBarVC.view];
}

- (void) loadView {
    [super loadView];    
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        
        [self setupTabBar];
        
        if (screenBounds.size.height == 568) {
            self.view.frame = CGRectMake(0, 0, 320, 568);
        } else {
            self.view.frame = CGRectMake(0, 0, 320, 480);
        }
        
        
        //[self setupTabBar: [self setupIPhoneTabBarViewControllers]];
        
    } else {
        [self setupTabBar];
        self.view.frame = CGRectMake(0, 0, 768, 1024);
    }
}


- (void)viewDidLayoutSubviews {
    // NSLog(@"LAYOUT ORIENTATION CHANGED");
}


- (BOOL)shouldAutorotate {
    
    return NO;
}


- (NSUInteger)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
