//
//  MoreViewController.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-09-20.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "MoreViewController.h"
#import "Util.h"
#import "UIImageView+WebCache.h"
#import "SIAlertView.h"
#import "FaceBookUtil.h"
#import <FacebookSDK/FacebookSDK.h>

#define TEST_UIAPPEARANCE 1
#define BookMark_Tag 666600

@interface MoreViewController () {
    UILabel  *topBarTitleLabel;
    UIButton *backButton;
    UIView   *changePasswordView;
    UIView   *restorePurschasesView;
    UIView   *signOutView;
    UIView   *notificationView;
    UIView   *bookMarksView;
    
    UILabel   *label1;
    UILabel   *label2;
    UIView    *border;
    
    NSMutableArray *bookMarkData;
    
    UITextField *currentTxtField;
    
    FaceBookUtil *fbUtil;
}

@end

@implementation MoreViewController

- (void)loadView {

    [super loadView];
    
    fbUtil = [FaceBookUtil getInstance];
    
#if TEST_UIAPPEARANCE
    [[SIAlertView appearance] setMessageFont:[UIFont systemFontOfSize:16]];
    [[SIAlertView appearance] setTitleColor:[UIColor whiteColor]];
    [[SIAlertView appearance] setMessageColor:[UIColor grayColor]];
    [[SIAlertView appearance] setCornerRadius:12];
    [[SIAlertView appearance] setShadowRadius:20];
    [[SIAlertView appearance] setViewBackgroundColor:RGBA(49, 49, 49, 1)];
    [[SIAlertView appearance] setButtonColor:[UIColor whiteColor]];
    [[SIAlertView appearance] setCancelButtonColor:[UIColor whiteColor]];
    [[SIAlertView appearance] setDestructiveButtonColor:[UIColor whiteColor]];
    
    [[SIAlertView appearance] setDefaultButtonImage:[Util imageWithColor: RGBA(214, 77, 76, 1)] forState:UIControlStateNormal];
    [[SIAlertView appearance] setDefaultButtonImage:[Util imageWithColor: RGBA(214, 77, 76, 1)] forState:UIControlStateHighlighted];
    
    [[SIAlertView appearance] setCancelButtonImage:[Util imageWithColor: RGBA(214, 77, 76, 1)] forState:UIControlStateNormal];
    [[SIAlertView appearance] setCancelButtonImage:[Util imageWithColor: RGBA(214, 77, 76, 1)] forState:UIControlStateHighlighted];
    
    [[SIAlertView appearance] setDestructiveButtonImage:[Util imageWithColor: RGBA(214, 77, 76, 1)] forState:UIControlStateNormal];
    [[SIAlertView appearance] setDestructiveButtonImage:[Util imageWithColor: RGBA(214, 77, 76, 1)] forState:UIControlStateHighlighted];
#endif
    
    bookMarkData =  [NSMutableArray  arrayWithObjects:
                    [NSArray arrayWithObjects:@"title 1",@"General Information", @"placeholder.png", nil],
                    [NSArray arrayWithObjects:@"title 2",@"Banking and financial institutions", @"placeholder.png", nil],
                    [NSArray arrayWithObjects:@"title 3",@"Legal regulation for foreign investors", @"placeholder.png", nil],
                    [NSArray arrayWithObjects:@"title 4",@"Airport & Cargo", @"placeholder.png", nil],
                    nil];
    
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
                                                  frame: CGRectMake(20, 60, 300, 20)
                                                    tag: 1111111]
    ];
    
    [self.view addSubview: [self constructTabsWithTitle: @"Change Password"
                                                  frame: CGRectMake(20, 95, 300, 20)
                                                    tag:2222222]
     ];
    
    [self.view addSubview: [self constructTabsWithTitle: @"Notification Settings"
                                                  frame: CGRectMake(20, 130, 300, 20)
                                                    tag:3333333]
     ];
    
    [self.view addSubview: [self constructTabsWithTitle: @"Sign Out"
                                                  frame: CGRectMake(20, 165, 300, 20)
                                                    tag:4444444]
     ];
    
    [self.view addSubview: [self constructTabsWithTitle: @"Restore iTunes Purchases"
                                                  frame: CGRectMake(20, 200, 300, 20)
                                                    tag:5555555]
     ];
    
    //-------------------------- Close Search Botton -------`----------------------
    backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 46, 44)];
    [backButton addTarget:self  action:@selector(backHandler) forControlEvents:UIControlEventTouchDown];
    [backButton setBackgroundImage: [Util imageNamedSmart:@"backButton"] forState:UIControlStateNormal];
    backButton.hidden = YES;
    
    [topBar addSubview: backButton];
    
    [self cunstructChangeBookMarksView];
    [self cunstructChangePasswordView];
    [self cunstructRestorePurschasesView];
    [self cunstructSignOutView];
    [self cunstructNotificationView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboardOnScreenTap)];
    
    [self.view addGestureRecognizer:tap];
}

