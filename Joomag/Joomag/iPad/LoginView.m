//
//  LoginView.m
//  Joomag
//
//  Created by Armen Abrahamyan on 10/20/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "LoginView.h"
#import "Util.h"

@implementation LoginView

- (id)initWithFrame:(CGRect) frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.frame = frame;
        loginContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        loginContainer.backgroundColor = [UIColor clearColor];
        loginContainer.userInteractionEnabled = YES;
         
        UILabel * joomagLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 200, 20)];
        joomagLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        joomagLabel.text = @"Joomag account";
        joomagLabel.backgroundColor = [UIColor clearColor];
        joomagLabel.textColor = [UIColor grayColor];
        
        [loginContainer addSubview:joomagLabel];
        
        UIImageView *emBackgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 55, 237, 44)];
        emBackgroundImage.image = [Util imageNamedSmart:@"settingsTextFieldBG"];
        
        [loginContainer addSubview:emBackgroundImage];
        
        UILabel *emailLabel = [[UILabel alloc] initWithFrame: CGRectMake(10, 65, 80, 20)];
        emailLabel.font = [UIFont fontWithName:@"proximanovabold" size:17.0];
        emailLabel.textColor = [UIColor whiteColor];
        emailLabel.backgroundColor = [UIColor clearColor];
        emailLabel.text = @"Email:";
        
        [loginContainer addSubview:emailLabel];
         
        emailTextField = [[UITextField alloc] initWithFrame: CGRectMake(85, 55, 150, 44)];
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
        emailTextField.tag = 60903331;
        
        [loginContainer addSubview:emailTextField];
        
        
        UIImageView *passBg = [[UIImageView alloc] initWithFrame: CGRectMake(5, 105, 237, 44)];
        passBg.image = [Util imageNamedSmart:@"settingsTextFieldBG"];
        
        [loginContainer addSubview:passBg];
        
        UILabel *passwordLabel = [[UILabel alloc] initWithFrame: CGRectMake(10, 115, 100, 20)];
        passwordLabel.font = [UIFont fontWithName:@"proximanovabold" size:17.0];
        passwordLabel.textColor = [UIColor whiteColor];
        passwordLabel.backgroundColor = [UIColor clearColor];
        passwordLabel.text = @"Password:";
        
        [loginContainer addSubview:passwordLabel];
        
        passwordTextField = [[UITextField alloc] initWithFrame: CGRectMake(85, 105, 150, 44)];
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
        passwordTextField.tag = 60903332;
        
        [loginContainer addSubview:passwordTextField];
        
        
        UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        loginBtn.frame = CGRectMake(5, 180, 140, 40);
        loginBtn.backgroundColor = RGBA(214, 77, 76, 1);
        [loginBtn setTitle:@"Log In" forState:UIControlStateNormal];
        loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [loginBtn addTarget:self  action:@selector(login) forControlEvents:UIControlEventTouchDown];
        
        [loginContainer addSubview: loginBtn];
        
        UIButton * forgotPassButton = [[UIButton alloc] initWithFrame:CGRectMake(145, 205, 120, 18)];
        
        forgotPassButton.backgroundColor = [UIColor clearColor];
        forgotPassButton.titleLabel.backgroundColor = [UIColor clearColor];
        forgotPassButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [forgotPassButton setTitleColor:RGBA(214, 77, 76, 1) forState:UIControlStateNormal];
        [forgotPassButton setTitleColor:RGBA(214, 77, 76, 1) forState:UIControlStateSelected];
        [forgotPassButton setTitleColor:RGBA(214, 77, 76, 1) forState:UIControlStateHighlighted];
        [forgotPassButton setTitle:@"Forgot password ?" forState:UIControlStateNormal];
        [forgotPassButton setTitle:@"Forgot password ?" forState:UIControlStateSelected];
        [forgotPassButton setTitle:@"Forgot password ?" forState:UIControlStateHighlighted];
        forgotPassButton.showsTouchWhenHighlighted = YES;
        [forgotPassButton addTarget:self action:@selector(createForgotPassView) forControlEvents:UIControlEventTouchUpInside];
        
        [loginContainer addSubview:forgotPassButton];
        
        UIImageView * separator = [[UIImageView alloc] initWithImage:[Util imageNamedSmart:@"login_separator"]];
        
        separator.frame = CGRectMake(260, 5, 3, 216);
        
        [loginContainer addSubview:separator];
        
        
        UILabel * fbTwitterLabel = [[UILabel alloc] initWithFrame:CGRectMake(270, 5, 220, 20)];
        fbTwitterLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        fbTwitterLabel.text = @"Facebook or Twitter user ?";
        fbTwitterLabel.backgroundColor = [UIColor clearColor];
        fbTwitterLabel.textColor = [UIColor grayColor];
        
        [loginContainer addSubview:fbTwitterLabel];
        
        UIButton * fbButton = [[UIButton alloc] init];
        [fbButton addTarget:self  action:@selector(searchHandler) forControlEvents:UIControlEventTouchDown];
        [fbButton setBackgroundImage: [Util imageNamedSmart:@"fb_login"] forState:UIControlStateNormal];
        [fbButton setBackgroundImage: [Util imageNamedSmart:@"fb_login"] forState:UIControlStateSelected];
        [fbButton setBackgroundImage: [Util imageNamedSmart:@"fb_login"] forState:UIControlStateHighlighted];
        
        fbButton.showsTouchWhenHighlighted = YES;
        [fbButton setTitle:@"Login with Facebook" forState:UIControlStateNormal];
        [fbButton setTitle:@"Login with Facebook" forState:UIControlStateSelected];
        [fbButton setTitle:@"Login with Facebook" forState:UIControlStateHighlighted];
        fbButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        fbButton.titleLabel.backgroundColor = [UIColor clearColor];
        fbButton.titleLabel.textColor = [UIColor whiteColor];
        fbButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [fbButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
        fbButton.frame = CGRectMake(270, 60, 202, 36);
        
        [loginContainer addSubview: fbButton];
        
        
        UIButton * twitterButton = [[UIButton alloc] init];
        [twitterButton addTarget:self  action:@selector(searchHandler) forControlEvents:UIControlEventTouchDown];
        [twitterButton setBackgroundImage: [Util imageNamedSmart:@"twitter_login"] forState:UIControlStateNormal];
        [twitterButton setBackgroundImage: [Util imageNamedSmart:@"twitter_login"] forState:UIControlStateSelected];
        [twitterButton setBackgroundImage: [Util imageNamedSmart:@"twitter_login"] forState:UIControlStateHighlighted];
        
        twitterButton.showsTouchWhenHighlighted = YES;
        [twitterButton setTitle:@"Login with Twitter" forState:UIControlStateNormal];
        [twitterButton setTitle:@"Login with Twitter" forState:UIControlStateSelected];
        [twitterButton setTitle:@"Login with Twitter" forState:UIControlStateHighlighted];
        twitterButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        twitterButton.titleLabel.backgroundColor = [UIColor clearColor];
        twitterButton.titleLabel.textColor = [UIColor whiteColor];
        twitterButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [twitterButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
        twitterButton.frame = CGRectMake(270, 110, 202, 36);
        
        [loginContainer addSubview: twitterButton];
        
        [self addSubview:loginContainer];
        
        
        
        
    }
    
    return self;
}

