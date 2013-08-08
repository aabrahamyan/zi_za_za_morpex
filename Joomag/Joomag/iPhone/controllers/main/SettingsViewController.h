//
//  SettingsViewController.h
//  Joomag
//
//  Created by Armen Abrahamyan on 7/19/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController<UITextFieldDelegate> {
    UIButton * closeButtonView;
    UIImageView * gearView;
    UILabel * settingsLabel;
    UIButton * accountSettingsButton;
    UIButton * notificationSettingsButton;
    UIButton * aboutJoomagButton;
    UIButton * helpButton;
    UIButton * restoreItunes;
    
    UILabel * joinJoomag;
    
    UIImageView * genericBackgroundImage;
    
    UILabel * emailLabel;
    UILabel * passwordLabel;
    UILabel * retypeLabel;
    
    UIButton * submitButton;
    
    UILabel * termsOfService;
    
    UIButton * signInButton;
    
    UILabel * descriptionLabel;
    
    //--------- Tabs Container ---------------//
    UIView * tabsView;
    //--------- Registration View ------------//
    UIView * registrationView;
    UITextField * emailTextField;
    UIImageView * passBg;
    UIImageView * passBgRepeat;
    UITextField * passwordTextField;
    UITextField * passwordTextFieldRepeat;
    
    UIImageView * tmpDesc;
    UIImageView * tmpAbout;

}

@property (nonatomic, strong) UIImageView * backgroundImageView;



- (void) animateUpAndDown: (BOOL) isUP;

@end
