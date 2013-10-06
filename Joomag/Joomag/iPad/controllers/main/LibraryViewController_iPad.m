//
//  LibraryViewController_iPad.m
//  Joomag
//
//  Created by Armen Abrahamyan on 7/19/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "LibraryViewController_iPad.h"
#import "DataHolder.h"
#import "Util.h"

@interface LibraryViewController_iPad () {
        DatePickerView *datePicker;
}

@end

@implementation LibraryViewController_iPad {
    DataHolder *dataHolder;
    CGRect topBarFrame, loginContainerFrame, filterLabelsFrame, loginTextFrame, joomagButtonFrame, orLabelFrame, fbButtonFrame, twitterButtonFrame, scrollViewFrame;
    NSArray *data;
}

- (void)loadView {
    [super loadView];
    
    //NSLog(@"ExploreViewController_iPad");
    //---------------------------- DATE PICKER ------------------------------------
    datePicker = [[DatePickerView alloc] initWithFrame: CGRectMake(20, 160, 50, 520)];
    datePicker.delegate = self;
    
    [self.view addSubview: datePicker];
}

- (void)viewDidLayoutSubviews {
    
    UIInterfaceOrientation iOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (iOrientation == UIDeviceOrientationPortrait) {
        topBarFrame = CGRectMake(0, 0, 768, 44);
        filterLabelsFrame = CGRectMake(560, 0, 300, 30);
        loginContainerFrame = CGRectMake(0, 44, 768, 90);
        loginTextFrame = CGRectMake(20, 10, 350, 70);
        joomagButtonFrame = CGRectMake(310, 30, 200, 35);
        orLabelFrame = CGRectMake(520, 30, 20, 30);
        fbButtonFrame = CGRectMake(550, 5, 200, 35);
        twitterButtonFrame = CGRectMake(550, 50, 200, 35);
        scrollViewFrame = CGRectMake(120, 160, 600, 700);
    } else {
        topBarFrame = CGRectMake(0, 0, 1024, 44);
        filterLabelsFrame = CGRectMake(800, 0, 300, 30);
        loginContainerFrame = CGRectMake(0, 44, 1024, 90);
        loginTextFrame = CGRectMake(70, 10, 350, 70);
        joomagButtonFrame = CGRectMake(510, 30, 200, 35);
        orLabelFrame = CGRectMake(720, 30, 20, 30);
        fbButtonFrame = CGRectMake(750, 5, 200, 35);
        twitterButtonFrame = CGRectMake(750, 50, 200, 35);
        scrollViewFrame = CGRectMake(130, 160, 830, 500);
    }

    CGRect frm = CGRectMake(0, -20, self.view.bounds.size.width, self.view.bounds.size.height);
    self.view.frame = frm;
    topBar.frame = topBarFrame;
    filterLabels.frame = filterLabelsFrame;
    loginContainer.frame = loginContainerFrame;
    loginText.text = @"Sign in using social network or your Joomag account. Not a member? Join Joomag";
    loginText.numberOfLines = 2;
    loginText.font = [UIFont systemFontOfSize:14.0];
    loginText.frame = loginTextFrame;
    joomagButton.frame = joomagButtonFrame;
    orLabel.frame = orLabelFrame;
    fbButton.frame = fbButtonFrame;
    twitterButton.frame = twitterButtonFrame;
    scrollView.frame = scrollViewFrame;
    
    [scrollView redrawData];
    
}

@end
