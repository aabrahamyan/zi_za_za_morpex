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
    subscribeIssueLabelFrame, buyIssueBtnFrame, subscribeIssueBtnFrame, buttonContainerFrame, scrollViewFrame;
    
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
    
    [scrollView addSubview: buttonContainer];
    
    
    shareLabel = [[UILabel alloc] init];
    shareLabel.text = @"Share";
    shareLabel.font = [UIFont fontWithName:@"proximanovabold" size:18.0f];
    shareLabel.textColor = [UIColor whiteColor];
    shareLabel.backgroundColor = [UIColor clearColor];
    
    [scrollView addSubview: shareLabel];
    
    UILabel *singleLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 500, 170, 20)];
    singleLabel.backgroundColor = [UIColor clearColor];
    singleLabel.textColor = [UIColor whiteColor];
    singleLabel.text = @"SINGLE ISSUES";
    singleLabel.font = [UIFont boldSystemFontOfSize: 12.0f];
    
    [scrollView addSubview: singleLabel];
    
    UIImageView *bootomBorder = [[UIImageView alloc] initWithFrame: CGRectMake(50, 950, 670, 2)];
    bootomBorder.image = [UIImage imageNamed:@"bookMarkSeparator.png"];
    
    [self.view addSubview: bootomBorder];
    
    [self setIssuesWithData];
    
}

- (void)viewDidLayoutSubviews {
    
    UIInterfaceOrientation iOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (iOrientation == UIDeviceOrientationPortrait) {
        imageFrame = CGRectMake(0, 40, 240, 310);
        dateLabelFrame = CGRectMake(270, 0, 400, 20);
        textFrame = CGRectMake(270, 70, 420, 240);
        shareBtnFrame = CGRectMake(560, 305, 110, 30);
        buyThisIssueFrame = CGRectMake(270, 365, 200, 20);
        subscribeIssueLabelFrame = CGRectMake(270, 420, 200, 20);
        buyIssueBtnFrame =  CGRectMake(560, 360, 110, 30);
        subscribeIssueBtnFrame =  CGRectMake(560, 420, 110, 30);
        buttonContainerFrame = CGRectMake(270, 290, 400, 180);
        shareLabelFrame = CGRectMake(270, 310, 100, 20);
        scrollViewFrame = CGRectMake(50, 100, 670, 849);
    } else {
        imageFrame = CGRectMake(0, 40, 240, 310);
        dateLabelFrame = CGRectMake(270, 0, 400, 20);
        textFrame = CGRectMake(270, 70, 420, 240);
        shareBtnFrame = CGRectMake(560, 305, 110, 30);
        buyThisIssueFrame = CGRectMake(270, 365, 200, 20);
        subscribeIssueLabelFrame = CGRectMake(270, 420, 200, 20);
        buyIssueBtnFrame =  CGRectMake(560, 360, 110, 30);
        subscribeIssueBtnFrame =  CGRectMake(560, 420, 110, 30);
        buttonContainerFrame = CGRectMake(270, 290, 400, 180);
        shareLabelFrame = CGRectMake(270, 310, 100, 20);
        scrollViewFrame = CGRectMake(177, 100, 670, 849);
    }
    
    imageView.frame = imageFrame;
    
    dateLabel.frame = dateLabelFrame;
    
    buyIssueText.frame = textFrame;
    buyIssueText.contentInset = UIEdgeInsetsMake(-10, -7, 0, 0);
    buyIssueText.backgroundColor = [UIColor clearColor];
    
    shareBtn.frame = shareBtnFrame;
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    
    buyThisIssueLabel.frame = buyThisIssueFrame;
    buyThisIssueLabel.font = [UIFont fontWithName:@"proximanovabold" size:18.0f];
    
    subscribeIssueLabel.frame = subscribeIssueLabelFrame;
    subscribeIssueLabel.font = [UIFont fontWithName:@"proximanovabold" size:18.0f];
    
    buyIssueBtn.frame = buyIssueBtnFrame;
    
    subscribeIssueBtn.frame = subscribeIssueBtnFrame;
    
    buttonContainer.frame = buttonContainerFrame;
    
    shareLabel.frame = shareLabelFrame;
    
    scrollView.frame = scrollViewFrame;
}

// TODO
- (void)setIssuesWithData {
    
    int posX = 0;
    int posY = 540;
    float width = 140;
    float height = 180;
    
    for (int i = 0; i < 9; i++) {
        
        UIView *issueContainer = [[UIView alloc] initWithFrame:CGRectMake(posX, posY, width, height+30)];
        
        [scrollView addSubview: issueContainer];
        
        UIImageView *imagView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, width, height)];
        imagView.image = [UIImage imageNamed:@"placeholder.png"];

        [issueContainer addSubview: imagView];
        
        UILabel *date = [[UILabel alloc] initWithFrame: CGRectMake(0, height+5, width, 20)];
        date.textColor = [UIColor grayColor];
        date.backgroundColor = [UIColor clearColor];
        date.font = [UIFont fontWithName:@"proximanovalight" size:14.0f];
        date.text = [NSString stringWithFormat:@"Issue- %i",i];
        date.textAlignment = NSTextAlignmentCenter;
        
        [issueContainer addSubview: date];
        
        posX += 180;
        if(posX >= 670){
            posX = 0;
            posY += 250;
        }
    }
    
    scrollView.contentSize =  CGSizeMake(670, posY+210);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
