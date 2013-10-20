//
//  BuyIssueViewController.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-09-17.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "BuyIssueViewController.h"
#import "Util.h"
#import "MainDataHolder.h"
#import "MagazinRecord.h"
#import "UIImageView+WebCache.h"

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
    
    self.view.backgroundColor = RGBA(64, 64, 65, 1);
    
    //-------------------------------- Top Bar ------------------------------------
    topBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"buyIssueBg.png"]];
    [topBar addSubview:backgroundView];
    [topBar sendSubviewToBack: backgroundView];
    [self.view addSubview: topBar];
    
    //-------------------------------- Top Bar Title ------------------------------------
    topBarTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 260, 44)];
    topBarTitleLabel.backgroundColor = [UIColor clearColor];
    topBarTitleLabel.textAlignment = NSTextAlignmentLeft;
    topBarTitleLabel.textColor = [UIColor whiteColor];
    topBarTitleLabel.text = @"Buy Issue Title";
    
    [topBar addSubview: topBarTitleLabel];
    
    closeButtonView = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButtonView.frame = CGRectMake(0, 0, 44, 44);
    [closeButtonView setImage:[Util imageNamedSmart:@"closeButton"] forState:UIControlStateNormal];
    [closeButtonView setImage:[Util imageNamedSmart:@"closeButton"] forState:UIControlStateSelected];
    [closeButtonView setImage:[Util imageNamedSmart:@"closeButton"] forState:UIControlStateHighlighted];
    closeButtonView.showsTouchWhenHighlighted = YES;
    [closeButtonView addTarget:self action:@selector(animateDown) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview: closeButtonView];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 64, 300, 440)];
    scrollView.contentSize = CGSizeMake(300, 440);
    scrollView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview: scrollView];
    
    imageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 155, 210)];
    imageView.image = [UIImage imageNamed:@"placeholder.png"];
    
    [scrollView addSubview: imageView];
    
    dateLabel = [[UILabel alloc] initWithFrame: CGRectMake(165, 0, 130, 20)];
    dateLabel.backgroundColor = [UIColor clearColor];
    dateLabel.font = [UIFont fontWithName:@"proximanovaregular" size:16.0f];
    dateLabel.font = [UIFont boldSystemFontOfSize: 16.0f];
    dateLabel.textColor = [UIColor whiteColor];
    
    [scrollView addSubview: dateLabel];
    
    shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(165, 30, 135, 30)];
    [shareBtn addTarget:self  action:@selector(shareHandler) forControlEvents:UIControlEventTouchDown];
    [shareBtn setBackgroundImage: [Util imageNamedSmart:@"shareBtn"] forState:UIControlStateNormal];
    [shareBtn setTitle:@"SHARE" forState:UIControlStateNormal];
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    shareBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    
    [scrollView addSubview: shareBtn];
    
    buyThisIssueLabel = [[UILabel alloc] initWithFrame: CGRectMake(165, 75, 135, 20)];
    buyThisIssueLabel.backgroundColor = [UIColor clearColor];
    buyThisIssueLabel.font = [UIFont fontWithName:@"proximanovaregular" size:12.0f];
    buyThisIssueLabel.font = [UIFont boldSystemFontOfSize: 12.0f];
    buyThisIssueLabel.textColor = [UIColor whiteColor];
    buyThisIssueLabel.text = @"Buy this issue";
    
    [scrollView addSubview: buyThisIssueLabel];
    
    buyIssueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyIssueBtn.frame = CGRectMake(165, 105, 135, 30);
    [buyIssueBtn setTitle:@"$4.99" forState:UIControlStateNormal];
    buyIssueBtn.backgroundColor = RGBA(214, 77, 76, 1);
    buyIssueBtn.showsTouchWhenHighlighted = YES;
    buyIssueBtn.titleLabel.font = [UIFont fontWithName:@"proximanovaregular" size: 18.0f];
    [buyIssueBtn addTarget: self action: @selector(submitHandler) forControlEvents:UIControlEventTouchUpInside];
    
    [scrollView addSubview: buyIssueBtn];
    
    subscribeIssueLabel = [[UILabel alloc] initWithFrame: CGRectMake(165, 140, 135, 20)];
    subscribeIssueLabel.backgroundColor = [UIColor clearColor];
    subscribeIssueLabel.font = [UIFont fontWithName:@"proximanovaregular" size:12.0f];
    subscribeIssueLabel.font = [UIFont boldSystemFontOfSize: 12.0f];
    subscribeIssueLabel.textColor = [UIColor whiteColor];
    subscribeIssueLabel.text = @"Subscribe for 10 issues";
    
    [scrollView addSubview: subscribeIssueLabel];
    
    subscribeIssueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    subscribeIssueBtn.frame = CGRectMake(165, 165, 135, 30);
    [subscribeIssueBtn setTitle:@"$12.99" forState:UIControlStateNormal];
    subscribeIssueBtn.backgroundColor = RGBA(214, 77, 76, 1);
    subscribeIssueBtn.showsTouchWhenHighlighted = YES;
    subscribeIssueBtn.titleLabel.font = [UIFont fontWithName:@"proximanovaregular" size: 18.0f];
    [subscribeIssueBtn addTarget: self action: @selector(submitHandler) forControlEvents:UIControlEventTouchUpInside];
    
    [scrollView addSubview: subscribeIssueBtn];
    
    buyIssueText = [[UITextView alloc] initWithFrame: CGRectMake(0, 240, 300, 200)];
    buyIssueText.backgroundColor = RGBA(41, 41, 41, 1);
    buyIssueText.font = [UIFont fontWithName:@"proximanovabold" size:17.0];
    buyIssueText.contentInset = UIEdgeInsetsMake(0.0,0.0,0,0.0);
    buyIssueText.textColor = [UIColor whiteColor];
    buyIssueText.editable = NO;
    buyIssueText.text = @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
    
    [scrollView addSubview: buyIssueText];
    
}

- (void) hitIssueDescription : (NSInteger) magazineId {
    MagazinRecord * currentMagazine = [[MainDataHolder getInstance].testData objectAtIndex:magazineId];
    // NSLog(@"currentMagazine: %@", currentMagazine.magazinDetailsImageURL);
    dateLabel.text = currentMagazine.magazinDate;
    
    [imageView setImageWithURL: [NSURL URLWithString: currentMagazine.magazinDetailsImageURL] placeholderImage: nil options:SDWebImageProgressiveDownload];
    
    buyIssueText.text = currentMagazine.magazinDetailsText;
}


- (void) animateUpAndDown: (BOOL) isUP {
    
    if(isUP) {
        self.isOpen = YES;
        
        [UIView beginAnimations:@"popingUP" context:nil];
        self.view.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView setAnimationDuration:0.3];
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView commitAnimations];
        
    } else {
        self.isOpen = NO;
        
        [UIView beginAnimations:@"popingUP" context:nil];
        
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [UIView setAnimationDuration:0.3];
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
