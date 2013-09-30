//
//  LibraryViewController.m
//  Joomag
//
//  Created by Armen Abrahamyan on 7/19/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "LibraryViewController.h"
#import "Util.h"
#import "MainDataHolder.h"
#import "ConnectionManager.h"
#import "FaceBookUtil.h"

#define TOP_BAR_HEIGHT 44

@interface LibraryViewController (){
    MainDataHolder *dataHolder;
    FaceBookUtil   *fbUtil;

    bool noMagazines;
    
    UILabel        *label1;
    UILabel        *label2;
    UILabel        *label3;
    UIView         *border;
}

@end

@implementation LibraryViewController

- (void)loadView {
    
    noMagazines = YES;
    
    fbUtil = [FaceBookUtil getInstance];
    
    [super loadView];
    
    NSLog(@"[FaceBookUtil getInstance].session.isOpen: %d",fbUtil.session.isOpen);

    if (!fbUtil.session.isOpen) {
        // create a fresh session object
        NSLog(@"create a fresh session object");
        [fbUtil createNewSession];
        
        // if we don't have a cached token, a call to open here would cause UX for login to
        // occur; we don't want that to happen unless the user clicks the login button, and so
        // we check here to make sure we have a token before calling open
        if (fbUtil.session.state == FBSessionStateCreatedTokenLoaded) {
            // even though we had a cached token, we need to login to make the session usable
//            [fbUtil.session openWithCompletionHandler:^(FBSession *session,
//                                                             FBSessionState status,
//                                                             NSError *error) {
//                // we recurse here, in order to update buttons and labels
//                NSLog(@"have a cached token");
//                [self updateView];
//            }];
            
            __weak LibraryViewController *libVC = self;
            
            [fbUtil setCompletionHandler:^{
                 NSLog(@"have a cached token");
                 [libVC updateView];
            }];
            
            [fbUtil openSessionWithCompletionHandler];
            
        } else {
            // show login container
            NSLog(@"L O G   O U T");
        }
    }
    
    

    
    
    
    
    
    
    
    dataHolder = [MainDataHolder getInstance];
    
    ConnectionManager * connManager = [[ConnectionManager alloc] init];
    [connManager constrcutAndGetCategoriesTypesRequest: self];

    self.view.backgroundColor = RGBA(49, 49, 49, 1);
    
    //-------------------------------- Top Bar ------------------------------------
    topBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, TOP_BAR_HEIGHT)];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topTabBarBg.png"]];
    [topBar addSubview:backgroundView];
    [topBar sendSubviewToBack: backgroundView];
    [self.view addSubview: topBar];
    
    //-------------------------------- Top Bar Title ------------------------------------
    topBarTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 150, TOP_BAR_HEIGHT)];
    topBarTitleLabel.backgroundColor = [UIColor clearColor];
    topBarTitleLabel.textColor = [UIColor whiteColor];
    topBarTitleLabel.text = @"My Library";
    
    [topBar addSubview: topBarTitleLabel];
    
    //----------------------------Filter Labels With Border ------------------------
    filterLabels = [[UIView alloc] init];
    [filterLabels addSubview: [self titleLabelsWithBorder]];
    
    [topBar addSubview: filterLabels];
    
    
    //---------------------------- Login Container ------------------------------------
    loginContainer = [[UIView alloc] initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT+3, 320, 150)];
    loginContainer.backgroundColor = RGBA(85, 85, 85, 1);
    
    [self.view addSubview: loginContainer];
    
    //------------------------ Text Labels In Login Container -------------------------
    loginText = [[UILabel alloc] initWithFrame:CGRectMake(5, 20, 205, 100)];
    loginText.backgroundColor = [UIColor clearColor];
    loginText.textColor = [UIColor whiteColor];
    loginText.font = [UIFont systemFontOfSize:16.0];
    loginText.numberOfLines = 5;
    loginText.text = @"Sign in using social network or your Joomag account. \n\nNot a member?Join Joomag";
    
    [loginContainer addSubview: loginText];
    
    //---------------------------- Login Buttons ------------------------------------
    joomagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    joomagButton.frame = CGRectMake(215, 5, 100, 35);
    joomagButton.backgroundColor = [UIColor greenColor];
    [joomagButton setBackgroundImage: [Util imageNamedSmart:@"joomagButton"] forState:UIControlStateNormal];
    [joomagButton addTarget:self action:@selector(loginWithJoomag) forControlEvents:UIControlEventTouchUpInside];
    
    [loginContainer addSubview: joomagButton];
    
    orLabel = [[UILabel alloc] initWithFrame:CGRectMake(260, 35, 20, 30)];
    orLabel.backgroundColor = [UIColor clearColor];
    orLabel.textColor = [UIColor whiteColor];
    orLabel.font = [UIFont systemFontOfSize:16.0];
    orLabel.text = @"or";
    
    [loginContainer addSubview: orLabel];
    
    fbButton = [UIButton buttonWithType:UIButtonTypeCustom];
    fbButton.frame = CGRectMake(215, 65, 100, 35);
    [fbButton setBackgroundImage:[Util imageNamedSmart:@"faceBookButton"] forState:UIControlStateNormal];
    [fbButton addTarget:self action:@selector(loginWithFaceBook) forControlEvents:UIControlEventTouchUpInside];
    
    [loginContainer addSubview: fbButton];
    
    twitterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    twitterButton.frame =  CGRectMake(215, 110, 100, 35);
    [twitterButton setBackgroundImage:[Util imageNamedSmart:@"twitterButton"] forState:UIControlStateNormal];
    [twitterButton addTarget:self action:@selector(loginWithTwitter) forControlEvents:UIControlEventTouchUpInside];
    
    [loginContainer addSubview: twitterButton];
    
    //---------------------------- DATE PICKER ------------------------------------
    datePicker = [[DatePickerView alloc] initWithFrame: CGRectMake(20, 160, 50, 520)];
    datePicker.delegate = self;
    
    [self.view addSubview: datePicker];
    
    //---------------------------- Scroll View ------------------------------------
    scrollView = [[MyLibScrollView alloc] init];
    
    scrollView.entries = dataHolder.testData;
    
    [self.view addSubview: scrollView];
    
    
    if (noMagazines) {
        
        filterLabels.hidden = YES;
        datePicker.hidden = YES;
        scrollView.hidden = YES;
        
    } else {
        
    }
    
}

