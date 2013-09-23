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
    
    
}

- (UIButton *)constructTabsWithTitle: (NSString *)title
                               frame: (CGRect)frame
                                 tag: (int)tag
                         andSelector: (SEL)selector
{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
//    btn.backgroundColor = [UIColor redColor];
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
    
    switch (buttonTag) {
        case 1111111:
            [self bookmarksHandler];
            break;
        case 2222222:
            
            topBarTitleLabel.text = @"Change Password";
            backButton.hidden = NO;
            changePasswordView.hidden = NO;
            
            break;
            
        case 3333333:
            [self notificationHandler];
            break;
            
        case 4444444:
            [self signOutHandler];
            break;
            
        case 5555555:
            [self restorePurschasesHandler];
            break;
            
        default:
            break;
    }
}

- (void)backHandler {
    NSLog(@"backHandler");
    topBarTitleLabel.text = @"More";
    backButton.hidden = YES;
    changePasswordView.hidden = YES;
    
}

- (void)bookmarksHandler {
    NSLog(@"bookmarksHandler");
}

- (void)cunstructChangePasswordView {
    NSLog(@"changePasswordHandler");

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

- (void)notificationHandler {
    NSLog(@"notificationHandler");
}

- (void)signOutHandler {
    NSLog(@"signOutHandler");
}

- (void)restorePurschasesHandler {
    NSLog(@"restorePurschasesHandler");
}

- (void)submitHandler {
    NSLog(@"submitHandler");
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
