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

- (void) animateDown {
    [self animateUpAndDown:NO];
}

- (void) loadView {
    [super loadView];
    
    self.backgroundImageView = [[UIImageView alloc] init];
    self.view.userInteractionEnabled = YES;
    self.backgroundImageView.userInteractionEnabled = YES;    
    self.view = self.backgroundImageView;
    
    self.tabsView = [[UIView alloc] init];
    
    //--------------- Draw Here -----------------//

    closeButtonView = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButtonView setImage:[Util imageNamedSmart:@"closeButton"] forState:UIControlStateNormal];
    [closeButtonView setImage:[Util imageNamedSmart:@"closeButton"] forState:UIControlStateSelected];
    [closeButtonView setImage:[Util imageNamedSmart:@"closeButton"] forState:UIControlStateHighlighted];
    closeButtonView.showsTouchWhenHighlighted = YES;
    [closeButtonView addTarget:self action:@selector(animateDown) forControlEvents:UIControlEventTouchUpInside];
    
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
    accountSettingsButton.tag = 8765432;
    [accountSettingsButton addTarget:self action:@selector(toggleButtons:) forControlEvents:UIControlEventTouchUpInside];

    [accountSettingsButton setTitle:@"Account Settings" forState:UIControlStateNormal];
    [accountSettingsButton setTitle:@"Account Settings" forState:UIControlStateSelected];
    [accountSettingsButton setTitle:@"Account Settings" forState:UIControlStateHighlighted];
    
    [accountSettingsButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [accountSettingsButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [accountSettingsButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [accountSettingsButton setSelected:YES];
 
    [self.tabsView addSubview:accountSettingsButton];
    
    
    notificationSettingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    notificationSettingsButton.backgroundColor = [UIColor clearColor];
    notificationSettingsButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    notificationSettingsButton.tag = 8765431;
    [notificationSettingsButton addTarget:self action:@selector(toggleButtons:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [notificationSettingsButton setTitle:@"Notification Settings" forState:UIControlStateNormal];
    [notificationSettingsButton setTitle:@"Notification Settings" forState:UIControlStateSelected];
    [notificationSettingsButton setTitle:@"Notification Settings" forState:UIControlStateHighlighted];
    
    [notificationSettingsButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [notificationSettingsButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [notificationSettingsButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [self.tabsView addSubview:notificationSettingsButton];
    
    
    aboutJoomagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    aboutJoomagButton.backgroundColor = [UIColor clearColor];
    aboutJoomagButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    aboutJoomagButton.tag = 8765430;
    [aboutJoomagButton addTarget:self action:@selector(toggleButtons:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [aboutJoomagButton setTitle:@"About Joomag" forState:UIControlStateNormal];
    [aboutJoomagButton setTitle:@"About Joomag" forState:UIControlStateSelected];
    [aboutJoomagButton setTitle:@"About Joomag" forState:UIControlStateHighlighted];
    
    [aboutJoomagButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [aboutJoomagButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [aboutJoomagButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [self.tabsView addSubview:aboutJoomagButton];
    
    helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    helpButton.backgroundColor = [UIColor clearColor];
    helpButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];    
    helpButton.tag = 8765439;
    [helpButton addTarget:self action:@selector(toggleButtons:) forControlEvents:UIControlEventTouchUpInside];
    
    [helpButton setTitle:@"Help" forState:UIControlStateNormal];
    [helpButton setTitle:@"Help" forState:UIControlStateSelected];
    [helpButton setTitle:@"Help" forState:UIControlStateHighlighted];
    
    [helpButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [helpButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [helpButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [self.tabsView addSubview:helpButton];
    
    restoreItunes = [UIButton buttonWithType:UIButtonTypeCustom];
    restoreItunes.backgroundColor = [UIColor clearColor];
    restoreItunes.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    restoreItunes.titleLabel.numberOfLines = 2;
    restoreItunes.tag = 8765438;
    [restoreItunes addTarget:self action:@selector(toggleButtons:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [restoreItunes setTitle:@"Restore iTunes Purchases" forState:UIControlStateNormal];
    [restoreItunes setTitle:@"Restore iTunes Purchases" forState:UIControlStateSelected];
    [restoreItunes setTitle:@"Restore iTunes Purchases" forState:UIControlStateHighlighted];
    
    [restoreItunes setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [restoreItunes setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [restoreItunes setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [self.tabsView addSubview:restoreItunes];
    
    [self.view addSubview:self.tabsView];
    
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
    
    retypeLabel = [[UILabel alloc] init];
    retypeLabel.font = [UIFont boldSystemFontOfSize:17.5];
    retypeLabel.textColor = [UIColor grayColor];
    retypeLabel.backgroundColor = [UIColor clearColor];
    retypeLabel.text = @"Retype:";
    
    [registrationView addSubview:retypeLabel];
    
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
    
    self.tmpDesc = [[UIImageView alloc] initWithImage:[Util imageNamedSmart:@"desc"]];
    
    [registrationView addSubview: self.tmpDesc];
    
    [self.view addSubview:registrationView];
    
    self.isOpen = NO;
}


- (void) animateUpAndDown: (BOOL) isUP {
    
    if(isUP) {
        self.isOpen = YES;
        
        NSLog(@"settings isOpen animate w: %f h: %f", self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView beginAnimations:@"popingUP" context:nil];
        self.view.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView setAnimationDuration:1.0];
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView commitAnimations];
        
        
        
        
    } else {
        self.isOpen = NO;
        
        NSLog(@"settings close animate w: %f h: %f", self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView beginAnimations:@"popingUP" context:nil];

        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [UIView setAnimationDuration:1.0];
        self.view.frame = CGRectMake(0, 1024, self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView commitAnimations];
    }
    
}
//TODO: CHANGE LATER !!!!! A>A>
- (void) updateFramesForiPad {   
    
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

- (void) createAboutView {
    tmpAbout = [[UIImageView alloc] initWithImage:[Util imageNamedSmart:@"aboutJoomag"]];
    tmpAbout.frame = CGRectMake(336, 105, 584, 470);
    [self.view addSubview:tmpAbout];
}

- (void) toggleButtons: (id) target {
    NSInteger buttonTag = ((UIButton *)target).tag;
    
    switch (buttonTag) {
        case 8765432:
            [accountSettingsButton setSelected:YES];
            [notificationSettingsButton setSelected:NO];
            [aboutJoomagButton setSelected:NO];
            [restoreItunes setSelected:NO];
            [helpButton setSelected:NO];
            
            if(tmpAbout) {
                [tmpAbout removeFromSuperview];
                tmpAbout = nil;
            }
            
            [self constructRegistrationView];
            [self updateFramesForiPad];
            
            break;
        case 8765431:
            [accountSettingsButton setSelected:NO];
            [notificationSettingsButton setSelected:YES];
            [aboutJoomagButton setSelected:NO];
            [restoreItunes setSelected:NO];
            [helpButton setSelected:NO];
            
            break;
            
        case 8765430:
            [accountSettingsButton setSelected:NO];
            [notificationSettingsButton setSelected:NO];
            [aboutJoomagButton setSelected:YES];
            [restoreItunes setSelected:NO];
            [helpButton setSelected:NO];
            
            if(registrationView) {
                [registrationView removeFromSuperview];
                registrationView = nil;
            }
            [self createAboutView];
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