- (UIView *)titleLabelsWithBorder {
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 280, 30)];
    
    label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)]; label1.text = @"DATE";
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 50, 20)]; label2.text = @"TITLE";
    label3 = [[UILabel alloc] initWithFrame:CGRectMake(150, 0, 50, 20)]; label3.text = @"EDIT";
    
    NSArray *labelArr = [NSArray arrayWithObjects:label1, label2, label3, nil];
    
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
    } else if(gesture.view.tag == 2) {
        NSLog(@"EDIT");
        [self animateLabelBorder: label3];
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

#pragma mark - Login Methods

- (void)loginWithJoomag {
    NSLog(@"Login With Joomag");
}

- (void)loginWithTwitter {
    NSLog(@"Login With Twitter");
}

- (void)loginWithFaceBook {
    NSLog(@"Login With FaceBook: %d", fbUtil.session.isOpen);
    
    if (!fbUtil.session.isOpen) {
        // create a fresh session object
        NSLog(@"session not exist");
        fbUtil.session = [[FBSession alloc] init];
    } else {
       NSLog(@"session exist"); 
    }
    
    if (fbUtil.session.state == FBSessionStateCreated) {
        
        NSLog(@"N O T   C R E A T E D");
        
        FBSession.activeSession = fbUtil.session;
        
        // if the session isn't open, let's open it now and present the login UX to the user
        [fbUtil.session openWithCompletionHandler:^(FBSession *session,
                                                                        FBSessionState status,
                                                                        NSError *error) {
            // and here we make sure to update our UX according to the new session state
            [self updateView];
            
            // NSLog(@"USER_ID: %@", FBSession.activeSession.appID);
            
            // Initiate a Facebook instance
            switch (status) {
                case FBSessionStateOpen:
                    NSLog(@"FBSessionStateOpen");
                    break;
                
                case FBSessionStateClosed:
                    NSLog(@"FBSessionStateClosed");
                    break;
                    
                case FBSessionStateClosedLoginFailed:
                    NSLog(@"FBSessionStateClosedLoginFailed");
                    break;
                
                default:
                    break;
            }
            
        }];
    
    } else {
        NSLog(@"C R E A T E D");
    }
}

// FBSample logic
// main helper method to update the UI to reflect the current state of the session.
- (void)updateView {
    NSLog(@"updateView");
    if (fbUtil.session.isOpen) {
        // valid account UI is shown whenever the session is open
        //NSLog(@"LOGIN: %@", [FaceBookUtil getInstance].session.accessTokenData.accessToken);
        NSLog(@"L O G I N");
        
        [[FBRequest requestForMe] startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                                NSDictionary<FBGraphUser> *user,
                                                                NSError *error)
        {
             if (!error) {
                 NSLog(@"user.id: %@", user.id);
                 NSLog(@"user.name: %@", user.name);
             }
         }];
        
        
    }
}

#pragma mark - DatePicker

- (void)didDatePckerYearChanged:(NSInteger)year {
    NSLog(@"year: %i", year);
}

- (void)didDatePckerMonthChanged: (NSString *) month {
    NSLog(@"month: %@", month);
}

#pragma Response Tracker Delegates ---

- (void) didFailResponse: (id) responseObject {
    
}

- (void) didFinishResponse: (id) responseObject {
    if([dataHolder.testData count] != 0) {
        scrollView.entries = dataHolder.testData;
        [scrollView redrawData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
