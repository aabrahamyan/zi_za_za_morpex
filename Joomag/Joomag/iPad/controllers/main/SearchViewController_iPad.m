//
//  SearchViewController_iPad.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-08-18.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "SearchViewController_iPad.h"

@interface SearchViewController_iPad () {
    CGRect searchBarFrame;
}

@end

@implementation SearchViewController_iPad

- (void)loadView {
    [super loadView];
    NSLog(@"search iPAD");
}

- (void)viewDidLayoutSubviews {
    
    UIInterfaceOrientation iOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (iOrientation == UIDeviceOrientationPortrait) {
        searchBarFrame = CGRectMake(200, 90, 470, 53);
    } else {
        searchBarFrame = CGRectMake(277, 90, 470, 53);
    }
    
    
}

@end
