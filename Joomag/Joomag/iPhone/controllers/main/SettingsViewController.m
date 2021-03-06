//
//  SettingsViewController.m
//  Joomag
//
//  Created by Armen Abrahamyan on 7/19/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "SettingsViewController.h"
#import "Util.h"
#import "HelpView.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void) loadView {
    [super loadView];
    
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
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
    
    //self.isOpen = NO;
}


- (void) animateUpAndDown: (BOOL) isUP {
    
    if(isUP) {
        self.isOpen = YES;

        [UIView beginAnimations:@"popingUP" context:nil];
        self.view.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView setAnimationDuration:1.0];
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView commitAnimations];
        
    } else {
        self.isOpen = NO;
        
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
    passwordTextFieldRepeat.frame = CGRectMake(105, 264, 155, 20);
    
    termsOfService.frame = CGRectMake(200, 270, 120, 20);
    
    submitButton.frame = CGRectMake(0, 242, 175, 44);
}

- (void) createAboutView {
    tmpAbout = [[UIImageView alloc] initWithImage:[Util imageNamedSmart:@"aboutJoomag"]];
    
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
            
            if (notificationContainer) {
                [notificationContainer removeFromSuperview];
                notificationContainer = nil;
            }
            
            if (helpView) {
                [helpView removeFromSuperview];
                helpView = nil;
            }
            
            if (restoreView) {
                [restoreView removeFromSuperview];
                restoreView = nil;
            }
            
            [self constructRegistrationView];
            //[self updateFramesForiPad];
            
            break;
        case 8765431:
            [accountSettingsButton setSelected:NO];
            [notificationSettingsButton setSelected:YES];
            [aboutJoomagButton setSelected:NO];
            [restoreItunes setSelected:NO];
            [helpButton setSelected:NO];
            
            if(registrationView) {
                [registrationView removeFromSuperview];
                registrationView = nil;
                self.tmpDesc = nil;
            }
            
            if (tmpAbout) {
                [tmpAbout removeFromSuperview];
                tmpAbout = nil;
            }
            
            if (helpView) {
                [helpView removeFromSuperview];
                helpView = nil;
            }
            
            if (restoreView) {
                [restoreView removeFromSuperview];
                restoreView = nil;
            }
            
            [self createNotificationSettingsView];
            
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
                self.tmpDesc = nil;
            }
            
            if (notificationContainer) {
                [notificationContainer removeFromSuperview];
                notificationContainer = nil;
            }
            
            if (helpView) {
                [helpView removeFromSuperview];
                helpView = nil;
            }
            
            if (restoreView) {
                [restoreView removeFromSuperview];
                restoreView = nil;
            }
            
            [self createAboutView];
            break;

        case 8765439:
            
            [helpButton setSelected:YES];
            
            [accountSettingsButton setSelected:NO];
            [notificationSettingsButton setSelected:NO];
            [aboutJoomagButton setSelected:NO];
            [restoreItunes setSelected:NO];
            
            
            if(registrationView) {
                [registrationView removeFromSuperview];
                registrationView = nil;
                self.tmpDesc = nil;
            }
            
            if (notificationContainer) {
                [notificationContainer removeFromSuperview];
                notificationContainer = nil;
            }
            
            if (tmpAbout) {
                [tmpAbout removeFromSuperview];
                tmpAbout = nil;
            }
            
            if (restoreView) {
                [restoreView removeFromSuperview];
                restoreView = nil;
            }
            
            [self createHelpView];
        
            break;
            
        case 8765438:
            [accountSettingsButton setSelected:NO];
            [notificationSettingsButton setSelected:NO];
            [aboutJoomagButton setSelected:NO];
            [restoreItunes setSelected:YES];
            [helpButton setSelected:NO];
            
            if(registrationView) {
                [registrationView removeFromSuperview];
                registrationView = nil;
                self.tmpDesc = nil;
            }
            
            if (notificationContainer) {
                [notificationContainer removeFromSuperview];
                notificationContainer = nil;
            }
            
            if (tmpAbout) {
                [tmpAbout removeFromSuperview];
                tmpAbout = nil;
            }
            
            if (helpView) {
                [helpView removeFromSuperview];
                helpView = nil;
            }
            
            [self createRestoreItunes];
            
            break;
            
        default:
            break;
    }
}

