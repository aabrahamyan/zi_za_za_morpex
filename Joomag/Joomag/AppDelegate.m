//
//  AppDelegate.m
//  Joomag
//
//  Created by Armen Abrahamyan on 7/17/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarViewController.h"
#import "ConnectionManager.h"

@implementation AppDelegate

@synthesize navController;


#pragma -- Decide Device Views --

- (MainTabBarViewController *) getStartScreen {
    @autoreleasepool {
        return [[MainTabBarViewController alloc] init];
    }
}

- (void) displayStartView {
    MainTabBarViewController * mainVC = [self getStartScreen];
    
    [self.window setRootViewController:mainVC];
}

#pragma -- Main App Cycle --

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    [self displayStartView];
    
    [self.window makeKeyAndVisible];
    
    //ConnectionManager * connManager = [[ConnectionManager alloc] init];
    //[connManager constructGetMapagzinePage:47643 withPageNumber:9 andWithDelegate:nil];
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