- (UIButton *)constructTabsWithTitle: (NSString *)title
                               frame: (CGRect)frame
                                 tag: (int)tag
{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    btn.titleLabel.font  = [UIFont boldSystemFontOfSize: 16];
    btn.tag = tag;
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
    backButton.hidden = NO;
    topBarTitleLabel.frame = CGRectMake(46, 0, 320-46, 44);
    
    switch (buttonTag) {
        case 1111111:
            [self bookmarksHandler];
            signOutView.hidden = YES;
            notificationView.hidden = YES;
            restorePurschasesView.hidden = YES;
            changePasswordView.hidden = YES;
            topBarTitleLabel.text = @"BookMarks";
            bookMarksView.hidden = NO;
            break;
        case 2222222:
            signOutView.hidden = YES;
            notificationView.hidden = YES;
            restorePurschasesView.hidden = YES;
            bookMarksView.hidden = YES;
            topBarTitleLabel.text = @"Change Password";
            changePasswordView.hidden = NO;
            
            break;
            
        case 3333333:
            restorePurschasesView.hidden = YES;
            changePasswordView.hidden = YES;
            signOutView.hidden = YES;
            bookMarksView.hidden = YES;
            topBarTitleLabel.text = @"Notification Settings";
            notificationView.hidden = NO;
            
            break;
            
        case 4444444:
            restorePurschasesView.hidden = YES;
            changePasswordView.hidden = YES;
            notificationView.hidden = YES;
            bookMarksView.hidden = YES;
            topBarTitleLabel.text = @"Sign Out";
            signOutView.hidden = NO;
            
            break;
            
        case 5555555:
            signOutView.hidden = YES;
            changePasswordView.hidden = YES;
            notificationView.hidden = YES;
            bookMarksView.hidden = YES;
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
    bookMarksView.hidden = YES;
    notificationView.hidden = YES;
}

- (void)cunstructChangeBookMarksView {
    bookMarksView = [[UIView alloc] initWithFrame: CGRectMake(0, 46, 320, self.view.frame.size.height)];
    bookMarksView.backgroundColor = RGBA(49, 49, 49, 1);
    bookMarksView.hidden = YES;
    
    [self.view addSubview: bookMarksView];
    
    UIImageView *bookMarksViewBg = [[UIImageView alloc] initWithImage:[Util imageNamedSmart:@"moreBookMarksBg"]];
    bookMarksViewBg.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
    [bookMarksView addSubview: bookMarksViewBg];
    
    [bookMarksView addSubview: [self titleLabelsWithBorder]];
    
    self.bookMarkTable = [[UITableView alloc] initWithFrame:CGRectMake(20, 80, 290, (IS_IPHONE_5) ? 350 : 260) style:UITableViewStylePlain];
    
    self.bookMarkTable.backgroundColor = [UIColor clearColor];
    self.bookMarkTable.separatorColor = [UIColor clearColor];
    self.bookMarkTable.showsVerticalScrollIndicator = NO;
    self.bookMarkTable.delegate = self;
    self.bookMarkTable.dataSource = self;
    
    [bookMarksView addSubview: self.bookMarkTable];
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
    
    UITextField *emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(95, 30, 200, 50)];
    emailTextField.font = [UIFont systemFontOfSize:17.5];
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
    
    UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(130, 90, 165, 50)];
	passwordTextField.backgroundColor = [UIColor clearColor];
    passwordTextField.font = [UIFont systemFontOfSize:17.5] ;
	passwordTextField.returnKeyType = UIReturnKeyDone;
	passwordTextField.delegate = self;
	passwordTextField.secureTextEntry = YES;
    passwordTextField.placeholder = @"Required";
    passwordTextField.textAlignment = NSTextAlignmentCenter;
    passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	passwordTextField.borderStyle = UITextBorderStyleNone;
	passwordTextField.textColor = [UIColor grayColor];
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
    
    UITextField *passwordTextFieldRepeat = [[UITextField alloc] initWithFrame:CGRectMake(105, 150, 190, 50)];
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
    [fbUtil closeSession];
}

- (void)bookmarksHandler {
    NSLog(@"bookmarksHandler");
}

