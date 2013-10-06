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
    
    [super loadView];
    
    noMagazines = YES;
    
    fbUtil = [FaceBookUtil getInstance];

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
    
    
    filterLabels = [[UIView alloc] initWithFrame: CGRectMake(0, 46, 320, 40)];
    [filterLabels addSubview: [self titleLabelsWithBorder]];
    //filterLabels.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview: filterLabels];
    
    //---------------------------- Scroll View ------------------------------------
//    scrollView = [[MyLibScrollView alloc] init];
//    
//    scrollView.entries = dataHolder.testData;
//    
//    [self.view addSubview: scrollView];
    
    if(IS_IPHONE_5) {
        magazinesTableView = [[MyLIbMagazinesTabelView alloc] initWithFrame:CGRectMake(10, 100, 300, 370)];
    } else if(!IS_IPAD) {
        magazinesTableView = [[MyLIbMagazinesTabelView alloc] initWithFrame:CGRectMake(10, 100, 300, 300)];
    }
    
    //magazinesTableView.delegate = self;
    //magazinesTableView.dataSource = self;
    
    [self.view addSubview: magazinesTableView];
    
    
    
    if (!fbUtil.session.isOpen) {
        // create a fresh session object
        [fbUtil createNewSession];
        
        if (fbUtil.session.state == FBSessionStateCreatedTokenLoaded) {
            // even though we had a cached token, we need to login to make the session usable
            __weak LibraryViewController *libVC = self;
            
            [fbUtil setCompletionHandler:^{
                [libVC updateView];
            }];
            
            [fbUtil openSessionWithCompletionHandler];
            
        } else {
            loginContainer.hidden = NO;
            noMagazines = NO; // TODO
            
            if (!noMagazines) {
                filterLabels.hidden = YES;
                scrollView.hidden = YES;
            }
            
        }
    }
}

- (UIView *)titleLabelsWithBorder {
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(20, 10, self.view.frame.size.width,
                                                                       self.view.frame.size.height)];
    
    label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 20)]; label1.text = @"DATE";
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 30, 20)]; label2.text = @"TITLE";
    label3 = [[UILabel alloc] initWithFrame:CGRectMake(250, 0, 30, 20)]; label3.text = @"EDIT";
    
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
    } else if(gesture.view.tag == 2){
        [self animateLabelBorder: label3];
        NSLog(@"EDIT");
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
    
    if (!fbUtil.session.isOpen) {
        // create a fresh session object
        [fbUtil createNewSession];
    }
    
    if (fbUtil.session.state == FBSessionStateCreated) {
        
        NSLog(@"N O T   C R E A T E D");
        
        // if the session isn't open, let's open it now and present the login UX to the user
        [fbUtil.session openWithCompletionHandler:^(FBSession *session,
                                                                        FBSessionState status,
                                                                        NSError *error) {
            switch (status) {
                case FBSessionStateOpen:
                    NSLog(@"FBSessionStateOpen");
                    [self updateView];
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
    }
}

// Update the UI to reflect login container state
- (void)updateView {
    if (fbUtil.session.isOpen) {
        
        loginContainer.hidden = YES;
        
        noMagazines = YES; // TODO: set when magazin exist
        
        if (noMagazines) {
            filterLabels.hidden = NO;
            scrollView.hidden = NO;
        }
        
        [[FBRequest requestForMe] startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                                NSDictionary<FBGraphUser> *user,
                                                                NSError *error)
        {
             if (!error) {
                 // NSLog(@"fb.user.id: %@", user.id);
                 // NSLog(@"fb.user.name: %@", user.name);
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
