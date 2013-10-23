//
//  FeaturedDetailsView.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-08-04.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "FeaturedDetailsView.h"
#import <QuartzCore/QuartzCore.h>
#import "Util.h"

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
        self.backGround.backgroundColor = RGBA(30, 30, 31, 0.95);
        //self.backGround.alpha = 0.8;
        [self addSubview: self.backGround];
        
        self.imageView = [[UIImageView alloc] init];
        self.imageView.image = [UIImage imageNamed:@"placeholder.png"];
        self.imageView.alpha = 1;
        [self addSubview: self.imageView];
        
        self.title = [[UILabel alloc] init];
        self.title.backgroundColor = [UIColor clearColor];
        self.title.font = [UIFont systemFontOfSize:16];
        self.title.textColor = [UIColor whiteColor];
        [self.title sizeToFit];
        [self addSubview: self.title];
        
        self.date = [[UILabel alloc] init];
        self.date.backgroundColor = [UIColor clearColor];
        self.date.font = [UIFont systemFontOfSize:12];
        self.date.textColor = [UIColor grayColor];
        [self.date sizeToFit];
        [self addSubview: self.date];
        
        self.text = [[UITextView alloc] init];
        self.text.backgroundColor = [UIColor clearColor];
        self.text.font = [UIFont systemFontOfSize:12];
        self.text.textColor = [UIColor whiteColor];
        self.text.editable = NO;
        [self addSubview: self.text];
        
        self.readBtn = [[UIButton alloc] init];
        self.readBtn.backgroundColor = RGBA(214, 77, 76, 1);
        [self.readBtn setTitle:@"READ" forState:UIControlStateNormal];
        self.readBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [self.readBtn addTarget:self  action:@selector(readButtonTap) forControlEvents:UIControlEventTouchDown];
        [self addSubview: self.readBtn];
        
        self.buyIssueBtn = [[UIButton alloc] init];
        self.buyIssueBtn.backgroundColor = RGBA(214, 77, 76, 1);
        [self.buyIssueBtn addTarget:self  action:@selector(buyIssueButtonTap) forControlEvents:UIControlEventTouchDown];
        [self.buyIssueBtn setTitle:@"BUY ISSUE" forState:UIControlStateNormal];
        self.buyIssueBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [self addSubview: self.buyIssueBtn];
        
        self.shareBtn = [[UIButton alloc] init];
        [self.shareBtn addTarget:self  action:@selector(shareHandler) forControlEvents:UIControlEventTouchDown];
        [self.shareBtn setBackgroundImage: [Util imageNamedSmart:@"shareBtn"] forState:UIControlStateNormal];
        [self.shareBtn setTitle:@"     SHARE" forState:UIControlStateNormal];
        self.shareBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [self addSubview: self.shareBtn];
        
        
        //CGRect screenBounds = [[UIScreen mainScreen] bounds];
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){ //TODO
            //if (screenBounds.size.height == 568) {
            imageViewFrame = CGRectMake(10, 10, 100, 140);
            titleFrame = CGRectMake(140, 10, 150, 20);
            dateFrame = CGRectMake(140, 30, 150, 20);
            textFrame = CGRectMake(0 , 0, 0, 0);
            readBtnFrame = CGRectMake(145, 55, 80, 25);
            buyIssueBtnFrame = CGRectMake(145, 90, 80, 25);
            shareBtnFrame = CGRectMake(145, 125, 80, 25);
            //} else {
            
            //}
        } else {
            imageViewFrame = CGRectMake(20, 20, 140, 180);
            titleFrame = CGRectMake(180, 50, 320, 20);
            dateFrame = CGRectMake(180, 20, 320, 20);
            textFrame = CGRectMake(173 , 70, 320, 90);
            readBtnFrame = CGRectMake(180, 170, 90, 30);
            buyIssueBtnFrame = CGRectMake(290, 170, 90, 30);
            shareBtnFrame = CGRectMake(410, 170, 90, 30);
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

- (void)readButtonTap {
    [self.delegate readHandler];
}

- (void)buyIssueButtonTap {
    [self.delegate buyIssueHandler];
}

- (void)shareHandler{
    [self.delegate shareHandler];
}


@end