- (void) notificationCheckboxClicked:(id) sender {
    
    NSLog(@"notificationCheckboxSelected");
    
    UIButton *button = (UIButton *)sender;
    int buttonTag = button.tag;
    
    switch (buttonTag) {
        case 8503218:
            
            //New Issues CheckBox Handler
            if (button.isSelected) {
                [button setSelected: NO];
            } else {
                [button setSelected: YES];
            }
            
            break;
            
        case 8503213:
            
            //Renewals CheckBox Handler
            if (button.isSelected) {
                [button setSelected: NO];
            } else {
                [button setSelected: YES];
            }
            
            break;
            
        default:
                break;
    }
}

- (void) createNotificationSettingsView {
    notificationContainer = [[UIView alloc] initWithFrame:CGRectMake(270, 138, 440, 222)];
    
 
    mainTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 26)];
    mainTitle.backgroundColor = [UIColor clearColor];
    mainTitle.font = [UIFont fontWithName:@"proximanovabold" size:26.0f];
    mainTitle.textColor = [UIColor whiteColor];
    mainTitle.text = @"Manage Notification Settings";
    [notificationContainer addSubview:mainTitle];
    
    mainSubTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 320, 40)];
    mainSubTitle.backgroundColor = [UIColor clearColor];
    mainSubTitle.font = [UIFont systemFontOfSize:12.0f];//[UIFont fontWithName:@"proximanovathin" size:10.0f];
    mainSubTitle.textColor = [UIColor whiteColor];
    mainSubTitle.numberOfLines = 2;
    mainSubTitle.text = @"Visit the iOS Settings menu to enable and disable Push Notifications for Joomag";
    [notificationContainer addSubview:mainSubTitle];

    newIssues = [[UILabel alloc] initWithFrame:CGRectMake(0, mainSubTitle.frame.origin.y + 70, 220, 26)];
    newIssues.backgroundColor = [UIColor clearColor];
    newIssues.font = [UIFont fontWithName:@"proximanovabold" size:26.0f];
    newIssues.textColor = [UIColor whiteColor];
    newIssues.text = @"New Issues";
    [notificationContainer addSubview:newIssues];
    
    newIssuesDetails = [[UILabel alloc] initWithFrame:CGRectMake(0, newIssues.frame.origin.y + 10, 220, 40)];
    newIssuesDetails.backgroundColor = [UIColor clearColor];
    newIssuesDetails.font = [UIFont systemFontOfSize:12.0f];//[UIFont fontWithName:@"proximanovathin" size:10.0f];
    newIssuesDetails.textColor = [UIColor grayColor];
    newIssuesDetails.numberOfLines = 1;
    newIssuesDetails.text = @"Alert me when new issues are available.";
    [notificationContainer addSubview:newIssuesDetails];
    
    
    renewals = [[UILabel alloc] initWithFrame:CGRectMake(0, newIssuesDetails.frame.origin.y + 40, 220, 26)];
    renewals.backgroundColor = [UIColor clearColor];
    renewals.font = [UIFont fontWithName:@"proximanovabold" size:26.0f];
    renewals.textColor = [UIColor whiteColor];
    renewals.text = @"Renewals";

    [notificationContainer addSubview:renewals];
    
    renewalsDetails = [[UILabel alloc] initWithFrame:CGRectMake(0, renewals.frame.origin.y + 10, 280, 40)];
    renewalsDetails.backgroundColor = [UIColor clearColor];
    renewalsDetails.font = [UIFont systemFontOfSize:12.0f];//[UIFont fontWithName:@"proximanovathin" size:10.0f];
    renewalsDetails.textColor = [UIColor grayColor];
    renewalsDetails.numberOfLines = 1;
    renewalsDetails.text = @"Alert me when I am near the end of subscription.";    
    [notificationContainer addSubview:renewalsDetails];
    
    UIButton *checkboxNewIssues = [UIButton buttonWithType:UIButtonTypeCustom];
    checkboxNewIssues.frame = CGRectMake(351,newIssues.frame.origin.y + 5,50,50);
    checkboxNewIssues.backgroundColor = [UIColor clearColor];
    [checkboxNewIssues setImage:[UIImage imageNamed:@"notselectedcheckbox.png"] forState:UIControlStateNormal];
    [checkboxNewIssues setImage:[UIImage imageNamed:@"selectedcheckbox.png"] forState:UIControlStateSelected];
    [checkboxNewIssues setImage:[UIImage imageNamed:@"selectedcheckbox.png"] forState:UIControlStateHighlighted];
    checkboxNewIssues.adjustsImageWhenHighlighted=YES;
    checkboxNewIssues.userInteractionEnabled = YES;
    [checkboxNewIssues setSelected: NO];
    checkboxNewIssues.tag = 8503218;
    [checkboxNewIssues addTarget:self  action:@selector(notificationCheckboxClicked:) forControlEvents:UIControlEventTouchDown];
    
    [notificationContainer addSubview: checkboxNewIssues];
    
    UIButton * checkboxRenewals = [UIButton buttonWithType:UIButtonTypeCustom];
    checkboxRenewals.frame = CGRectMake(351,renewals.frame.origin.y + 5,50,50);
    checkboxRenewals.backgroundColor = [UIColor clearColor];
    [checkboxRenewals setImage:[UIImage imageNamed:@"notselectedcheckbox.png"] forState:UIControlStateNormal];
    [checkboxRenewals setImage:[UIImage imageNamed:@"selectedcheckbox.png"] forState:UIControlStateSelected];
    [checkboxRenewals setImage:[UIImage imageNamed:@"selectedcheckbox.png"] forState:UIControlStateHighlighted];
    checkboxRenewals.adjustsImageWhenHighlighted=YES;
    checkboxRenewals.userInteractionEnabled = YES;
    [checkboxRenewals setSelected: YES];
    checkboxRenewals.tag = 8503213;
    
    [checkboxRenewals addTarget:self  action:@selector(notificationCheckboxClicked:) forControlEvents:UIControlEventTouchDown];

    
    [notificationContainer addSubview: checkboxRenewals];

    
    [self.view addSubview:notificationContainer];

}

