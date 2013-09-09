//
//  BookMarkViewController_iPad.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-09-09.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "BookMarkViewController_iPad.h"

@interface BookMarkViewController_iPad () {
    CGRect topBarFrame, filterLabelsFrame, noBookMarksContainerFrame;
}

@end

@implementation BookMarkViewController_iPad

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
    
    closeButtonView.frame = CGRectMake(0, 0, 46, 44);
}

- (void)viewDidLayoutSubviews {

    UIInterfaceOrientation iOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (iOrientation == UIDeviceOrientationPortrait) {
        self.view.frame = CGRectMake(0, 0, 768, 1024);
        topBarFrame = CGRectMake(0, 0, 768, 44);
        filterLabelsFrame = CGRectMake(620, 0, 300, 30);
        noBookMarksContainerFrame = CGRectMake(0, 80, 768, 100);
    } else {
        // self.view.frame = CGRectMake(0, 0, 1024, 768-65);
        // topViewFrame = CGRectMake(0, 0, 1024, 44);
    }
    
    topBar.frame = topBarFrame;
    filterLabels.frame = filterLabelsFrame;
    noBookMarksContainer.frame = noBookMarksContainerFrame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
