//
//  BookMarkViewController_iPad.h
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-09-09.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "BookMarkViewController.h"

@interface BookMarkViewController_iPad : BookMarkViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
    
@protected
    UIView   *topBar;
    UILabel  *topBarTitleLabel;
    UIView   *filterLabels;
    UIButton *closeButtonView;
    UIView   *noBookMarksContainer;
    UIScrollView *bookMarksScrollView;
}

@property (nonatomic, strong) UITableView *bookMarkTable;

@end
