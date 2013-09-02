//
//  ReaderView.m
//  Joomag
//
//  Created by Armen Abrahamyan on 8/29/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "ReaderView.h"

@implementation ReaderView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    
    return self;
}

- (id) initWithFrameAndImages:(CGRect) frame withLeftImageView: (UIImage *) leftImageView withRightImageView: (UIImage *) rightImageView withLeftFrame:  (CGRect) leftFrame withRightFrame: (CGRect) rightFrame {
    self = [super initWithFrame:frame];
    
    if(self) {
        self.backgroundColor = [UIColor clearColor];
        self.leftImageView = [[UIImageView alloc] initWithImage:leftImageView];
        self.leftImageView.frame = leftFrame;
        self.rightImageView = [[UIImageView alloc] initWithImage:rightImageView];
        self.rightImageView.frame = rightFrame;
        //self.leftImageView.frame = CGRectMake(0, 0, self.leftImageView.frame.size.width, self.leftImageView.frame.size.height);
        
        //self.rightImageView.frame = CGRectMake(self.leftImageView.frame.size.width, 0, self.rightImageView.frame.size.width, self.rightImageView.frame.size.height);

        self.frame = frame;
        [self addSubview:self.leftImageView];
        [self addSubview:self.rightImageView];
        
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
