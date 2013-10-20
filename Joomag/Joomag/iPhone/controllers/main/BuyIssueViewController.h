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
    UIView      *topBar;
    UIButton    *closeButtonView;
    UILabel     *topBarTitleLabel;
    UIImageView *imageView;
    UILabel     *dateLabel;
    UIButton    *buyIssueBtn;
    UIButton    *subscribeIssueBtn;
    UITextView  *buyIssueText;
}

@property bool isOpen;

- (void) animateUpAndDown: (BOOL) isUP;

@end
