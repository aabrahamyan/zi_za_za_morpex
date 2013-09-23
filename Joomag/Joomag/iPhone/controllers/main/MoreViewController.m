//
//  MoreViewController.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-09-20.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "MoreViewController.h"
#import "Util.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (void)loadView {
    NSLog(@"More View");
    
    [super loadView];
    
    self.view.backgroundColor = RGBA(49, 49, 49, 1);
    
    //-------------------------------- BG Image -------------------------------
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,
                                                                             self.view.frame.size.height)];
    bgImageView.image = [UIImage imageNamed:@"moreBg.png"];
    
    [self.view addSubview: bgImageView];
    
    //-------------------------------- Top Bar ------------------------------------
    UIView *topBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topTabBarBg.png"]];
    [topBar addSubview:backgroundView];
    [topBar sendSubviewToBack: backgroundView];
    [self.view addSubview: topBar];
    
    //-------------------------------- Top Bar Title ------------------------------------
    UILabel *topBarTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    topBarTitleLabel.backgroundColor = [UIColor clearColor];
    topBarTitleLabel.textAlignment = NSTextAlignmentCenter;
    topBarTitleLabel.textColor = [UIColor whiteColor];
    topBarTitleLabel.text = @"More";
    
    [topBar addSubview: topBarTitleLabel];
    
    //-------------------------------- TABS ---------------------------------
    [self.view addSubview: [self constructTabsWithTitle: @"BookMarks"
                                                  frame: CGRectMake(20, 60, 88, 20)
                                                    tag: 1111111
                                            andSelector: @selector(bookmarksHandler)]
    ];
    
    [self.view addSubview: [self constructTabsWithTitle: @"Change Password"
                                                  frame: CGRectMake(20, 95, 140, 20)
                                                    tag:2222222
                                            andSelector: @selector(changePasswordHandler)]
     ];
    
    [self.view addSubview: [self constructTabsWithTitle: @"Notification Settings"
                                                  frame: CGRectMake(20, 130, 157, 20)
                                                    tag:3333333
                                            andSelector: @selector(notificationHandler)]
     ];
    
    [self.view addSubview: [self constructTabsWithTitle: @"Sign Out"
                                                  frame: CGRectMake(20, 165, 67, 20)
                                                    tag:4444444
                                            andSelector: @selector(signOutHandler)]
     ];
    
    [self.view addSubview: [self constructTabsWithTitle: @"Restore iTunes Purchases"
                                                  frame: CGRectMake(20, 200, 202, 20)
                                                    tag:5555555
                                            andSelector: @selector(restorePurschasesHandler)]
     ];
}

- (UIButton *)constructTabsWithTitle: (NSString *)title
                               frame: (CGRect)frame
                                 tag: (int)tag
                         andSelector: (SEL)selector
{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
//    btn.backgroundColor = [UIColor redColor];
    btn.titleLabel.font  = [UIFont boldSystemFontOfSize: 16];
    btn.tag = 1111111;
    [btn setTitle: title forState:UIControlStateNormal];
    [btn setTitle: title forState:UIControlStateSelected];
    [btn setTitle: title forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    
    [btn addTarget: self action: @selector(toggleButtons:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (void) toggleButtons: (id) target {
    UIButton *button = (UIButton *)target;
    NSInteger buttonTag = button.tag;
    
    switch (buttonTag) {
        case 1111111:
            [self bookmarksHandler];
            break;
        case 2222222:
            [self changePasswordHandler];
            break;
            
        case 3333333:
            [self notificationHandler];
            break;
            
        case 4444444:
            [self signOutHandler];
            break;
            
        case 5555555:
            [self restorePurschasesHandler];
            break;
            
        default:
            break;
    }
}



- (void)bookmarksHandler {
    NSLog(@"bookmarksHandler");
}

- (void)changePasswordHandler {
    NSLog(@"changePasswordHandler");
}

- (void)notificationHandler {
    NSLog(@"notificationHandler");
}

- (void)signOutHandler {
    NSLog(@"signOutHandler");
}

- (void)restorePurschasesHandler {
    NSLog(@"restorePurschasesHandler");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
