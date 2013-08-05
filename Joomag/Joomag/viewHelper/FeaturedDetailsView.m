//
//  FeaturedDetailsView.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-08-04.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "FeaturedDetailsView.h"
#import <QuartzCore/QuartzCore.h>

@implementation FeaturedDetailsView {
    CGRect imageViewFrame, titleFrame, dateFrame, backGroundFrame,
           textFrame, readBtnFrame, buyIssueBtnFrame, shareBtnFrame;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.backGround.backgroundColor = [UIColor blackColor];
        self.backGround.alpha = 0.8;
        [self addSubview: self.backGround];
        
        self.imageView = [[UIImageView alloc] init];
        self.imageView.image = [UIImage imageNamed:@"placeholder.png"];
        self.imageView.alpha = 1;
        [self addSubview: self.imageView];
        
        self.title = [[UILabel alloc] init];
        self.title.backgroundColor = [UIColor clearColor];
        self.title.font = [UIFont systemFontOfSize:18];
        self.title.textColor = [UIColor whiteColor];
        [self addSubview: self.title];
        
        self.date = [[UILabel alloc] init];
        self.date.backgroundColor = [UIColor clearColor];
        self.date.font = [UIFont systemFontOfSize:14];
        self.date.textColor = [UIColor grayColor];
        [self addSubview: self.date];
        
        self.text = [[UITextView alloc] init];
        self.text.backgroundColor = [UIColor clearColor];
        self.text.font = [UIFont systemFontOfSize:12];
        self.text.textColor = [UIColor whiteColor];
        [self addSubview: self.text];
        
        self.readBtn = [[UIButton alloc] init];
        self.readBtn.backgroundColor = [UIColor clearColor];
        [self.readBtn setTitle:@"READ" forState:UIControlStateNormal];
        self.readBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [[self.readBtn layer] setBorderWidth:1.5f];
        [[self.readBtn layer] setBorderColor:[UIColor grayColor].CGColor];
        [self.readBtn addTarget:self  action:@selector(readHandler) forControlEvents:UIControlEventTouchDown];
        [self addSubview: self.readBtn];
        
        self.buyIssueBtn = [[UIButton alloc] init];
        self.buyIssueBtn.backgroundColor = [UIColor clearColor];
        [self.buyIssueBtn addTarget:self  action:@selector(readHandler) forControlEvents:UIControlEventTouchDown];
        [self.buyIssueBtn setTitle:@"BUY ISSUE" forState:UIControlStateNormal];
        self.buyIssueBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [[self.buyIssueBtn layer] setBorderWidth:1.5f];
        [[self.buyIssueBtn layer] setBorderColor:[UIColor grayColor].CGColor];
        [self addSubview: self.buyIssueBtn];
        
        self.shareBtn = [[UIButton alloc] init];
        self.shareBtn.backgroundColor = [UIColor clearColor];
        [self.shareBtn addTarget:self  action:@selector(shareHandler) forControlEvents:UIControlEventTouchDown];
        [self.shareBtn setTitle:@"SHARE" forState:UIControlStateNormal]; // TODO
        self.shareBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [[self.shareBtn layer] setBorderWidth:1.5f];
        [[self.shareBtn layer] setBorderColor:[UIColor grayColor].CGColor];
        [self addSubview: self.shareBtn];
        
        
        //CGRect screenBounds = [[UIScreen mainScreen] bounds];
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
            //if (screenBounds.size.height == 568) {
                imageViewFrame = CGRectMake(10, 10, 100, 135);
                titleFrame = CGRectMake(140, 15, 150, 20);
                dateFrame = CGRectMake(145, 50, 130, 20);
                textFrame = CGRectMake(0 , 0, 0, 0);
                readBtnFrame = CGRectMake(145, 75, 100, 30);
                buyIssueBtnFrame = CGRectMake(145, 115, 100, 30);
                shareBtnFrame = CGRectMake(0, 0, 0, 0);
            //} else {
                
            //}
        } else {
            imageViewFrame = CGRectMake(10, 10, 150, 180);
            titleFrame = CGRectMake(170, 10, 200, 20);
            dateFrame = CGRectMake(170, 40, 200, 20);
            textFrame = CGRectMake(165 , 60, 320, 90);
            readBtnFrame = CGRectMake(170, 160, 90, 30);
            buyIssueBtnFrame = CGRectMake(270, 160, 90, 30);
            shareBtnFrame = CGRectMake(390, 160, 90, 30);
        }
        
        self.imageView.frame = imageViewFrame;
        self.title.frame = titleFrame;
        self.date.frame = dateFrame;
        self.text.frame = textFrame;
        self.readBtn.frame = readBtnFrame;
        self.buyIssueBtn.frame = buyIssueBtnFrame;
        self.shareBtn.frame = shareBtnFrame;

    }
    return self;
}

@end