- (void) createHelpView {
    helpView = [[HelpView alloc] initWithFrame:CGRectMake(287, 107, 412, 800)];
    
    [self.view addSubview:helpView];    
    [helpView redrawData];
}

- (void) createRestoreItunes {
    
    restoreView = [[UIView alloc] initWithFrame:CGRectMake(287, 107, 320, 181)];
    
    UILabel * titleLbl = [[UILabel alloc] init];
    titleLbl.backgroundColor = [UIColor clearColor];
    titleLbl.text = @"Restore iTunes Purchases";
    titleLbl.font = [UIFont systemFontOfSize:21.0f];

    titleLbl.frame = CGRectMake(60, 0, 320, 27);
    titleLbl.numberOfLines = NSIntegerMax;
    titleLbl.textColor = [UIColor whiteColor];
    
    [restoreView addSubview:titleLbl];
    
    UILabel * textLbl = [[UILabel alloc] init];
    textLbl.backgroundColor = [UIColor clearColor];
    textLbl.text = @"Lorem ipsum, dolor amet, Lorem ipsum, dolor ametLorem ipsum, dolor ametLorem ipsum, dolor ametLorem ipsum, dolor amet";
    textLbl.font = [UIFont systemFontOfSize:16.0f];
    textLbl.frame = [Util calculateLabelFrame:textLbl];    
    textLbl.frame = CGRectMake(40, 42, 320, textLbl.frame.size.height + 50);
    textLbl.numberOfLines = NSIntegerMax;
    textLbl.textColor = [UIColor grayColor];
    
    [restoreView addSubview:textLbl];
    
    UIButton * restoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    restoreButton.frame = CGRectMake(113,139,150,39);
    restoreButton.userInteractionEnabled = YES;
    
    [restoreButton setBackgroundImage:[Util imageNamedSmart:@"redBgButton"] forState:UIControlStateNormal];
    [restoreButton setBackgroundImage:[Util imageNamedSmart:@"redBgButton"] forState:UIControlStateSelected];
    [restoreButton setBackgroundImage:[Util imageNamedSmart:@"redBgButton"] forState:UIControlStateHighlighted];
    restoreButton.showsTouchWhenHighlighted = YES;
    [restoreButton setTitle:@"Restore" forState:UIControlStateNormal];



    
    [restoreView addSubview:restoreButton];
    
    [self.view addSubview:restoreView];
}
*/

@end
