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

#define TOP_BAR_HEIGHT 44

@interface LibraryViewController (){
    MainDataHolder *dataHolder;
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
    
    [super loadView];
    
    dataHolder = [MainDataHolder getInstance];

    self.view.backgroundColor = RGBA(49, 49, 49, 1);
    
    //-------------------------------- Top Bar ------------------------------------
    topBar = [[UIView alloc] init];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topTabBarBg.png"]];
    [topBar addSubview:backgroundView];
    [topBar sendSubviewToBack: backgroundView];
    [self.view addSubview: topBar];
    
    //-------------------------------- Top Bar Title ------------------------------------
    topBarTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 150, 44)];
    topBarTitleLabel.backgroundColor = [UIColor clearColor];
    topBarTitleLabel.textColor = [UIColor whiteColor];
    topBarTitleLabel.text = @"My Library";
    
    [topBar addSubview: topBarTitleLabel];
    
    //----------------------------Filter Labels With Border ------------------------
    filterLabels = [[UIView alloc] init];
    [filterLabels addSubview: [self titleLabelsWithBorder]];
    
    [topBar addSubview: filterLabels];
    
    
    //---------------------------- Login Container ------------------------------------
    loginContainer = [[UIView alloc] init];
    loginContainer.backgroundColor = RGBA(85, 85, 85, 1);
    
    [self.view addSubview: loginContainer];
    
    //------------------------ Text Labels In Login Container -------------------------
    loginText = [[UILabel alloc] init];
    loginText.backgroundColor = [UIColor clearColor];
    loginText.textColor = [UIColor whiteColor];
    loginText.font = [UIFont systemFontOfSize:14.0];
    loginText.numberOfLines = 2;
    loginText.text = @"Sign in using social network or your Joomag account.Not a member? Join Joomag.";
    
    [loginContainer addSubview: loginText];
    
    //---------------------------- Login Buttons ------------------------------------
    joomagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //joomagButton.frame = CGRectMake(510, 30, 200, 35);
    [joomagButton setImage:[UIImage imageNamed:@"joomagButton.png"] forState:UIControlStateNormal];
    [joomagButton addTarget:self action:@selector(loginWithJoomag) forControlEvents:UIControlEventTouchUpInside];
    
    [loginContainer addSubview: joomagButton];
    
    orLabel = [[UILabel alloc] init];
    orLabel.backgroundColor = [UIColor clearColor];
    orLabel.textColor = [UIColor whiteColor];
    orLabel.font = [UIFont systemFontOfSize:14.0];
    orLabel.text = @"or";
    
    [loginContainer addSubview: orLabel];
    
    fbButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //fbButton.frame = CGRectMake(750, 5, 200, 35);
    [fbButton setImage:[UIImage imageNamed:@"faceBookButton.png"] forState:UIControlStateNormal];
    [fbButton addTarget:self action:@selector(loginWithFaceBook) forControlEvents:UIControlEventTouchUpInside];
    
    [loginContainer addSubview: fbButton];
    
    twitterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //twitterButton.frame = CGRectMake(750, 50, 200, 35);
    [twitterButton setImage:[UIImage imageNamed:@"twitterButton.png"] forState:UIControlStateNormal];
    [twitterButton addTarget:self action:@selector(loginWithTwitter) forControlEvents:UIControlEventTouchUpInside];
    
    [loginContainer addSubview: twitterButton];
    
    
    //---------------------------- DATE PICKER ------------------------------------
    datePicker = [[DatePickerView alloc] initWithFrame: CGRectMake(20, 160, 50, 520)];
    datePicker.delegate = self;
    
    [self.view addSubview: datePicker];
    
    //---------------------------- Scroll View ------------------------------------
    scrollView = [[MyLibScrollView alloc] init];
    
    [self.view addSubview: scrollView];
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
    NSLog(@"Login With FaceBook");
}

#pragma mark - DatePicker

- (void)didDatePckerYearChanged:(NSInteger)year {
    NSLog(@"year: %i", year);
}

- (void)didDatePckerMonthChanged: (NSString *) month {
    NSLog(@"month: %@", month);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
