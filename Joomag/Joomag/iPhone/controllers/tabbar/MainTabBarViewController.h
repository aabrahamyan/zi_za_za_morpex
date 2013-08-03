//
//  MainTabBarViewController.h
//  Joomag
//
//  Created by Armen Abrahamyan on 7/17/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabBarViewController : UIViewController<UITabBarControllerDelegate> {

@protected
    UITabBarController * maintabBarController;
}

- (void) setupTabBar:(NSArray *)arrayVC;

@end
