//
//  MoreViewController.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-09-20.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "MoreViewController.h"
#import "Util.h"

@interface MoreViewController () {
    UILabel  *topBarTitleLabel;
    UIButton *backButton;
    UIView   *changePasswordView;
    UIView   *restorePurschasesView;
    UIView   *signOutView;
    
    UIView   *notificationView;
}

@end

@implementation MoreViewController

- (void)loadView {
    NSLog(@"More View");
    
    [super loadView];
    
    self.view.backgroundColor = RGBA(49, 49, 49, 1);
    
    //-------------------------------- BG Image -------------------------------
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,
                                                                             self.view.frame.size.height)];
    bgImageView.image = [UIImage imageNamed:@"moreBG.png"];
    
    [self.view addSubview: bgImageView];
    
    //-------------------------------- Top Bar ------------------------------------
    UIView *topBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topTabBarBg.png"]];
    [topBar addSubview:backgroundView];
    [topBar sendSubviewToBack: backgroundView];
    [self.view addSubview: topBar];
    
    //-------------------------------- Top Bar Title ------------------------------------
    topBarTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    topBarTitleLabel.backgroundColor = [UIColor clearColor];
    topBarTitleLabel.textAlignment = NSTextAlignmentCenter;
    topBarTitleLabel.textColor = [UIColor whiteColor];
    topBarTitleLabel.text = @"More";
    
    [topBar addSubview: topBarTitleLabel];
    
    //-------------------------------- TABS ---------------------------------
    [self.view addSubview: [self constructTabsWithTitle: @"BookMarks"
                                                  frame: CGRectMake(20, 60, 88, 20)
                                                    tag: 1111111
                                            andSelector: @selector(bookmarksHandler)]
    ];
    
    [self.view addSubview: [self constructTabsWithTitle: @"Change Password"
                                                  frame: CGRectMake(20, 95, 140, 20)
                                                    tag:2222222
                                            andSelector: @selector(cunstructChangePasswordView)]
     ];
    
    [self.view addSubview: [self constructTabsWithTitle: @"Notification Settings"
                                                  frame: CGRectMake(20, 130, 157, 20)
                                                    tag:3333333
                                            andSelector: @selector(notificationHandler)]
     ];
    
    [self.view addSubview: [self constructTabsWithTitle: @"Sign Out"
                                                  frame: CGRectMake(20, 165, 67, 20)
                                                    tag:4444444
                                            andSelector: @selector(signOutHandler)]
     ];
    
    [self.view addSubview: [self constructTabsWithTitle: @"Restore iTunes Purchases"
                                                  frame: CGRectMake(20, 200, 202, 20)
                                                    tag:5555555
                                            andSelector: @selector(restorePurschasesHandler)]
     ];
    
    //-------------------------- Close Search Botton -------`----------------------
    backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 46, 44)];
    [backButton addTarget:self  action:@selector(backHandler) forControlEvents:UIControlEventTouchDown];
    [backButton setBackgroundImage: [Util imageNamedSmart:@"backButton"] forState:UIControlStateNormal];
    backButton.hidden = YES;
    
    [topBar addSubview: backButton];
    
    [self cunstructChangePasswordView];
    [self cunstructRestorePurschasesView];
    [self cunstructSignOutView];
    [self cunstructNotificationView];
}

