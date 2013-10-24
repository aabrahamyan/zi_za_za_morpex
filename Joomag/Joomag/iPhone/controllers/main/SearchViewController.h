//
//  SearchViewController.h
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-08-18.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UITextFieldDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate> {
@protected
    UIView       *topView;
    UIButton     *closeButton;
    UIScrollView *searchScrollView;
    UIView       *searchBarView;
}

@end
