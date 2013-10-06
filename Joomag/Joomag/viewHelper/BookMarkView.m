//
//  BookMarkView.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-09-09.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "BookMarkView.h"
#import "Util.h"

@implementation BookMarkView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (id)initWithFrame: (CGRect)frame
          withImage: (UIImage *)image
              title: (NSString *)titleStr
               date: (NSString *)dateStr
               desc: (NSString *)descStr
         bookMarkId: (int)bookMarkID
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        
        UIView *backGround = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, width, height)];
        backGround.backgroundColor = RGBA(30, 30, 31, 0.95);
        //self.backGround.alpha = 0.8;
        [self addSubview: backGround];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame: CGRectMake(20, 20, 160, height-40)];
        imageView.image = [UIImage imageNamed:@"placeholder.png"];
        imageView.alpha = 1;
        [self addSubview: imageView];
        
        UILabel *title = [[UILabel alloc] initWithFrame: CGRectMake(200, 30, width-260, 20)];
        title.backgroundColor = [UIColor clearColor];
        title.font = [UIFont systemFontOfSize:16];
        title.textColor = [UIColor whiteColor];
        title.text = [NSString stringWithFormat:@"%@ | %@", titleStr, dateStr];
        [self addSubview: title];
        
        UITextView *text = [[UITextView alloc] initWithFrame: CGRectMake(190, 60, width-260, 60)];
        text.backgroundColor = [UIColor clearColor];
        text.font = [UIFont systemFontOfSize:12];
        text.textColor = [UIColor whiteColor];
        text.text = descStr;
        text.editable = NO;
        [self addSubview: text];
        
        UIImageView *bottomBorder = [[UIImageView alloc] initWithFrame: CGRectMake(0, height-2, width, 2)];
        bottomBorder.image = [UIImage imageNamed:@"bookMarkSeparator.png"];
        [self addSubview: bottomBorder];
        
        UIButton *closeButtonView = [UIButton buttonWithType:UIButtonTypeCustom];
        closeButtonView.frame = CGRectMake(width-44, 30, 22, 22);
        [closeButtonView setImage:[UIImage imageNamed:@"closeButton.png"] forState:UIControlStateNormal];
        [closeButtonView setImage:[UIImage imageNamed:@"closeButton.png"] forState:UIControlStateSelected];
        [closeButtonView setImage:[UIImage imageNamed:@"closeButton.png"] forState:UIControlStateHighlighted];
        closeButtonView.showsTouchWhenHighlighted = YES;
        [closeButtonView addTarget:self action:@selector(removeBookMark) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview: closeButtonView];
        
        UIButton *editButtonView = [UIButton buttonWithType:UIButtonTypeCustom];
        editButtonView.frame = CGRectMake(width-44, 75, 16, 17);
        [editButtonView setImage:[UIImage imageNamed:@"editIcone.png"] forState:UIControlStateNormal];
        [editButtonView setImage:[UIImage imageNamed:@"editIcone.png"] forState:UIControlStateSelected];
        [editButtonView setImage:[UIImage imageNamed:@"editIcone.png"] forState:UIControlStateHighlighted];
        editButtonView.showsTouchWhenHighlighted = YES;
        [editButtonView addTarget:self action:@selector(editBookMark) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview: editButtonView];
        
        self.tag = bookMarkID;
    }
    
    return self;
}


@end