- (UIButton *)constructTabsWithTitle: (NSString *)title
                               frame: (CGRect)frame
                                 tag: (int)tag
                         andSelector: (SEL)selector
{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    btn.titleLabel.font  = [UIFont boldSystemFontOfSize: 16];
    btn.tag = tag;
    [btn setTitle: title forState:UIControlStateNormal];
    [btn setTitle: title forState:UIControlStateSelected];
    [btn setTitle: title forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    
    [btn addTarget: self action: @selector(toggleButtons:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (void) toggleButtons: (id) target {
    UIButton *button = (UIButton *)target;
    NSInteger buttonTag = button.tag;
    backButton.hidden = NO;
    topBarTitleLabel.frame = CGRectMake(46, 0, 320-46, 44);
    
    switch (buttonTag) {
        case 1111111:
            [self bookmarksHandler];
            break;
        case 2222222:
            signOutView.hidden = YES;
            notificationView.hidden = YES;
            restorePurschasesView.hidden = YES;
            topBarTitleLabel.text = @"Change Password";
            changePasswordView.hidden = NO;
            
            break;
            
        case 3333333:
            restorePurschasesView.hidden = YES;
            changePasswordView.hidden = YES;
            signOutView.hidden = YES;
            topBarTitleLabel.text = @"Notification Settings";
            notificationView.hidden = NO;
            
            break;
            
        case 4444444:
            restorePurschasesView.hidden = YES;
            changePasswordView.hidden = YES;
            notificationView.hidden = YES;
            topBarTitleLabel.text = @"Sign Out";
            signOutView.hidden = NO;
            
            break;
            
        case 5555555:
            signOutView.hidden = YES;
            changePasswordView.hidden = YES;
            notificationView.hidden = YES;
            topBarTitleLabel.text = @"Restore iTunes Purchases";
            restorePurschasesView.hidden = NO;

            break;
            
        default:
            break;
    }
}

- (void)backHandler {
    topBarTitleLabel.frame = CGRectMake(0, 0, 320, 44);
    topBarTitleLabel.text = @"More";
    backButton.hidden = YES;
    changePasswordView.hidden = YES;
    restorePurschasesView.hidden = YES;
    signOutView.hidden = YES;
    notificationView.hidden = YES;
}

- (void)cunstructChangePasswordView {

    changePasswordView = [[UIView alloc] initWithFrame: CGRectMake(0, 44, 320, self.view.frame.size.height)];
    changePasswordView.backgroundColor = RGBA(49, 49, 49, 1);
    changePasswordView.hidden = YES;
    
    [self.view addSubview: changePasswordView];
    
    UIImageView *emailBG = [[UIImageView alloc] initWithImage:[Util imageNamedSmart:@"settingsTextFieldBG"]];
    emailBG.frame = CGRectMake(20, 30, 280, 50);
    [changePasswordView addSubview: emailBG];
    
    UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 30, 60, 50)];
    emailLabel.font = [UIFont boldSystemFontOfSize:17.5];
    emailLabel.textColor = [UIColor whiteColor];
    emailLabel.backgroundColor = [UIColor clearColor];
    emailLabel.text = @"Email:";
    
    [changePasswordView addSubview:emailLabel];
    
    UITextField *emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(95, 30, 215, 50)];
    emailTextField.font = [UIFont systemFontOfSize:17.5] ;
	emailTextField.returnKeyType = UIReturnKeyDone;
    emailTextField.backgroundColor = [UIColor clearColor];
	emailTextField.delegate = self;
    emailTextField.placeholder = @"Required";
    emailTextField.textAlignment = NSTextAlignmentCenter;
    emailTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
	emailTextField.borderStyle = UITextBorderStyleNone;
	emailTextField.textColor = [UIColor grayColor];
	emailTextField.tag = 2262071;
    
    [changePasswordView addSubview:emailTextField];
    
    UIImageView *passBg = [[UIImageView alloc] initWithImage:[Util imageNamedSmart:@"settingsTextFieldBG"]];
    passBg.frame = CGRectMake(20, 90, 280, 50);
    [changePasswordView addSubview:passBg];
    
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 90, 90, 50)];
    passwordLabel.font = [UIFont boldSystemFontOfSize:17.5];
    passwordLabel.textColor = [UIColor whiteColor];
    passwordLabel.backgroundColor = [UIColor clearColor];
    passwordLabel.text = @"Password:";
    
    [changePasswordView addSubview:passwordLabel];
    
    UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(95, 90, 215, 50)];
	passwordTextField.backgroundColor = [UIColor clearColor];
    passwordTextField.font = [UIFont systemFontOfSize:17.5] ;
	passwordTextField.returnKeyType = UIReturnKeyDone;
	passwordTextField.delegate = self;
	passwordTextField.secureTextEntry = YES;
    passwordTextField.placeholder = @"Required";
    passwordTextField.textAlignment = NSTextAlignmentCenter;
    passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	passwordTextField.borderStyle = UITextBorderStyleNone;
	passwordTextField.textColor = [UIColor whiteColor];
	passwordTextField.tag = 2262072;
    
    [changePasswordView addSubview:passwordTextField];

    UIImageView *passBgRepeat = [[UIImageView alloc] initWithImage:[Util imageNamedSmart:@"settingsTextFieldBG"]];
    passBgRepeat.frame = CGRectMake(20, 150, 280, 50);
    [changePasswordView addSubview:passBgRepeat];
    
    UILabel *retypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 150, 90, 50)];
    retypeLabel.font = [UIFont boldSystemFontOfSize:17.5];
    retypeLabel.textColor = [UIColor whiteColor];
    retypeLabel.backgroundColor = [UIColor clearColor];
    retypeLabel.text = @"Retype:";
    
    [changePasswordView addSubview:retypeLabel];
    
    UITextField *passwordTextFieldRepeat = [[UITextField alloc] initWithFrame:CGRectMake(95, 150, 215, 50)];
	passwordTextFieldRepeat.backgroundColor = [UIColor clearColor];
    passwordTextFieldRepeat.font = [UIFont systemFontOfSize:17.5] ;
	passwordTextFieldRepeat.returnKeyType = UIReturnKeyDone;
	passwordTextFieldRepeat.delegate = self;
	passwordTextFieldRepeat.secureTextEntry = YES;
    passwordTextFieldRepeat.placeholder = @"Required";
    passwordTextFieldRepeat.textAlignment = NSTextAlignmentCenter;
    passwordTextFieldRepeat.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	passwordTextFieldRepeat.borderStyle = UITextBorderStyleNone;
	passwordTextFieldRepeat.textColor = [UIColor grayColor];
	passwordTextFieldRepeat.tag = 2262073;
    
    [changePasswordView addSubview:passwordTextFieldRepeat];

    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(90, 220, 140, 40);
    [submitButton setImage:[Util imageNamedSmart:@"submitSettings"] forState:UIControlStateNormal];
    [submitButton setImage:[Util imageNamedSmart:@"submitSettings"] forState:UIControlStateSelected];
    [submitButton setImage:[Util imageNamedSmart:@"submitSettings"] forState:UIControlStateHighlighted];
    submitButton.showsTouchWhenHighlighted = YES;
    [submitButton addTarget: self action: @selector(submitHandler) forControlEvents:UIControlEventTouchUpInside];
    
    [changePasswordView addSubview: submitButton];

}

