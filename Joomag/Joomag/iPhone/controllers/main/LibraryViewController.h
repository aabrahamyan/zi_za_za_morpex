//
//  LibraryViewController.h
//  Joomag
//
//  Created by Armen Abrahamyan on 7/19/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LibraryViewController : UIViewController {
    
@protected
    UIView   *topBar;
    UILabel  *topBarTitleLabel;
    UIView   *filterLabels;
    UIView   *loginContainer;
    UILabel  *loginText;
    UIButton *joomagButton;
    UILabel  *orLabel;
    UIButton *fbButton;
    UIButton *twitterButton;
}
@end
