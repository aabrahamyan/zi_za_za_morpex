//
//  SettingsViewController_iPad.m
//  Joomag
//
//  Created by Armen Abrahamyan on 7/19/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "SettingsViewController_iPad.h"
#import "Util.h"
#import "HelpView.h"

@interface SettingsViewController_iPad () {
    UIButton *closeButtonView;
    UIButton *signInBtn;
    UIView   *registrationView;
    UIView   *notificationView;
    UIView   *aboutView;
    UIView   *restorePurschasesView;
    HelpView * helpView;
}

@end

@implementation SettingsViewController_iPad

- (void)loadView {
    [super loadView];
    
    NSLog(@"settings_ipad");
    
    self.view.frame = CGRectMake(0, 1024, 1024, 768); // TODO:
    
    // ----------------------------- Self View Frame -----------------------------
    
    CGRect frame = self.view.frame;
    frame.origin.y = self.view.frame.size.height;
    self.view.frame = frame;
    
    // ----------------------------------------------------------------------------
    
    self.isOpen = NO;
    
    // -------------------------- Background Image View ---------------------------
    
    self.backgroundImageView = [[UIImageView alloc] init];
    
    [self.view addSubview: self.backgroundImageView];
    
    // ----------------------------------------------------------------------------
    
    // --------------------------- Side Bar View ----------------------------------
    self.tabsView = [[UIView alloc] initWithFrame:CGRectMake(30, 122, 190, 247)];
    self.tabsView.clipsToBounds = YES;
    
    [self.view addSubview: self.tabsView];
    // ----------------------------------------------------------------------------
    
    // ------------------------- Top Bar View --------------------------------
    closeButtonView = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButtonView.frame = CGRectMake(0, 0, 44, 44);
    [closeButtonView setImage:[Util imageNamedSmart:@"closeButton"] forState:UIControlStateNormal];
    [closeButtonView setImage:[Util imageNamedSmart:@"closeButton"] forState:UIControlStateSelected];
    [closeButtonView setImage:[Util imageNamedSmart:@"closeButton"] forState:UIControlStateHighlighted];
    closeButtonView.showsTouchWhenHighlighted = YES;
    [closeButtonView addTarget:self action:@selector(animateDown) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview: closeButtonView];
    
    UIImageView *gearView = [[UIImageView alloc] initWithFrame:CGRectMake(65, 10, 20, 20)];
    gearView.image = [UIImage imageNamed:@"gear.png"];
    
    [self.view addSubview: gearView];
    
    UILabel *settingsLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 100, 40)];
    settingsLabel.font = [UIFont fontWithName:@"proximanovalight" size:22.0f];
    settingsLabel.textColor = [UIColor whiteColor];
    settingsLabel.backgroundColor = [UIColor clearColor];
    settingsLabel.text = @"Settings";
    
    [self.view addSubview: settingsLabel];
    
    signInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    signInBtn.frame = CGRectMake(self.view.frame.size.width-120, 0, 88, 44);
    [signInBtn setImage:[Util imageNamedSmart:@"signInButton"] forState:UIControlStateNormal];
    [signInBtn setImage:[Util imageNamedSmart:@"signInButton"] forState:UIControlStateSelected];
    [signInBtn setImage:[Util imageNamedSmart:@"signInButton"] forState:UIControlStateHighlighted];
    signInBtn.showsTouchWhenHighlighted = YES;
    [signInBtn addTarget:self  action:@selector(signInHandler) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview: signInBtn];
    
    // ----------------------------------------------------------------------------
    
    // -------------------------------- Left Side Bar -----------------------------
    [self.tabsView addSubview: [self constructTabsWithTitle: @"Account Settings"
                                                      frame: CGRectMake(0, -10, 190, 40)
                                                        tag: 87654321]
     ];
    
    [self.tabsView addSubview: [self constructTabsWithTitle: @"Notification Settings"
                                                      frame: CGRectMake(0, 50, 190, 40)
                                                        tag: 87654322]
     ];
    
    [self.tabsView addSubview: [self constructTabsWithTitle: @"About Joomag"
                                                      frame: CGRectMake(0, 105, 190, 40)
                                                        tag: 87654323]
     ];
    
    [self.tabsView addSubview: [self constructTabsWithTitle: @"Help"
                                                      frame: CGRectMake(0, 155, 190, 40)
                                                        tag: 87654324]
     ];
    
    [self.tabsView addSubview: [self constructTabsWithTitle: @"Restore iTunes Purchases"
                                                      frame: CGRectMake(0, 210, 190, 40)
                                                        tag: 87654325]
     ];
    
    // ----------------------------------------------------------------------------
    
    // -------------------------- Construct Views -----------------------------
    [self constructRegistrationView];
    ((UIButton *)[self.tabsView.subviews objectAtIndex: 0]).selected = YES;
    
    [self cunstructNotificationView];
    [self cunstructAboutView];
    [self cunstructRestorePurschasesView];
    [self createHelpView];
    
    // ----------------------------------------------------------------------------
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboardOnScreenTap)];
    
    [self.view addGestureRecognizer:tap];
}

