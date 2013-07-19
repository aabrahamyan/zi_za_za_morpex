//
//  MainTabBarViewController.h
//  Joomag
//
//  Created by Armen Abrahamyan on 7/17/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ExploreViewController;
@class LibraryViewController;
@class MyBookshelfViewController;
@class SettingsViewController;

@interface MainTabBarViewController : UIViewController<UITabBarControllerDelegate> {


@protected
    UITabBarController * maintabBarController;
    ExploreViewController * exploreVC;
    LibraryViewController * libraryVC;
    MyBookshelfViewController * myBookShelfVC;
    SettingsViewController * settingsVC;
}





@end
