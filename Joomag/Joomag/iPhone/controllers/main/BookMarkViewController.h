//
//  BookMarkViewController.h
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-09-09.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookMarkViewController : UIViewController {

@protected
    UIView   *topBar;
    UILabel  *topBarTitleLabel;
    UIView   *filterLabels;
    UIButton *closeButtonView;
    UIView   *noBookMarksContainer;
    UIScrollView *bookMarksScrollView;
    bool isOpen;
}

- (void) animateUpAndDown: (BOOL) isUP;

@end
