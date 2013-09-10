//
//  SettingsViewController_iPad.m
//  Joomag
//
//  Created by Armen Abrahamyan on 7/19/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "SettingsViewController_iPad.h"

@interface SettingsViewController_iPad ()

@end

@implementation SettingsViewController_iPad

- (void)loadView {
    [super loadView];
    
    self.view.frame = CGRectMake(0, 1024, 1024, 768);
    
    closeButtonView.frame = CGRectMake(15, 15, 18, 16);
    gearView.frame = CGRectMake(60, 13, 20, 18);
    settingsLabel.frame = CGRectMake(93, 13, 100, 20);
    
    
    accountSettingsButton.frame = CGRectMake(0, 0, 180, 20);
    accountSettingsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    notificationSettingsButton.frame = CGRectMake(0, 60, 190, 20);
    notificationSettingsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    aboutJoomagButton.frame = CGRectMake(0, 115, 180, 20);
    aboutJoomagButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    helpButton.frame = CGRectMake(0, 165, 180, 20);
    helpButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    restoreItunes.frame = CGRectMake(0, 220, 120, 20);
    helpButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    //-------------- Construct Registration View -----------------//
    registrationView.frame = CGRectMake(278, 122, 700, 400);
    joinJoomag.frame = CGRectMake(0, 1, 150, 20);
    
    genericBackgroundImage.frame = CGRectMake(0, 54, 287, 44);
    emailLabel.frame = CGRectMake(5, 64, 80, 20);
    emailTextField.frame = CGRectMake(105, 63, 165, 20);
    
    passBg.frame = CGRectMake(0, 111, 287, 44);
    passBgRepeat.frame = CGRectMake(0, 155, 287, 44);
    
    passwordLabel.frame = CGRectMake(5, 121, 100, 20);
    passwordTextField.frame = CGRectMake(104, 120, 180, 20);
    
    retypeLabel.frame = CGRectMake(5, 165, 80, 20);
    passwordTextFieldRepeat.frame = CGRectMake(105, 164, 155, 20);
    
    termsOfService.frame = CGRectMake(200, 270, 120, 20);
    
    submitButton.frame = CGRectMake(0, 242, 175, 44);
    
}

@end
