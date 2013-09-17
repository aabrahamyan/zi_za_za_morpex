//
//  BookMarkViewController_iPad.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-09-09.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "BookMarkViewController_iPad.h"

@interface BookMarkViewController_iPad () {
    CGRect topBarFrame, filterLabelsFrame, noBookMarksContainerFrame, bookMarksScrollViewFrame;
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
    self.view.frame = CGRectMake(0, 1024, 1024, 768);
    closeButtonView.frame = CGRectMake(0, 0, 46, 44);
}

- (void)viewDidLayoutSubviews {

    UIInterfaceOrientation iOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (iOrientation == UIDeviceOrientationPortrait) {
        topBarFrame = CGRectMake(0, 0, 768, 44);
        filterLabelsFrame = CGRectMake(620, 0, 300, 30);
        noBookMarksContainerFrame = CGRectMake(259, 80, 250, 100);
        bookMarksScrollViewFrame = CGRectMake(114, 100, 540, 850);
    } else {
        
        topBarFrame = CGRectMake(0, 0, 1024, 44);
        filterLabelsFrame = CGRectMake(880, 0, 300, 30);
        noBookMarksContainerFrame = CGRectMake(387, 80, 250, 100);
        bookMarksScrollViewFrame = CGRectMake(242, 100, 540, 590);
    }
    
    topBar.frame = topBarFrame;
    filterLabels.frame = filterLabelsFrame;
    noBookMarksContainer.frame = noBookMarksContainerFrame;
    bookMarksScrollView.frame = bookMarksScrollViewFrame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
