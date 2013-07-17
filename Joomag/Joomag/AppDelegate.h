//
//  AppDelegate.h
//  Joomag
//
//  Created by Armen Abrahamyan on 7/17/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainTabBarViewController;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController * navController;


- (MainTabBarViewController *) getStartScreen;

@end