- (void)cunstructRestorePurschasesView {
    
    restorePurschasesView = [[UIView alloc] initWithFrame: CGRectMake(0, 44, 320, self.view.frame.size.height)];
    restorePurschasesView.backgroundColor = RGBA(49, 49, 49, 1);
    restorePurschasesView.hidden = YES;
    
    [self.view addSubview: restorePurschasesView];
    
    UILabel *restoreTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 320, 50)];
    restoreTitle.font = [UIFont boldSystemFontOfSize: 21.0f];
    restoreTitle.textColor = [UIColor whiteColor];
    restoreTitle.alpha = 0.7;
    restoreTitle.textAlignment = NSTextAlignmentCenter;
    restoreTitle.backgroundColor = [UIColor clearColor];
    restoreTitle.text = @"Restore iTunes Purchases";
    
    [restorePurschasesView addSubview: restoreTitle];
    
    UILabel *restoreDesc = [[UILabel alloc] initWithFrame:CGRectMake(20, 90, 280, 100)];
    restoreDesc.font = [UIFont boldSystemFontOfSize: 14.0f];
    restoreDesc.textColor = [UIColor grayColor];
    restoreDesc.alpha = 1;
    restoreDesc.textAlignment = NSTextAlignmentCenter;
    restoreDesc.backgroundColor = [UIColor clearColor];
    restoreDesc.numberOfLines = 4;
    restoreDesc.text = @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the.";
    
    [restorePurschasesView addSubview: restoreDesc];
    
    UIButton *restoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    restoreBtn.frame = CGRectMake(90, 220, 140, 40);
    restoreBtn.backgroundColor = RGBA(214, 77, 76, 1);
    [restoreBtn setTitle:@"Restore" forState:UIControlStateNormal];
    restoreBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [restoreBtn addTarget:self  action:@selector(restorePurschasesHandler) forControlEvents:UIControlEventTouchDown];
    
    [restorePurschasesView addSubview: restoreBtn];
}