- (void) animateUpAndDown: (BOOL) isUP {
    
    if(isUP) {
        self.isOpen = YES;
        
        [UIView beginAnimations:@"popingUP" context:nil];
        self.view.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView setAnimationDuration:0.3];
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView commitAnimations];
        
    } else {
        self.isOpen = NO;
        
        [UIView beginAnimations:@"popingUP" context:nil];
        
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [UIView setAnimationDuration:0.3];
        self.view.frame = CGRectMake(0, 1024, self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView commitAnimations];
    }
}

- (void) animateDown {
    [self animateUpAndDown:NO];
}

- (void)viewDidLayoutSubviews {
    
    UIInterfaceOrientation iOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (iOrientation == UIDeviceOrientationPortrait) {
        self.backgroundImageView.image = [UIImage imageNamed:@"settingsPortBg.png"];
    } else {
        self.backgroundImageView.image = [UIImage imageNamed:@"settingsLandBG.png"];
    }
    
    self.backgroundImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    signInBtn.frame = CGRectMake(self.view.frame.size.width-120, 0, 88, 44);
}

- (UIButton *)constructTabsWithTitle: (NSString *)title
                               frame: (CGRect)frame
                                 tag: (int)tag
{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    btn.titleLabel.font  = [UIFont fontWithName:@"proximanovalight" size:15.0f];
    btn.tag = tag;
    btn.titleLabel.numberOfLines = 2;
    [btn setTitle: title forState:UIControlStateNormal];
    [btn setTitle: title forState:UIControlStateSelected];
    [btn setTitle: title forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [btn addTarget: self action: @selector(toggleButtons:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (void) toggleButtons: (id) target {
    UIButton *button = (UIButton *)target;
    NSInteger buttonTag = button.tag;
    
    [self unSelectButtons];
    button.selected = YES;
    
    switch (buttonTag) {
        case 87654321:
            notificationView.hidden = YES;
            aboutView.hidden = YES;
            restorePurschasesView.hidden = YES;
            helpView.hidden = YES;
            registrationView.hidden = NO;
            break;
        case 87654322:
            registrationView.hidden = YES;
            aboutView.hidden = YES;
            restorePurschasesView.hidden = YES;
            helpView.hidden = YES;
            notificationView.hidden = NO;
            break;
            
        case 87654323:
            registrationView.hidden = YES;
            notificationView.hidden = YES;
            restorePurschasesView.hidden = YES;
            helpView.hidden = YES;
            aboutView.hidden = NO;
            break;
            
        case 87654324:
            registrationView.hidden = YES;
            notificationView.hidden = YES;
            restorePurschasesView.hidden = YES;
            aboutView.hidden = YES;
            helpView.hidden = NO;
            break;
            
        case 87654325:
            registrationView.hidden = YES;
            notificationView.hidden = YES;
            aboutView.hidden = YES;
            helpView.hidden = YES;
            restorePurschasesView.hidden = NO;
            break;
            
        default:
            break;
    }
}

- (void)unSelectButtons {
    for (UIButton *button in [self.tabsView subviews]) {
        button.selected = NO;
    }
}

- (void) constructRegistrationView {
    
    registrationView = [[UIView alloc] initWithFrame: CGRectMake(260, 120, 700, 400)];
    // registrationView.backgroundColor = [UIColor whiteColor];
    // registrationView.hidden = YES;
    
    UILabel *joinJoomag = [[UILabel alloc] initWithFrame:CGRectMake(0, 1, 150, 20)];
    joinJoomag.font = [UIFont fontWithName:@"proximanovalight" size:15.0f];
    joinJoomag.textColor = [UIColor grayColor];
    joinJoomag.backgroundColor = [UIColor clearColor];
    joinJoomag.text = @"Join Joomag!";
    
    [registrationView addSubview:joinJoomag];
    
    UIImageView *genericBackgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 54, 287, 44)];
    genericBackgroundImage.image = [Util imageNamedSmart:@"settingsTextFieldBG"];
    
    [registrationView addSubview:genericBackgroundImage];
    
    UILabel *emailLabel = [[UILabel alloc] initWithFrame: CGRectMake(10, 64, 80, 20)];
    emailLabel.font = [UIFont fontWithName:@"proximanovabold" size:17.0];
    emailLabel.textColor = [UIColor whiteColor];
    emailLabel.backgroundColor = [UIColor clearColor];
    emailLabel.text = @"Email:";
    
    [registrationView addSubview:emailLabel];
    
    UITextField *emailTextField = [[UITextField alloc] initWithFrame: CGRectMake(105, 53, 170, 44)];
    emailTextField.font = [UIFont systemFontOfSize:17.0];
	emailTextField.returnKeyType = UIReturnKeyDone;
    emailTextField.backgroundColor = [UIColor clearColor];
	emailTextField.delegate = self;
    emailTextField.placeholder = @"Required";
    emailTextField.textAlignment = NSTextAlignmentCenter;
    emailTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
	emailTextField.borderStyle = UITextBorderStyleNone;
	emailTextField.textColor = [UIColor whiteColor];
	emailTextField.tag = 90903331;
    
    [registrationView addSubview:emailTextField];
    
    UIImageView *passBg = [[UIImageView alloc] initWithFrame: CGRectMake(0, 111, 287, 44)];
    passBg.image = [Util imageNamedSmart:@"settingsTextFieldBG"];
    
    [registrationView addSubview:passBg];
    
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame: CGRectMake(10, 121, 100, 20)];
    passwordLabel.font = [UIFont fontWithName:@"proximanovabold" size:17.0];
    passwordLabel.textColor = [UIColor whiteColor];
    passwordLabel.backgroundColor = [UIColor clearColor];
    passwordLabel.text = @"Password:";
    
    [registrationView addSubview:passwordLabel];
    
    UITextField *passwordTextField = [[UITextField alloc] initWithFrame: CGRectMake(105, 110, 170, 44)];
	passwordTextField.backgroundColor = [UIColor clearColor];
    passwordTextField.font = [UIFont systemFontOfSize:17.0];
	passwordTextField.returnKeyType = UIReturnKeyDone;
	passwordTextField.delegate = self;
	passwordTextField.secureTextEntry = YES;
    passwordTextField.textAlignment = NSTextAlignmentCenter;
    passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passwordTextField.placeholder = @"Required";
	passwordTextField.borderStyle = UITextBorderStyleNone;
	passwordTextField.textColor = [UIColor whiteColor];
	passwordTextField.tag = 90903332;
    
    [registrationView addSubview:passwordTextField];
    
    UIImageView *passBgRepeat = [[UIImageView alloc] initWithFrame: CGRectMake(0, 155, 287, 44)];
    passBgRepeat.image = [Util imageNamedSmart:@"settingsTextFieldBG"];
    
    [registrationView addSubview:passBgRepeat];
    
    UILabel *retypeLabel = [[UILabel alloc] initWithFrame: CGRectMake(10, 165, 80, 20)];
    retypeLabel.font = [UIFont fontWithName:@"proximanovabold" size:17.0];
    retypeLabel.textColor = [UIColor whiteColor];
    retypeLabel.backgroundColor = [UIColor clearColor];
    retypeLabel.text = @"Retype:";
    
    [registrationView addSubview:retypeLabel];
    
    UITextField *passwordTextFieldRepeat = [[UITextField alloc] initWithFrame: CGRectMake(105, 155, 170, 44)];
	passwordTextFieldRepeat.backgroundColor = [UIColor clearColor];
    passwordTextFieldRepeat.font = [UIFont systemFontOfSize:17.0];
	passwordTextFieldRepeat.returnKeyType = UIReturnKeyDone;
    passwordTextFieldRepeat.textAlignment = NSTextAlignmentCenter;
    passwordTextFieldRepeat.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	passwordTextFieldRepeat.delegate = self;
	passwordTextFieldRepeat.secureTextEntry = YES;
    passwordTextFieldRepeat.placeholder = @"Required";
	passwordTextFieldRepeat.borderStyle = UITextBorderStyleNone;
	passwordTextFieldRepeat.textColor = [UIColor whiteColor];
	passwordTextFieldRepeat.tag = 90903333;
    
    [registrationView addSubview:passwordTextFieldRepeat];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(0, 242, 175, 44);
    [submitButton setImage:[Util imageNamedSmart:@"submitSettings"] forState:UIControlStateNormal];
    [submitButton setImage:[Util imageNamedSmart:@"submitSettings"] forState:UIControlStateSelected];
    [submitButton setImage:[Util imageNamedSmart:@"submitSettings"] forState:UIControlStateHighlighted];
    submitButton.showsTouchWhenHighlighted = YES;
    [submitButton addTarget: self action: @selector(submitHandler) forControlEvents:UIControlEventTouchUpInside];
    
    [registrationView addSubview:submitButton];
    
    UILabel *termsOfService = [[UILabel alloc] initWithFrame: CGRectMake(190, 270, 120, 20)];
    termsOfService.font = [UIFont boldSystemFontOfSize:12];
    termsOfService.textColor = [UIColor redColor];
    termsOfService.backgroundColor = [UIColor clearColor];
    termsOfService.text = @"Terms of Service";
    
    [registrationView addSubview:termsOfService];
    
    UITextView *text = [[UITextView alloc] initWithFrame: CGRectMake(300, 53, 200, 140)];
    text.backgroundColor = [UIColor clearColor];
    text.font = [UIFont fontWithName:@"proximanovabold" size:17.0];
    text.contentInset = UIEdgeInsetsMake(-10.0,0.0,0,0.0);
    text.textColor = [UIColor whiteColor];
    text.editable = NO;
    text.text = @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
    
    [registrationView addSubview: text];
    
    UITextView *agreWithTermsLabel = [[UITextView alloc] initWithFrame: CGRectMake(340, 230, 160, 50)];
    agreWithTermsLabel.font = [UIFont boldSystemFontOfSize:10];
    agreWithTermsLabel.textColor = [UIColor whiteColor];
    agreWithTermsLabel.backgroundColor = [UIColor clearColor];
    agreWithTermsLabel.text = @"Lorem Ipsum is simply duy text of the printing and dumy text sie the 1500s";
    
    [registrationView addSubview:agreWithTermsLabel];
    
    UIButton *agreWithTermsCheckbox = [UIButton buttonWithType:UIButtonTypeCustom];
    agreWithTermsCheckbox.frame = CGRectMake(300,225,50,50);
    agreWithTermsCheckbox.backgroundColor = [UIColor clearColor];
    [agreWithTermsCheckbox setImage:[UIImage imageNamed:@"notselectedcheckbox.png"] forState:UIControlStateNormal];
    [agreWithTermsCheckbox setImage:[UIImage imageNamed:@"selectedcheckbox.png"] forState:UIControlStateSelected];
    [agreWithTermsCheckbox setImage:[UIImage imageNamed:@"selectedcheckbox.png"] forState:UIControlStateHighlighted];
    agreWithTermsCheckbox.adjustsImageWhenHighlighted=YES;
    agreWithTermsCheckbox.userInteractionEnabled = YES;
    [agreWithTermsCheckbox setSelected: YES];
    agreWithTermsCheckbox.tag = 90903334;
    [agreWithTermsCheckbox addTarget:self  action:@selector(agreWithTermsHandler:) forControlEvents:UIControlEventTouchDown];
    
    [registrationView addSubview: agreWithTermsCheckbox];
    
    [self.view addSubview:registrationView];
}

- (void)cunstructNotificationView {
    
    notificationView = [[UIView alloc] initWithFrame: CGRectMake(260, 130, 500, 250)];
    notificationView.backgroundColor = [UIColor clearColor];
    notificationView.hidden = YES;
    
    [self.view addSubview: notificationView];
    
    UILabel *notificationTitle1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
    notificationTitle1.font = [UIFont systemFontOfSize: 18.0f];
    notificationTitle1.textColor = [UIColor whiteColor];
    notificationTitle1.numberOfLines = 2;
    notificationTitle1.textAlignment = NSTextAlignmentLeft;
    notificationTitle1.backgroundColor = [UIColor clearColor];
    notificationTitle1.text = @"Manage Notifications Settings";
    
    [notificationView addSubview: notificationTitle1];
    
    UILabel *notificationTitle2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 350, 40)];
    notificationTitle2.font = [UIFont systemFontOfSize: 14.0f];
    notificationTitle2.textColor = [UIColor whiteColor];
    notificationTitle2.numberOfLines = 2;
    notificationTitle2.textAlignment = NSTextAlignmentLeft;
    notificationTitle2.backgroundColor = [UIColor clearColor];
    notificationTitle2.text = @"Visit the iOS Settings menu to enable and disable Push Notifications for Joomag.";
    
    [notificationView addSubview: notificationTitle2];
    
    [notificationView addSubview: [self createLabelsInNotificationViewWithTitle: @"New Issues"
                                                                           desc: @"Alert me when new issues are available."
                                                                          frame: CGRectMake(0, 120, 450, 60)
                                                                         andTag: 550111
                                   ]];
    
    [notificationView addSubview: [self createLabelsInNotificationViewWithTitle: @"Renewals"
                                                                           desc: @"Alert me when I am near the end of subscription."
                                                                          frame: CGRectMake(0, 180, 450, 60)
                                                                         andTag: 550112
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
    titleLabel.font = [UIFont systemFontOfSize: 19.0f];
    titleLabel.text = title;
    
    [container addSubview: titleLabel];
    
    UILabel * descLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 20, 350, 20)];
    descLabel.backgroundColor = [UIColor clearColor];
    descLabel.textColor = [UIColor grayColor];
    descLabel.textAlignment = NSTextAlignmentLeft;
    descLabel.font = [UIFont systemFontOfSize: 14.0f];
    descLabel.text = desc;
    
    [container addSubview: descLabel];
    
    UIButton *checkbox = [UIButton buttonWithType:UIButtonTypeCustom];
    checkbox.frame = CGRectMake(400,0,44,44);
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
        case 550111:
            
            //New Issues CheckBox Handler
            if (button.isSelected) {
                [button setSelected: NO];
            } else {
                [button setSelected: YES];
            }
            
            break;
            
        case 550112:
            
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

