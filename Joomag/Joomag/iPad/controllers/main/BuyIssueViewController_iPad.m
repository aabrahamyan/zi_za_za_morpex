//
//  BuyIssueViewController_iPad.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-09-17.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "BuyIssueViewController_iPad.h"

@interface BuyIssueViewController_iPad () {
    CGRect imageFrame, dateLabelFrame, textFrame, shareBtnFrame, buyThisIssueFrame, shareLabelFrame,
    subscribeIssueLabelFrame, buyIssueBtnFrame, subscribeIssueBtnFrame, buttonContainerFrame;
    
    UIView  *buttonContainer;
    UILabel *shareLabel;
}

@end

@implementation BuyIssueViewController_iPad

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
    
    buttonContainer = [[UIView alloc] init];
    
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 400, 180)];
    bgImage.image = [UIImage imageNamed: @"buyIssueBtnBg.png"];
    [buttonContainer addSubview: bgImage];
    
    [self.view addSubview: buttonContainer];
    
    
    shareLabel = [[UILabel alloc] init];
    shareLabel.text = @"Share";
    shareLabel.font = [UIFont fontWithName:@"proximanovabold" size:18.0f];
    shareLabel.textColor = [UIColor whiteColor];
    shareLabel.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview: shareLabel];
}

- (void)viewDidLayoutSubviews {
    
    UIInterfaceOrientation iOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (iOrientation == UIDeviceOrientationPortrait) {
        imageFrame = CGRectMake(50, 160, 240, 310);
        dateLabelFrame = CGRectMake(320, 120, 200, 20);
        textFrame = CGRectMake(320, 190, 420, 240);
        shareBtnFrame = CGRectMake(610, 425, 110, 30);
        buyThisIssueFrame = CGRectMake(320, 485, 200, 20);
        subscribeIssueLabelFrame = CGRectMake(320, 540, 200, 20);
        buyIssueBtnFrame =  CGRectMake(610, 480, 110, 30);
        subscribeIssueBtnFrame =  CGRectMake(610, 540, 110, 30);
        buttonContainerFrame = CGRectMake(320, 410, 400, 180);
        shareLabelFrame = CGRectMake(320, 430, 100, 20);
    } else {
        imageFrame = CGRectMake(150, 160, 240, 310);
        dateLabelFrame = CGRectMake(420, 120, 200, 20);
        textFrame = CGRectMake(420, 190, 420, 240);
        shareBtnFrame = CGRectMake(710, 425, 110, 30);
        buyThisIssueFrame = CGRectMake(420, 485, 200, 20);
        subscribeIssueLabelFrame = CGRectMake(420, 540, 200, 20);
        buyIssueBtnFrame =  CGRectMake(710, 480, 110, 30);
        subscribeIssueBtnFrame =  CGRectMake(710, 540, 110, 30);
        buttonContainerFrame = CGRectMake(420, 410, 400, 180);
        shareLabelFrame = CGRectMake(420, 430, 100, 20);
    }
    
    imageView.frame = imageFrame;
    dateLabel.frame = dateLabelFrame;
    buyIssueText.frame = textFrame;
    buyIssueText.contentInset = UIEdgeInsetsMake(-10, -9, 0, 0);
    buyIssueText.backgroundColor = [UIColor clearColor];
    shareBtn.frame = shareBtnFrame;
    
    buyThisIssueLabel.frame = buyThisIssueFrame;
    buyThisIssueLabel.font = [UIFont fontWithName:@"proximanovabold" size:18.0f];
    
    subscribeIssueLabel.frame = subscribeIssueLabelFrame;
    subscribeIssueLabel.font = [UIFont fontWithName:@"proximanovabold" size:18.0f];
    
    buyIssueBtn.frame = buyIssueBtnFrame;
    
    subscribeIssueBtn.frame = subscribeIssueBtnFrame;
    
    buttonContainer.frame = buttonContainerFrame;
    
    shareLabel.frame = shareLabelFrame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
