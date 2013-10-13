//
//  SettingsViewController_iPad.h
//  Joomag
//
//  Created by Armen Abrahamyan on 7/19/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController_iPad : SettingsViewController <UITextFieldDelegate>

@property (nonatomic, strong) UIImageView * backgroundImageView;
@property (nonatomic, strong) UIView * tabsView;

@property bool isOpen;
- (void) animateUpAndDown: (BOOL) isUP;

@end