- (void)cunstructSignOutView {
   
    signOutView = [[UIView alloc] initWithFrame: CGRectMake(0, 44, 320, self.view.frame.size.height)];
    signOutView.backgroundColor = RGBA(49, 49, 49, 1);
    signOutView.hidden = YES;
    
    [self.view addSubview: signOutView];
    
    UIImageView *logo = [[UIImageView alloc] initWithImage:[Util imageNamedSmart:@"logo"]];
    logo.frame = CGRectMake(100, 40, 120, 70);
    [signOutView addSubview: logo];
    
    UILabel *signOutTitle = [[UILabel alloc] initWithFrame:CGRectMake(70, 140, 180, 50)];
    signOutTitle.font = [UIFont boldSystemFontOfSize: 16.0f];
    signOutTitle.textColor = [UIColor whiteColor];
    signOutTitle.numberOfLines = 2;
    signOutTitle.textAlignment = NSTextAlignmentCenter;
    signOutTitle.backgroundColor = [UIColor clearColor];
    signOutTitle.text = @"Are you sure you want to sign out";
    
    [signOutView addSubview: signOutTitle];
    
    UILabel *signOutDesc = [[UILabel alloc] initWithFrame:CGRectMake(20, 190, 280, 100)];
    signOutDesc.font = [UIFont boldSystemFontOfSize: 16.0f];
    signOutDesc.textColor = [UIColor whiteColor];
    signOutDesc.alpha = 1;
    signOutDesc.textAlignment = NSTextAlignmentCenter;
    signOutDesc.backgroundColor = [UIColor clearColor];
    signOutDesc.numberOfLines = 2;
    signOutDesc.text = @"You will be asked to sign in again to access you Joomag Library.";
    
    [signOutView addSubview: signOutDesc];
    
    UIButton *signOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    signOutBtn.frame = CGRectMake(90, 310, 140, 40);
    signOutBtn.backgroundColor = RGBA(214, 77, 76, 1);
    [signOutBtn setTitle:@"Sign Out" forState:UIControlStateNormal];
    signOutBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [signOutBtn addTarget:self  action:@selector(signOutHandler) forControlEvents:UIControlEventTouchDown];
    
    [signOutView addSubview: signOutBtn];
}

