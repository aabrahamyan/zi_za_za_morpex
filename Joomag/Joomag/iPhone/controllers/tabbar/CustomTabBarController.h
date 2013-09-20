//
//  CustomTabBarController.h
//  Joomag
//
//  Created by Armen Abrahamyan on 8/7/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MoreViewController;
@class SettingsViewController;
@class BookMarkViewController;

@interface CustomTabBarController : UIViewController {


}

//---------------- UI Elements -----------------------------//
@property (nonatomic, strong) UIImageView * backGroundView;

@property (nonatomic, strong) UIButton * featuredButton;
@property (nonatomic, strong) UIButton * exploreButton;
@property (nonatomic, strong) UIButton * myLibButton;
@property (nonatomic, strong) UIButton * moreButton;

@property (nonatomic, strong) UIButton * gearButton;
@property (nonatomic, strong) UIButton * noteButton;

@property (nonatomic, strong) UIImage * bgImage;
//---------------- Navigation Elements ---------------------//

@property (nonatomic, strong) UINavigationController * featuredNavigationController;
@property (nonatomic, strong) UINavigationController * exploreNavigationController;
@property (nonatomic, strong) UINavigationController * myBookshelfNavigationController;
//---------------- Helper Indices --------------------------//
@property (nonatomic, assign) NSInteger currentFeatureControllerIndex;
@property (nonatomic, assign) NSInteger currentExploreControllerIndex;
@property (nonatomic, assign) NSInteger currentMyBookshelfControllerIndex;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

//----------------------- Mixed Attributes --------------------------//
@property (nonatomic, strong) SettingsViewController * settingsVC;
@property (nonatomic, strong) BookMarkViewController * bookMarksVC;
@property (nonatomic, strong) MoreViewController     * moreVC;

//----------------------- Instance Methods --------------------------//
- (id) initWithSpecifics: (UIImage * ) bgImage withWidth: (CGFloat) width withHeight: (CGFloat) height;

+ (CustomTabBarController *) getInstance:(UIImage *) bgImage withWidth: (CGFloat) width withHeight: (CGFloat) height;

@end
