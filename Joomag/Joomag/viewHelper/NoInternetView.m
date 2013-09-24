//
//  NoInternetView.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-09-22.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "NoInternetView.h"

@implementation NoInternetView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor greenColor];
        
        UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,
                                                                             self.frame.size.height)];
        bgImage.image = [UIImage imageNamed: @"noInternet.png"];
        
        [self addSubview: bgImage];
        
        UIView *container = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 300, 200)];
        [self addSubview: container];
        
        UIView *blackRect = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
        blackRect.backgroundColor = [UIColor blackColor];
        blackRect.alpha = 0.6f;
        [container addSubview: blackRect];
        
        UILabel *text1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 260, 50)];
        text1.backgroundColor = [UIColor clearColor];
        text1.textColor = [UIColor whiteColor];
        text1.textAlignment = NSTextAlignmentCenter;
        text1.font = [UIFont boldSystemFontOfSize:20.0];
        text1.numberOfLines = 2;
        text1.alpha = 0.7;
        text1.text = @"Your network connection seems to be out.";
        
        [container addSubview: text1];
        
        UILabel *text2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 260, 50)];
        text2.backgroundColor = [UIColor clearColor];
        text2.textColor = [UIColor whiteColor];
        text2.textAlignment = NSTextAlignmentCenter;
        text2.font = [UIFont systemFontOfSize:20.0];
        text2.numberOfLines = 2;
        text2.alpha = 0.7;
        text2.text = @"Please check your WiFi,3G or airplane mode settings";
        
        [container addSubview: text2];
        
        UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(115, 140, 70, 41)];
        logo.image = [UIImage imageNamed:@"logo.png"];
        
        [container addSubview: logo];
        
        //333 68
        
        UIButton * retryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        retryButton.frame =  CGRectMake(65, 220, 175, 34);
        [retryButton setTitle:@"RETRY" forState:UIControlStateNormal];
        retryButton.titleLabel.textColor = [UIColor blackColor]; //TODO!
        [retryButton setBackgroundImage:[UIImage imageNamed:@"retryButton"] forState:UIControlStateNormal];
        [retryButton addTarget:self action:@selector(retryHandler) forControlEvents:UIControlEventTouchUpInside];
        
        [container addSubview: retryButton];
        
    }
    return self;
}

- (void)retryHandler {
    NSLog(@"retryHandler");
}

@end
