//
//  CustomTabBarController.m
//  Joomag
//
//  Created by Armen Abrahamyan on 8/7/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "CustomTabBarController.h"
#import "SettingsViewController.h"
#import "BookMarkViewController.h"
#import "AppDelegate.h"
#import "ExploreViewController.h"

@interface CustomTabBarController ()

@end

@implementation CustomTabBarController

static CustomTabBarController * customTabBarController; 

- (id) initWithSpecifics: (UIImage * ) bgImage withWidth: (CGFloat) width withHeight: (CGFloat) height {
    
    if((self=[super init])) {
        if(bgImage) {
            self.bgImage = bgImage;
        }
        
        if(width != -1.0 && height != -1.0) {
            self.width = width;
            self.height = height; 
        }
    }
    
    return self;
}

+ (CustomTabBarController *) getInstance:(UIImage *) bgImage withWidth: (CGFloat) width withHeight: (CGFloat) height {

    if(customTabBarController == nil) {
        customTabBarController = [[CustomTabBarController alloc] initWithSpecifics:bgImage withWidth:width withHeight:height];
        
    }
    
    return customTabBarController;
    
}

- (SettingsViewController *) getSettingsViewController {
    return [[SettingsViewController alloc] init];
}

- (BookMarkViewController *) getBookMarksViewController {
    return [[BookMarkViewController alloc] init];
}

- (void) loadView {
    [super loadView];
    
    self.backGroundView = [[UIImageView alloc] initWithImage:self.bgImage];
    self.view.userInteractionEnabled = YES;
    self.backGroundView.userInteractionEnabled = YES;
    
    [self.view addSubview:self.backGroundView];
    
    self.featuredButton = [[UIButton alloc] init];
    [self.featuredButton setImage:[UIImage imageNamed:@"barFeatured.png"] forState:UIControlStateNormal];
    [self.featuredButton setImage:[UIImage imageNamed:@"barFeatured.png"] forState:UIControlStateSelected];
    [self.featuredButton setImage:[UIImage imageNamed:@"barFeatured.png"] forState:UIControlStateHighlighted];
    self.featuredButton.showsTouchWhenHighlighted = YES;
    self.featuredButton.tag = 11111;
    
    [self.featuredButton addTarget:self action:@selector(toggleTabs:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backGroundView addSubview:self.featuredButton];
    
    
    self.exploreButton = [[UIButton alloc] init];
    [self.exploreButton setImage:[UIImage imageNamed:@"barExplore.png"] forState:UIControlStateNormal];
    [self.exploreButton setImage:[UIImage imageNamed:@"barExplore.png"] forState:UIControlStateSelected];
    [self.exploreButton setImage:[UIImage imageNamed:@"barExplore.png"] forState:UIControlStateHighlighted];
    self.exploreButton.showsTouchWhenHighlighted = YES;
    self.exploreButton.tag = 22222;
    
    [self.exploreButton addTarget:self action:@selector(toggleTabs:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backGroundView addSubview:self.exploreButton];
    
    
    self.myLibButton = [[UIButton alloc] init];
    [self.myLibButton setImage:[UIImage imageNamed:@"barMyLib.png"] forState:UIControlStateNormal];
    [self.myLibButton setImage:[UIImage imageNamed:@"barMyLib.png"] forState:UIControlStateSelected];
    [self.myLibButton setImage:[UIImage imageNamed:@"barMyLib.png"] forState:UIControlStateHighlighted];
    self.myLibButton.showsTouchWhenHighlighted = YES;
    self.myLibButton.tag = 33333;
    
    [self.myLibButton addTarget:self action:@selector(toggleTabs:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backGroundView addSubview:self.myLibButton];
    
    self.gearButton = [[UIButton alloc] init];
    [self.gearButton setImage:[UIImage imageNamed:@"tabBarGear.png"] forState:UIControlStateNormal];
    [self.gearButton setImage:[UIImage imageNamed:@"tabBarGear.png"] forState:UIControlStateSelected];
    [self.gearButton setImage:[UIImage imageNamed:@"tabBarGear.png"] forState:UIControlStateHighlighted];
    self.gearButton.showsTouchWhenHighlighted = YES;
    [self.gearButton addTarget:self action:@selector(showSettings) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backGroundView addSubview:self.gearButton];
    
    
    self.noteButton = [[UIButton alloc] init];
    [self.noteButton setImage:[UIImage imageNamed:@"tabBarXuyEgo.png"] forState:UIControlStateNormal];
    [self.noteButton setImage:[UIImage imageNamed:@"tabBarXuyEgo.png"] forState:UIControlStateSelected];
    [self.noteButton setImage:[UIImage imageNamed:@"tabBarXuyEgo.png"] forState:UIControlStateHighlighted];
    self.noteButton.showsTouchWhenHighlighted = YES;
    [self.noteButton addTarget:self action:@selector(showBookMarks) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backGroundView addSubview:self.noteButton];
}

- (void) toggleTabs: (id) target {
    
    NSInteger targetId = ((UIButton *)target).tag;
    
    switch (targetId) {
        case 11111: {
            
            self.featuredNavigationController.view.hidden = NO;
            self.exploreNavigationController.view.hidden = YES;            
            self.myBookshelfNavigationController.view.hidden = YES;
            
            break;
        }
        case 22222: {
            self.featuredNavigationController.view.hidden = YES;
            self.exploreNavigationController.view.hidden = NO;
            ExploreViewController * vc =  (ExploreViewController *)self.exploreNavigationController.visibleViewController;
            [vc redrawData];
            self.myBookshelfNavigationController.view.hidden = YES;
            
            break;
        }
        case 33333: {
            self.featuredNavigationController.view.hidden = YES;
            self.exploreNavigationController.view.hidden = YES;
            self.myBookshelfNavigationController.view.hidden = NO;
            
            break;
        }
        default:
            break;
    }
}



- (void)viewDidLayoutSubviews {
    NSLog(@"LAYOUT ORIENTATION CHANGED");
}

- (void) showSettings {
    self.settingsVC = [self getSettingsViewController];

    [self.view addSubview: self.settingsVC.view];
    
    [self.settingsVC animateUpAndDown:YES];
   
}

- (void) showBookMarks {
    self.bookMarksVC = [self getBookMarksViewController];
    
    [self.view addSubview: self.bookMarksVC.view];
    
    [self.bookMarksVC animateUpAndDown:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
