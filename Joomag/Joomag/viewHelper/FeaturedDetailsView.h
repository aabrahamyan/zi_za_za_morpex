//
//  FeaturedDetailsView.h
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-08-04.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FeaturedDetailsButtonsDelegate <NSObject>
@optional
- (void)readHandler;
- (void)buyIssueHandler;
@end

@interface FeaturedDetailsView : UIView <FeaturedDetailsButtonsDelegate>

@property (weak, nonatomic) id <FeaturedDetailsButtonsDelegate> delegate;

@property (nonatomic, strong) UIView        *backGround;
@property (nonatomic, strong) UIImageView   *imageView;
@property (nonatomic, strong) UILabel       *title;
@property (nonatomic, strong) UILabel       *date;
@property (nonatomic, strong) UITextView    *text;
@property (nonatomic, strong) UIButton      *readBtn;
@property (nonatomic, strong) UIButton      *buyIssueBtn;
@property (nonatomic, strong) UIButton      *shareBtn;

@end
