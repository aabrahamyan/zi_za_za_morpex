//
//  LibraryViewController.h
//  Joomag
//
//  Created by Armen Abrahamyan on 7/19/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerView.h"
#import "MyLIbMagazinesTabelView.h"
#import "ResponseTrackerDelegate.h"
#import "PickerViewTitle.h"
#import "PickerViewDate.h"

@interface LibraryViewController : UIViewController <ResponseTrackerDelegate, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource> {
    
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
    MyLIbMagazinesTabelView *magazinesTableView;
    PickerViewTitle         *pickerViewTitle;
    PickerViewDate          *pickerViewDate;
}

@end
