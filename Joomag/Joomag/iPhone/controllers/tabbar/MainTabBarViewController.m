//
//  MainTabBarViewController.m
//  Joomag
//
//  Created by Armen Abrahamyan on 7/17/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "MainTabBarViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void) loadView {
    [super loadView];
    
    maintabBarController = [[UITabBarController alloc] init];
    
    UITabBarItem * tabBarItem = [[UITabBarItem alloc] init];
    [tabBarItem setTitle:@"Library"];
    
    //TODO:

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