- (void)cunstructAboutView {
    
    aboutView = [[UIView alloc] initWithFrame: CGRectMake(260, 100, 480, 500)];
    aboutView.backgroundColor = [UIColor clearColor];
    aboutView.hidden = YES;
    
    [self.view addSubview: aboutView];
    
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    logo.frame = CGRectMake(160, 0, 160, 90);
    
    [aboutView addSubview: logo];
    
    UILabel * aboutTitleLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 110, 480, 20)];
    aboutTitleLabel.backgroundColor = [UIColor clearColor];
    aboutTitleLabel.textColor = [UIColor whiteColor];
    aboutTitleLabel.textAlignment = NSTextAlignmentCenter;
    aboutTitleLabel.font = [UIFont systemFontOfSize: 18.0f];
    aboutTitleLabel.text = @"About Joomag";
    
    [aboutView addSubview: aboutTitleLabel];
    
    UITextView *text = [[UITextView alloc] initWithFrame: CGRectMake(0, 140, 480, 270)];
    text.backgroundColor = [UIColor clearColor];
    text.font = [UIFont fontWithName:@"proximanovabold" size:14.0f];
    text.textColor = [UIColor whiteColor];
    text.editable = NO;
    text.text = @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
    
    [aboutView addSubview: text];
    
    UILabel * versionLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 410, 480, 20)];
    versionLabel.backgroundColor = [UIColor clearColor];
    versionLabel.textColor = [UIColor grayColor];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.font = [UIFont systemFontOfSize: 12.0f];
    versionLabel.text = @"Version 1.0.0";
    
    [aboutView addSubview: versionLabel];
    
    UILabel * aboutDescLabel = [[UILabel alloc] initWithFrame: CGRectMake(70, 430, 330, 40)];
    aboutDescLabel.backgroundColor = [UIColor clearColor];
    aboutDescLabel.textColor = [UIColor grayColor];
    aboutDescLabel.textAlignment = NSTextAlignmentCenter;
    aboutDescLabel.font = [UIFont systemFontOfSize: 12.0f];
    aboutDescLabel.numberOfLines = 2;
    aboutDescLabel.text = @"1009-2013 Joomag LLC. All rights reserved. Covered by US. Patent No. 8,171,630 and 7,290,365";
    
    [aboutView addSubview: aboutDescLabel];
}

