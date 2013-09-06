//
//  MyLibScrollView.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-09-05.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "MyLibScrollView.h"

@implementation MyLibScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        // self.backgroundColor = [UIColor greenColor];
        self.pagingEnabled = YES;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.contentMode = UIViewContentModeTopRight;
        self.autoresizingMask =(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        self.delegate = self;
        self.contentSize = CGSizeMake(400, 2000);
    }
    
    return self;
}

@end
