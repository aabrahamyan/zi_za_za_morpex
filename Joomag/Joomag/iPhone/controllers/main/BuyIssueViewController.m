//
//  BuyIssueViewController.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-09-17.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "BuyIssueViewController.h"
#import "Util.h"

@interface BuyIssueViewController ()

@end

@implementation BuyIssueViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    self.view.backgroundColor = RGBA(49, 49, 49, 1);
    
    //-------------------------------- Top Bar ------------------------------------
    topBar = [[UIView alloc] init]; //TODO: BG IMAGE
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchTopBarBg.png"]];
    [topBar addSubview:backgroundView];
    [topBar sendSubviewToBack: backgroundView];
    [self.view addSubview: topBar];
    
    //-------------------------------- Close Button ------------------------------------
    closeButtonView = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButtonView setImage:[UIImage imageNamed:@"searchTabBarClose.png"] forState:UIControlStateNormal];
    [closeButtonView setImage:[UIImage imageNamed:@"searchTabBarClose.png"] forState:UIControlStateSelected];
    [closeButtonView setImage:[UIImage imageNamed:@"searchTabBarClose.png"] forState:UIControlStateHighlighted];
    closeButtonView.showsTouchWhenHighlighted = YES;
    [closeButtonView addTarget:self action:@selector(animateDown) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:closeButtonView];
    
    //-------------------------------- Top Bar Title ------------------------------------
    topBarTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(83, 0, 150, 44)];
    topBarTitleLabel.backgroundColor = [UIColor clearColor];
    topBarTitleLabel.textColor = [UIColor whiteColor];
    topBarTitleLabel.text = @"BookMarks";
    
    [topBar addSubview: topBarTitleLabel];
}


- (void) animateUpAndDown: (BOOL) isUP {
    
    if(isUP) {
        self.isOpen = YES;
        
        [UIView beginAnimations:@"popingUP" context:nil];
        self.view.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView setAnimationDuration:1.0];
        self.view.frame = CGRectMake(0, -20, self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView commitAnimations];
        
    } else {
        self.isOpen = NO;
        
        [UIView beginAnimations:@"popingUP" context:nil];
        
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [UIView setAnimationDuration:1.0];
        self.view.frame = CGRectMake(0, 1024, self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView commitAnimations];
    }
    
}

- (void) animateDown {
    [self animateUpAndDown:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