- (void) createForgotPassView {
    
    loginContainer.hidden = YES;
    
    if(!forgotPasswordContainer) {
        forgotPasswordContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        
    }
    
    UILabel * fgpLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 200, 20)];
    fgpLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    fgpLabel.text = @"Forgot Password";
    fgpLabel.backgroundColor = [UIColor clearColor];
    fgpLabel.textColor = [UIColor grayColor];
    
    [forgotPasswordContainer addSubview:fgpLabel];
    
    
    UILabel * fgpLabelDetails = [[UILabel alloc] initWithFrame:CGRectMake(5, 35, 330, 86)];
    fgpLabelDetails.font = [UIFont boldSystemFontOfSize:12.0f];
    fgpLabelDetails.text = @"Nunc erat velit, aliquet non con-sectetur non, placerat eget sapien. Nunc erat velit, aliquet non con-sectetur non, placerat eget sapien. Duis elemen-tum aliquam eros.";
    fgpLabelDetails.numberOfLines = NSIntegerMax;
    fgpLabelDetails.backgroundColor = [UIColor clearColor];
    fgpLabelDetails.textColor = [UIColor grayColor];
    
    [forgotPasswordContainer addSubview:fgpLabelDetails];
    
    
    UIImageView *emBackgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 130, 300, 44)];
    emBackgroundImage.image = [Util imageNamedSmart:@"settingsTextFieldBG"];
    
    [forgotPasswordContainer addSubview:emBackgroundImage];
    
    UILabel *emailLabel = [[UILabel alloc] initWithFrame: CGRectMake(10, 140, 80, 20)];
    emailLabel.font = [UIFont fontWithName:@"proximanovabold" size:17.0];
    emailLabel.textColor = [UIColor whiteColor];
    emailLabel.backgroundColor = [UIColor clearColor];
    emailLabel.text = @"Email:";
    
    [forgotPasswordContainer addSubview:emailLabel];
    
    fgEmailTextField = [[UITextField alloc] initWithFrame: CGRectMake(85, 130, 170, 44)];
    fgEmailTextField.font = [UIFont systemFontOfSize:17.0];
    fgEmailTextField.returnKeyType = UIReturnKeyDone;
    fgEmailTextField.backgroundColor = [UIColor clearColor];
    fgEmailTextField.delegate = self;
    fgEmailTextField.placeholder = @"your@email.com";
    fgEmailTextField.textAlignment = NSTextAlignmentCenter;
    fgEmailTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    fgEmailTextField.keyboardType = UIKeyboardTypeEmailAddress;
    fgEmailTextField.borderStyle = UITextBorderStyleNone;
    fgEmailTextField.textColor = [UIColor whiteColor];
    fgEmailTextField.tag = 609033313;
    
    [forgotPasswordContainer addSubview:fgEmailTextField];
    
    
    UIButton * submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(5, 210, 140, 40);
    submitBtn.backgroundColor = RGBA(214, 77, 76, 1);
    [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [submitBtn addTarget:self  action:@selector(login) forControlEvents:UIControlEventTouchDown];
    
    [forgotPasswordContainer addSubview: submitBtn];
    
    
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(submitBtn.frame.origin.x + submitBtn.frame.size.width + 10, 210, 140, 40);
    cancelBtn.backgroundColor = [UIColor clearColor];
    
    [cancelBtn setBackgroundImage:[Util imageNamedSmart:@"cancel_forgotpass"] forState:UIControlStateNormal];
    [cancelBtn setBackgroundImage:[Util imageNamedSmart:@"cancel_forgotpass"] forState:UIControlStateSelected];
    [cancelBtn setBackgroundImage:[Util imageNamedSmart:@"cancel_forgotpass"] forState:UIControlStateHighlighted];
    
    cancelBtn.showsTouchWhenHighlighted = YES;
    
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateSelected];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateHighlighted];
    
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [cancelBtn addTarget:self  action:@selector(cancelForgotAction) forControlEvents:UIControlEventTouchDown];
    
    [forgotPasswordContainer addSubview: cancelBtn];
    
    
    [self addSubview:forgotPasswordContainer];
}

- (void) cancelForgotAction {
    forgotPasswordContainer.hidden = YES;
    forgotPasswordContainer = nil;
    
    loginContainer.hidden = NO;
}

- (void) login {
    
}

- (void) forgoPassword {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
