//
//  AppDelegate_iPad.m
//  Joomag
//
//  Created by Armen Abrahamyan on 7/17/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "AppDelegate_iPad.h"
#import "MainTabBarViewController_iPad.h"

@implementation AppDelegate_iPad

#pragma -- Decide Device Views --

- (MainTabBarViewController *) getStartScreen {
    @autoreleasepool {
        return [[MainTabBarViewController_iPad alloc] init];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
    [super applicationWillResignActive:application];
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [super applicationDidEnterBackground:application];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [super applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [super applicationDidBecomeActive:application];
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    [super applicationWillTerminate:application];
}

@end
