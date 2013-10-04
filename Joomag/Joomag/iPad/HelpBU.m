//
//  HelpBU.m
//  Joomag
//
//  Created by Armen Abrahamyan on 10/4/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "HelpBU.h"
#import "Util.h"
#import "HelpBO.h"

@implementation HelpBU

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = frame;
        
        mainClickableButton = [UIButton buttonWithType:UIButtonTypeCustom];
        mainClickableButton.frame = self.frame;
        mainClickableButton.backgroundColor = [UIColor clearColor];
        [mainClickableButton setImage:[Util imageNamedSmart:@"helpPortion"] forState:UIControlStateNormal];
        [mainClickableButton setImage:[Util imageNamedSmart:@"helpPortion"] forState:UIControlStateSelected];
        [mainClickableButton setImage:[Util imageNamedSmart:@"helpPortion"] forState:UIControlStateHighlighted];        
        
        mainClickableButton.titleLabel.frame = frame;
        mainClickableButton.titleLabel.numberOfLines = 2;
        mainClickableButton.titleLabel.backgroundColor = [UIColor clearColor];
        mainClickableButton.titleLabel.font = [UIFont systemFontOfSize:26.0];
        mainClickableButton.titleLabel.textColor = [UIColor whiteColor];
        
        mainClickableButton.adjustsImageWhenHighlighted=YES;
        mainClickableButton.userInteractionEnabled = YES;
        [mainClickableButton setSelected: NO];       
        
        [self addSubview:mainClickableButton];
        
        UITapGestureRecognizer * taper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openUrlInBrowser)];
        
        [self addGestureRecognizer:taper];
        
    }
    return self;
}

- (void) setTileTitle: (int)xPosition : (int)yPosition {
    
    UILabel * lbl = [[UILabel alloc] init];

    lbl.numberOfLines = NSIntegerMax;
    lbl.backgroundColor = [UIColor clearColor];
    lbl.font = [UIFont systemFontOfSize:12.0];
    lbl.textColor = [UIColor whiteColor];
    lbl.text = self.helpBo.title;
    
    lbl.frame = [Util calculateLabelFrame:lbl];
    
    lbl.frame = CGRectMake(xPosition + 10, yPosition, lbl.frame.size.width + 20, lbl.frame.size.height + 20);
    
    [self addSubview:lbl];

}


- (void) openUrlInBrowser {
    [[UIApplication sharedApplication] openURL:self.helpBo.url];
}


@end