- (void)cunstructRestorePurschasesView {
    
    restorePurschasesView = [[UIView alloc] initWithFrame: CGRectMake(260, 100, 480, 500)];
    restorePurschasesView.backgroundColor = [UIColor clearColor];
    restorePurschasesView.hidden = YES;
    
    [self.view addSubview: restorePurschasesView];
    
    UILabel *restoreTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 480, 20)];
    restoreTitle.font = [UIFont systemFontOfSize: 18.0f];
    restoreTitle.textColor = [UIColor whiteColor];
    restoreTitle.alpha = 0.7;
    restoreTitle.textAlignment = NSTextAlignmentCenter;
    restoreTitle.backgroundColor = [UIColor clearColor];
    restoreTitle.text = @"Restore iTunes Purchases";
    
    [restorePurschasesView addSubview: restoreTitle];
    
    UILabel *restoreDesc = [[UILabel alloc] initWithFrame:CGRectMake(70, 50, 340, 100)];
    restoreDesc.font = [UIFont boldSystemFontOfSize: 14.0f];
    restoreDesc.textColor = [UIColor grayColor];
    restoreDesc.alpha = 1;
    restoreDesc.textAlignment = NSTextAlignmentCenter;
    restoreDesc.backgroundColor = [UIColor clearColor];
    restoreDesc.numberOfLines = 3;
    restoreDesc.text = @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the.";
    
    [restorePurschasesView addSubview: restoreDesc];
    
    UIButton *restoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    restoreBtn.frame = CGRectMake(160, 170, 140, 40);
    restoreBtn.backgroundColor = RGBA(214, 77, 76, 1);
    [restoreBtn setTitle:@"Restore" forState:UIControlStateNormal];
    restoreBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [restoreBtn addTarget:self  action:@selector(restorePurschasesHandler) forControlEvents:UIControlEventTouchDown];
    
    [restorePurschasesView addSubview: restoreBtn];
}

- (void) createHelpView {
    helpView = [[HelpView alloc] initWithFrame:CGRectMake(287, 107, 412, 800)];
    
    [self.view addSubview:helpView];
    helpView.hidden = YES;
    [helpView redrawData];
}


/*
 - (BOOL)shouldAutorotate {
 return YES;
 }
 
 - (NSUInteger)supportedInterfaceOrientations {
 
 return UIInterfaceOrientationMaskAllButUpsideDown;
 
 }
 */

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)dismissKeyboardOnScreenTap {
    [self.view endEditing:YES];
}

- (void)signInHandler {
    NSLog(@"signInHandler");
}

- (void)submitHandler {
    NSLog(@"signInHandler");
}

- (void)restorePurschasesHandler {
    NSLog(@"restorePurschasesHandler");
}


- (void)agreWithTermsHandler: (id)sender {
    NSLog(@"agreWithTermsHandler");
    UIButton *button = (UIButton *)sender;
    
    if (button.isSelected) {
        [button setSelected: NO];
    } else {
        [button setSelected: YES];
    }
}

@end
