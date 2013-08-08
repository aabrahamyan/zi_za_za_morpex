//
//  SettingsViewController.m
//  Joomag
//
//  Created by Armen Abrahamyan on 7/19/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "SettingsViewController.h"
#import "Util.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void) loadView {
    [super loadView];
    
    self.backgroundImageView = [[UIImageView alloc] initWithImage:[Util imageNamedSmart:@"realSettingsBG"]];
    self.view.userInteractionEnabled = YES;
    self.backgroundImageView.userInteractionEnabled = YES;    
    self.view = self.backgroundImageView;
    
    tabsView = [[UIView alloc] init];
    tabsView.frame = CGRectMake(50, 122, 186, 247);
    
    //--------------- Draw Here -----------------//
    closeButtonView = [[UIImageView alloc] initWithImage:[Util imageNamedSmart:@"closeButton"]];
    gearView = [[UIImageView alloc] initWithImage:[Util imageNamedSmart:@"gear"]];
    
    settingsLabel = [[UILabel alloc] init];
    settingsLabel.font = [UIFont boldSystemFontOfSize:20.0];
    settingsLabel.textColor = [UIColor grayColor];
    settingsLabel.backgroundColor = [UIColor clearColor];
    settingsLabel.text = @"Settings";
    
    signInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [signInButton setImage:[Util imageNamedSmart:@"signInButton"] forState:UIControlStateNormal];
    [signInButton setImage:[Util imageNamedSmart:@"signInButton"] forState:UIControlStateSelected];
    [signInButton setImage:[Util imageNamedSmart:@"signInButton"] forState:UIControlStateHighlighted];
    signInButton.showsTouchWhenHighlighted = YES;
    
    [self.view addSubview:closeButtonView];
    [self.view addSubview:gearView];
    [self.view addSubview:settingsLabel];
    [self.view addSubview:signInButton];

    accountSettingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    accountSettingsButton.backgroundColor = [UIColor clearColor]; 
    accountSettingsButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];



    [accountSettingsButton setTitle:@"Account Settings" forState:UIControlStateNormal];
    [accountSettingsButton setTitle:@"Account Settings" forState:UIControlStateSelected];
    [accountSettingsButton setTitle:@"Account Settings" forState:UIControlStateHighlighted];
    
    [accountSettingsButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [accountSettingsButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [accountSettingsButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [accountSettingsButton setSelected:YES];
 
    [tabsView addSubview:accountSettingsButton];
    
    
    notificationSettingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    notificationSettingsButton.backgroundColor = [UIColor clearColor];
    notificationSettingsButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    
    
    
    [notificationSettingsButton setTitle:@"Notification Settings" forState:UIControlStateNormal];
    [notificationSettingsButton setTitle:@"Notification Settings" forState:UIControlStateSelected];
    [notificationSettingsButton setTitle:@"Notification Settings" forState:UIControlStateHighlighted];
    
    [notificationSettingsButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [notificationSettingsButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [notificationSettingsButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [tabsView addSubview:notificationSettingsButton];
    
    
    aboutJoomagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    aboutJoomagButton.backgroundColor = [UIColor clearColor];
    aboutJoomagButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    
    
    
    [aboutJoomagButton setTitle:@"About Joomag" forState:UIControlStateNormal];
    [aboutJoomagButton setTitle:@"About Joomag" forState:UIControlStateSelected];
    [aboutJoomagButton setTitle:@"About Joomag" forState:UIControlStateHighlighted];
    
    [aboutJoomagButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [aboutJoomagButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [aboutJoomagButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [tabsView addSubview:aboutJoomagButton];
    
    helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    helpButton.backgroundColor = [UIColor clearColor];
    helpButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    
    
    
    [helpButton setTitle:@"Help" forState:UIControlStateNormal];
    [helpButton setTitle:@"Help" forState:UIControlStateSelected];
    [helpButton setTitle:@"Help" forState:UIControlStateHighlighted];
    
    [helpButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [helpButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [helpButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [tabsView addSubview:helpButton];
    
    restoreItunes = [UIButton buttonWithType:UIButtonTypeCustom];
    restoreItunes.backgroundColor = [UIColor clearColor];
    restoreItunes.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    restoreItunes.titleLabel.numberOfLines = 2;
    
    
    [restoreItunes setTitle:@"Restore iTunes Purchases" forState:UIControlStateNormal];
    [restoreItunes setTitle:@"Restore iTunes Purchases" forState:UIControlStateSelected];
    [restoreItunes setTitle:@"Restore iTunes Purchases" forState:UIControlStateHighlighted];
    
    [restoreItunes setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [restoreItunes setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [restoreItunes setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [tabsView addSubview:restoreItunes];
    
    [self.view addSubview:tabsView];
    
    [self constructRegistrationView];
}

- (void) constructRegistrationView {
    
    registrationView = [[UIView alloc] init];
    
    joinJoomag = [[UILabel alloc] init];
    joinJoomag.font = [UIFont boldSystemFontOfSize:17.5];
    joinJoomag.textColor = [UIColor grayColor];
    joinJoomag.backgroundColor = [UIColor clearColor];
    joinJoomag.text = @"Join Joomag!";
    
    [registrationView addSubview:joinJoomag];
    
    genericBackgroundImage = [[UIImageView alloc] initWithImage:[Util imageNamedSmart:@"settingsTextFieldBG"]];
    
    [registrationView addSubview:genericBackgroundImage];
    
    emailLabel = [[UILabel alloc] init];
    emailLabel.font = [UIFont boldSystemFontOfSize:17.5];
    emailLabel.textColor = [UIColor grayColor];
    emailLabel.backgroundColor = [UIColor clearColor];
    emailLabel.text = @"Email:";
    
    [registrationView addSubview:emailLabel];
    
    emailTextField = [[UITextField alloc] init];
    emailTextField.font = [UIFont systemFontOfSize:17.5] ;
	emailTextField.returnKeyType = UIReturnKeyDone;
    emailTextField.backgroundColor = [UIColor clearColor];
	emailTextField.delegate = self;
    emailTextField.placeholder = @"Required";
	emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
	emailTextField.borderStyle = UITextBorderStyleNone;
	emailTextField.textColor = [UIColor whiteColor];
	emailTextField.tag = 90903331;
    
    [registrationView addSubview:emailTextField];
    
    
    passBg = [[UIImageView alloc] initWithImage:[Util imageNamedSmart:@"settingsTextFieldBG"]];    
    [registrationView addSubview:passBg];
    
    passwordLabel = [[UILabel alloc] init];
    passwordLabel.font = [UIFont boldSystemFontOfSize:17.5];
    passwordLabel.textColor = [UIColor grayColor];
    passwordLabel.backgroundColor = [UIColor clearColor];
    passwordLabel.text = @"Password:";
    
    [registrationView addSubview:passwordLabel];
    
    passwordTextField = [[UITextField alloc] init];
	passwordTextField.backgroundColor = [UIColor clearColor];
    passwordTextField.font = [UIFont systemFontOfSize:17.5] ;
	passwordTextField.returnKeyType = UIReturnKeyDone;
	passwordTextField.delegate = self;
	passwordTextField.secureTextEntry = YES;
    passwordTextField.placeholder = @"Required";
	passwordTextField.borderStyle = UITextBorderStyleNone;
	passwordTextField.textColor = [UIColor whiteColor];
	passwordTextField.tag = 90903332;
    
    [registrationView addSubview:passwordTextField];
    
    passBgRepeat = [[UIImageView alloc] initWithImage:[Util imageNamedSmart:@"settingsTextFieldBG"]];
    [registrationView addSubview:passBgRepeat];
    
    passwordTextFieldRepeat = [[UITextField alloc] init];
	passwordTextFieldRepeat.backgroundColor = [UIColor clearColor];
    passwordTextFieldRepeat.font = [UIFont systemFontOfSize:17.5] ;
	passwordTextFieldRepeat.returnKeyType = UIReturnKeyDone;
	passwordTextFieldRepeat.delegate = self;
	passwordTextFieldRepeat.secureTextEntry = YES;
    passwordTextFieldRepeat.placeholder = @"Required";
	passwordTextFieldRepeat.borderStyle = UITextBorderStyleNone;
	passwordTextFieldRepeat.textColor = [UIColor whiteColor];
	passwordTextFieldRepeat.tag = 90903332;
    
    [registrationView addSubview:passwordTextFieldRepeat];
    
    submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setImage:[Util imageNamedSmart:@"submitSettings"] forState:UIControlStateNormal];
    [submitButton setImage:[Util imageNamedSmart:@"submitSettings"] forState:UIControlStateSelected];
    [submitButton setImage:[Util imageNamedSmart:@"submitSettings"] forState:UIControlStateHighlighted];
    submitButton.showsTouchWhenHighlighted = YES;
    
    [registrationView addSubview:submitButton];
    
    termsOfService = [[UILabel alloc] init];
    termsOfService.font = [UIFont boldSystemFontOfSize:12];
    termsOfService.textColor = [UIColor redColor];
    termsOfService.backgroundColor = [UIColor clearColor];
    termsOfService.text = @"Terms of Service";
    
    [registrationView addSubview:termsOfService];
    
    [self.view addSubview:registrationView];
    
}


- (void) animateUpAndDown: (BOOL) isUP {
    
    if(isUP) {
        [UIView beginAnimations:@"popingUP" context:nil];
        self.view.frame = CGRectMake(0, 1024, 1024, 768);
        
        [UIView setAnimationDuration:1.0];
        self.view.frame = CGRectMake(0, 0, 1024, 768);
        
        [UIView commitAnimations];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
