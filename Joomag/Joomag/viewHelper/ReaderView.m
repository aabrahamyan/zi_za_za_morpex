//
//  ReaderView.m
//  Joomag
//
//  Created by Armen Abrahamyan on 8/29/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "ReaderView.h"
#import "TiledView.h"

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
        self.clipsToBounds = YES;
        
        self.minimumZoomScale = 1.0f;
        self.maximumZoomScale = 1.955f;
        self.zoomScale = 1.955f;
        self.contentSize = frame.size; 
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO; 
        
        self.frame = frame;
        self.frame = CGRectMake(0, 0, 1024, 768);
        
        self.parentOfImages = [[UIView alloc] initWithFrame:frame];
        self.parentOfImages.frame = CGRectMake(0, 0, 1024, 768);
        self.parentOfImages.backgroundColor = [UIColor clearColor];
        
        [self.parentOfImages addSubview:self.leftImageView];
        [self.parentOfImages addSubview:self.rightImageView];
        
        [self addSubview:self.parentOfImages];
        
        
        
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