- (void)cunstructNotificationView {
    
    notificationView = [[UIView alloc] initWithFrame: CGRectMake(0, 44, 320, self.view.frame.size.height)];
    notificationView.backgroundColor = RGBA(49, 49, 49, 1);
    notificationView.hidden = YES;
    
    [self.view addSubview: notificationView];
    
    UILabel *notificationTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 300, 50)];
    notificationTitle.font = [UIFont systemFontOfSize: 16.0f];
    notificationTitle.textColor = [UIColor whiteColor];
    notificationTitle.numberOfLines = 2;
    notificationTitle.textAlignment = NSTextAlignmentCenter;
    notificationTitle.backgroundColor = [UIColor clearColor];
    notificationTitle.text = @"Visit the iOS Settings menu to enable and disable Push Notifications for Joomag.";
    
    [notificationView addSubview: notificationTitle];
    
    [notificationView addSubview: [self createLabelsInNotificationViewWithTitle: @"New Issues"
                                                                           desc: @"Alert me when new issues are available."
                                                                          frame: CGRectMake(30, 120, 260, 60)
                                                                         andTag: 55011
    ]];
    
    [notificationView addSubview: [self createLabelsInNotificationViewWithTitle: @"Renewals"
                                                                           desc: @"Alert me when I am near the end of subscription."
                                                                          frame: CGRectMake(30, 200, 260, 60)
                                                                         andTag: 55012
    ]];
    
    [notificationView addSubview: [self createLabelsInNotificationViewWithTitle: @"App Updates"
                                                                           desc: @"Alert me when there are new app updates."
                                                                          frame: CGRectMake(30, 280, 260, 60)
                                                                         andTag: 55013
    ]];
    
}

- (UIView *) createLabelsInNotificationViewWithTitle: (NSString *)title
                                            desc: (NSString *)desc
                                           frame: (CGRect)frame
                                          andTag: (int)tag
{
    UIView *container = [[UIView alloc] initWithFrame: frame];
    container.backgroundColor = [UIColor clearColor];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 120, 20)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize: 20.0f];
    titleLabel.text = title;
    
    [container addSubview: titleLabel];
    
    UILabel * descLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 20, 190, 40)];
    descLabel.backgroundColor = [UIColor clearColor];
    descLabel.textColor = [UIColor grayColor];
    descLabel.textAlignment = NSTextAlignmentLeft;
    descLabel.numberOfLines = 2;
    descLabel.font = [UIFont systemFontOfSize: 14.0f];
    descLabel.text = desc;
    
    [container addSubview: descLabel];
    
    UIButton *checkbox = [UIButton buttonWithType:UIButtonTypeCustom];
    checkbox.frame = CGRectMake(220,10,50,50);
    checkbox.backgroundColor = [UIColor clearColor];
    [checkbox setImage:[UIImage imageNamed:@"notselectedcheckbox.png"] forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageNamed:@"selectedcheckbox.png"] forState:UIControlStateSelected];
    [checkbox setImage:[UIImage imageNamed:@"selectedcheckbox.png"] forState:UIControlStateHighlighted];
    checkbox.adjustsImageWhenHighlighted=YES;
    checkbox.userInteractionEnabled = YES;
    [checkbox setSelected: YES];
    checkbox.tag = tag;
    [checkbox addTarget:self  action:@selector(notificationCheckboxSelected:) forControlEvents:UIControlEventTouchDown];
    
    [container addSubview: checkbox];
    
    return container;
}

-(void)notificationCheckboxSelected:(id)sender
{
    NSLog(@"notificationCheckboxSelected");
    
    UIButton *button = (UIButton *)sender;
    int buttonTag = button.tag;
    
    switch (buttonTag) {
        case 55011:
            
            //New Issues CheckBox Handler
            if (button.isSelected) {
                [button setSelected: NO];
            } else {
                [button setSelected: YES];
            }
            
            break;
            
        case 55012:
            
            //Renewals CheckBox Handler
            if (button.isSelected) {
                [button setSelected: NO];
            } else {
                [button setSelected: YES];
            }
            
            break;
            
        case 55013:
            
            //App Updates CheckBox Handler
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

- (void)submitHandler {
    NSLog(@"submitHandler");
}

- (void)restorePurschasesHandler {
    NSLog(@"restorePurschasesHandler");
}

- (void)signOutHandler {
    NSLog(@"signOutHandler");
}









- (void)bookmarksHandler {
    NSLog(@"bookmarksHandler");
}

- (void)notificationHandler {
    NSLog(@"notificationHandler");
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
