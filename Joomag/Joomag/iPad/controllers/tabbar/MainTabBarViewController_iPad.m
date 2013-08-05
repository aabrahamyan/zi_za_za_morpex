//
//  MainTabBarViewController_iPad.m
//  Joomag
//
//  Created by Armen Abrahamyan on 7/17/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "MainTabBarViewController_iPad.h"
#import "FeaturedViewController_iPad.h"
#import "LibraryViewController_iPad.h"
#import "ExploreViewController_iPad.h"
#import "SettingsViewController_iPad.h"
#import "Util.h"

@interface MainTabBarViewController_iPad () {
    FeaturedViewController_iPad *featuredVcIPad;
    ExploreViewController_iPad *explorVcIPad;
    LibraryViewController_iPad *libraryVcIPad;
    SettingsViewController_iPad *settingsVcIPad;
}

@end

@implementation MainTabBarViewController_iPad

// -------------------------------------------------------------------------------
// setupIPadTabBarViewControllers
// -------------------------------------------------------------------------------
- (NSArray *) setupIPadTabBarViewControllers {
    featuredVcIPad = [[FeaturedViewController_iPad alloc] init];
    explorVcIPad = [[ExploreViewController_iPad alloc] init];
    libraryVcIPad = [[LibraryViewController_iPad alloc] init];
    settingsVcIPad = [[SettingsViewController_iPad alloc] init];
    
    NSArray *arrVC = [NSArray arrayWithObjects: featuredVcIPad, explorVcIPad, libraryVcIPad, settingsVcIPad, nil];
    
    return arrVC;
}

-(void) loadView {
    [super loadView];
    NSLog(@"iPad");
    [self setupTabBar:[self setupIPadTabBarViewControllers]];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskAllButUpsideDown;
    
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    switch (maintabBarController.selectedIndex) {
            
        case 0:
            [featuredVcIPad positioningFeaturedView];
            break;
        case 1:
            [explorVcIPad positioningExploreView];
            break;
        case 2:
            [libraryVcIPad positioningLibraryView];
            break;
        case 3:
            [settingsVcIPad positioningSettingsView];
            break;
        default:
            break;
            
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