- (UIView *)titleLabelsWithBorder {
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(190, 10, 110, 30)];
    // container.backgroundColor = [UIColor redColor];
    
    label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)]; label1.text = @"DATE";
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 50, 20)]; label2.text = @"TITLE";
    
    NSArray *labelArr = [NSArray arrayWithObjects:label1, label2, nil];
    
    for (int i = 0; i < labelArr.count; i ++) {
        [container addSubview:[labelArr objectAtIndex:i]];
        
        ((UILabel *)[labelArr objectAtIndex:i]).backgroundColor = [UIColor clearColor];
        ((UILabel *)[labelArr objectAtIndex:i]).textColor = [UIColor whiteColor];
        ((UILabel *)[labelArr objectAtIndex:i]).font = [UIFont boldSystemFontOfSize:14.0];
        ((UILabel *)[labelArr objectAtIndex:i]).numberOfLines = 1;
        ((UILabel *)[labelArr objectAtIndex:i]).tag = i;
        ((UILabel *)[labelArr objectAtIndex:i]).userInteractionEnabled = YES;
        [((UILabel *)[labelArr objectAtIndex:i]) sizeToFit];
        
        // Add Gesture Recognizer To Label
        UITapGestureRecognizer *labelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleLabelTapHandler:)];
        [((UILabel *)[labelArr objectAtIndex:i]) addGestureRecognizer: labelTap];
    }
    
    border = [[UIView alloc] initWithFrame:CGRectMake(0, 20, label1.frame.size.width, 2)];
    border.backgroundColor = [UIColor redColor];
    
    [container addSubview:border];
    
    return container;
}

-(void)titleLabelTapHandler :(id) sender
{
    UITapGestureRecognizer *gesture = (UITapGestureRecognizer *) sender;
    
    if (gesture.view.tag == 0) {
        [self animateLabelBorder: label1];
        NSLog(@"DATE");
    } else if(gesture.view.tag == 1){
        [self animateLabelBorder: label2];
        NSLog(@"TITLE");
    }
}

- (void) animateLabelBorder: (UILabel *)label {
    NSValue * from = [NSNumber numberWithFloat:border.layer.position.x];
    NSValue * to = [NSNumber numberWithFloat:label.layer.position.x];
    NSString * keypath = @"position.x";
    [border.layer addAnimation:[self animationFrom:from to:to forKeyPath:keypath withDuration:.2] forKey:@"bounce"];
    [border.layer setValue:to forKeyPath:keypath];
    
    CGRect frm = border.frame;
    frm.origin.x = label.frame.origin.x;
    frm.size.width = label.frame.size.width;
    border.frame = frm;
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
   return [bookMarkData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *MyIdentifier = @"bookMarkCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *path = @"http://tim-dawson.com/wp-content/uploads/RAP_May_78_cover-200x100.jpg"; // TODO: set real data
    UIImageView *imageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 120, 80)];
    [imageView setImageWithURL: [NSURL URLWithString: path] placeholderImage: nil options:SDWebImageProgressiveDownload];
    
    [cell.contentView addSubview: imageView];
    
    UITextField *title = [[UITextField alloc] initWithFrame:CGRectMake(130, 0, 110, 30)];
	title.backgroundColor = [UIColor clearColor];
    title.font = [UIFont systemFontOfSize:17.5] ;
	title.returnKeyType = UIReturnKeyDone;
	title.delegate = self;
    title.text = [[bookMarkData objectAtIndex: indexPath.row] objectAtIndex: 0];
    title.textAlignment = NSTextAlignmentLeft;
    title.enabled = NO;
    title.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	title.borderStyle = UITextBorderStyleNone;
	title.textColor = [UIColor whiteColor];
	title.tag = indexPath.row+BookMark_Tag;
    
    [cell.contentView addSubview: title];
    
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.frame = CGRectMake(250,0,40,30);
    editBtn.backgroundColor = [UIColor clearColor];
    [editBtn setImage:[UIImage imageNamed:@"editIcone.png"] forState:UIControlStateNormal];
    [editBtn setImage:[UIImage imageNamed:@"editIcone.png"] forState:UIControlStateSelected];
    [editBtn setImage:[UIImage imageNamed:@"editIcone.png"] forState:UIControlStateHighlighted];
    editBtn.adjustsImageWhenHighlighted=YES;
    editBtn.userInteractionEnabled = YES;
    editBtn.tag = indexPath.row;
    [editBtn addTarget:self  action:@selector(bookMarkEditHandler:) forControlEvents:UIControlEventTouchDown];
    
    [cell.contentView addSubview: editBtn];
    
    UIButton *removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    removeBtn.frame = CGRectMake(250,30,40,30);
    removeBtn.backgroundColor = [UIColor clearColor];
    [removeBtn setImage:[UIImage imageNamed:@"closeButton.png"] forState:UIControlStateNormal];
    [removeBtn setImage:[UIImage imageNamed:@"closeButton.png"] forState:UIControlStateSelected];
    [removeBtn setImage:[UIImage imageNamed:@"closeButton.png"] forState:UIControlStateHighlighted];
    removeBtn.adjustsImageWhenHighlighted=YES;
    removeBtn.userInteractionEnabled = YES;
    removeBtn.tag = indexPath.row;
    [removeBtn addTarget:self  action:@selector(bookMarksRemoveHandler:) forControlEvents:UIControlEventTouchDown];
    
    [cell.contentView addSubview: removeBtn];
    
    UILabel * descLabel = [[UILabel alloc] initWithFrame: CGRectMake(130, 30, 110, 30)];
    descLabel.backgroundColor = [UIColor clearColor];
    descLabel.textColor = [UIColor whiteColor];
    descLabel.textAlignment = NSTextAlignmentLeft;
    descLabel.font = [UIFont systemFontOfSize: 16.0f];
    descLabel.text = @"Title | date"; //TODO: get from data object
    
    [cell.contentView addSubview: descLabel];
    
    UILabel * createdDateLabel = [[UILabel alloc] initWithFrame: CGRectMake(130, 60, 130, 20)];
    createdDateLabel.backgroundColor = [UIColor clearColor];
    createdDateLabel.textColor = [UIColor whiteColor];
    createdDateLabel.textAlignment = NSTextAlignmentLeft;
    createdDateLabel.font = [UIFont systemFontOfSize: 14.0f];
    createdDateLabel.text = @"Created sep 3, 2013"; //TODO: get from data object
    
    [cell.contentView addSubview: createdDateLabel];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // cell.textLabel.textColor = [UIColor redColor];
    
    // NSLog(@"selected year: %i", indexPath.row);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	// If our cell is selected, return double height
	return 100;
}

