//
//  BuyIssueViewController.h
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-09-17.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyIssueViewController : UIViewController {
    
@protected
    UIView       *topBar;
    UIButton     *closeButtonView;
    UILabel      *topBarTitleLabel;
    UIImageView  *imageView;
    UILabel      *dateLabel;
    UIButton     *shareBtn;
    UILabel      *buyThisIssueLabel;
    UIButton     *buyIssueBtn;
    UIButton     *subscribeIssueBtn;
    UILabel      *subscribeIssueLabel;
    UITextView   *buyIssueText;
    UIScrollView *scrollView;
}

@property bool isOpen;

- (void) animateUpAndDown: (BOOL) isUP;
- (void) hitIssueDescription : (NSInteger) magazineId;

@end