- (void)bookMarkEditHandler:(id)sender {
    UIButton *button = (UIButton *)sender;
    int buttonTag = button.tag;
    
    NSLog(@"edit bookmark: %i", buttonTag);
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:buttonTag inSection:0];
    UITableViewCell *cell  = [self.bookMarkTable cellForRowAtIndexPath: indexPath];

    UITextField *editTextField = (UITextField *)[cell.contentView viewWithTag:buttonTag+BookMark_Tag];
    
    editTextField.enabled = YES;
    [editTextField becomeFirstResponder];
}

- (void)bookMarksRemoveHandler:(id)sender  {
    UIButton *button = (UIButton *)sender;
    int buttonTag = button.tag;
    
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Remove BookMark" andMessage:[[bookMarkData objectAtIndex: buttonTag] objectAtIndex: 0]];
    [alertView addButtonWithTitle:@"Cancel"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                              NSLog(@"Cancel Clicked");
                          }];
    [alertView addButtonWithTitle:@"OK"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                              NSLog(@"OK Clicked");
                              
                              [self removeBookMark: buttonTag];
                              
                          }];
    alertView.titleColor = RGBA(214, 77, 76, 1);
    alertView.cornerRadius = 0;
    alertView.buttonFont = [UIFont boldSystemFontOfSize:15];
    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    
    [alertView show];
}

- (void)removeBookMark: (int)index {
    [bookMarkData  removeObjectAtIndex: index];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.bookMarkTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [self.bookMarkTable reloadData];
}

#pragma mark - CAAnimations

-(CABasicAnimation *)animationFrom:(NSValue *)from
                                to:(NSValue *)to
                        forKeyPath:(NSString *)keypath
                      withDuration:(CFTimeInterval)duration
{
    CABasicAnimation * result = [CABasicAnimation animationWithKeyPath:keypath];
    [result setFromValue:from];
    [result setToValue:to];
    [result setDuration:duration];
    
    return  result;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSError *error = nil;
    NSString *string = [NSString stringWithFormat:@"%i", textField.tag];
    NSString *placeholder = @"(6666)";
    NSString *pattern = [NSString stringWithFormat:placeholder, string];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSAssert(regex, @"Unable to create regular expression");
    
    NSRange textRange = NSMakeRange(0, string.length);
    NSRange matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];

    // Did we find a matching range
    if (matchRange.location != NSNotFound) {
        textField.enabled = NO;
        [textField resignFirstResponder];
    }

    return YES;
}

- (void)dismissKeyboardOnScreenTap {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
