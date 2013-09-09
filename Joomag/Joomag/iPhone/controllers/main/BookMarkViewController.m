//
//  BookMarkViewController.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-09-09.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "BookMarkViewController.h"
#import "Util.h"
#import "BookMarkView.h"
#import "MainDataHolder.h"
#import "MagazinRecord.h"

#define BM_WIDTH 540
#define BM_HEIGHT 140

@interface BookMarkViewController () {
    UILabel        *label1;
    UILabel        *label2;
    UIView         *border;
    bool isBookMarksExist;
}

@end

@implementation BookMarkViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        isBookMarksExist = YES; // TODO: check bookmarks
    }
    return self;
}

- (void)loadView {
    [super loadView];

    self.view.backgroundColor = RGBA(49, 49, 49, 1);
    
    //-------------------------------- Top Bar ------------------------------------
    topBar = [[UIView alloc] init]; //TODO: BG IMAGE
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchTopBarBg.png"]];
    [topBar addSubview:backgroundView];
    [topBar sendSubviewToBack: backgroundView];
    [self.view addSubview: topBar];
    
    //-------------------------------- Close Button ------------------------------------
    closeButtonView = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButtonView setImage:[UIImage imageNamed:@"searchTabBarClose.png"] forState:UIControlStateNormal];
    [closeButtonView setImage:[UIImage imageNamed:@"searchTabBarClose.png"] forState:UIControlStateSelected];
    [closeButtonView setImage:[UIImage imageNamed:@"searchTabBarClose.png"] forState:UIControlStateHighlighted];
    closeButtonView.showsTouchWhenHighlighted = YES;
    [closeButtonView addTarget:self action:@selector(animateDown) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:closeButtonView];
    
    //-------------------------------- Top Bar Title ------------------------------------
    
    UIImageView *bookMarkImage = [[UIImageView alloc] initWithFrame:CGRectMake(52, 10, 18, 22)];
    bookMarkImage.image = [UIImage imageNamed:@"tabBarXuyEgo.png"];
    [topBar addSubview:bookMarkImage];
    [topBar sendSubviewToBack: bookMarkImage];
    
    [topBar addSubview: bookMarkImage];
    
    topBarTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(83, 0, 150, 44)];
    topBarTitleLabel.backgroundColor = [UIColor clearColor];
    topBarTitleLabel.textColor = [UIColor whiteColor];
    topBarTitleLabel.text = @"BookMarks";
    
    [topBar addSubview: topBarTitleLabel];
    
    //----------------------------Filter Labels With Border ------------------------
    filterLabels = [[UIView alloc] init];
    [filterLabels addSubview: [self titleLabelsWithBorder]];
    
    [topBar addSubview: filterLabels];
    
    noBookMarksContainer = [[UIView alloc] init];
    noBookMarksContainer.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview: noBookMarksContainer];
    
    //------------------------ Text Labels In Login Container -------------------------
    UILabel *noBookMarksText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 768, 50)];
    noBookMarksText.backgroundColor = [UIColor clearColor];
    noBookMarksText.textColor = [UIColor whiteColor];
    noBookMarksText.font = [UIFont systemFontOfSize:14.0];
    noBookMarksText.numberOfLines = 2;
    noBookMarksText.textAlignment = NSTextAlignmentCenter;
    noBookMarksText.text = @"Looks you don't have any bookmarks. Open an issue and tap on to create one"; // TODO set bookMark Image
    
    [noBookMarksContainer addSubview: noBookMarksText];
    
    // TODO: Check If BookMarks Exist
    if (!isBookMarksExist) {
        noBookMarksContainer.hidden = NO;
    } else {
        noBookMarksContainer.hidden = YES;
    }
    
    //---------------------------- Scroll View ------------------------
    bookMarksScrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(114, 100, BM_WIDTH, 850)];
    bookMarksScrollView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview: bookMarksScrollView];
    
    //---------------------------- BookMarks ------------------------
    
    int yPos = 0;
    
    MainDataHolder *dataHolder = [MainDataHolder getInstance]; // TODO: Set bookMarks Data
    
    for (int i = 0; i < dataHolder.testData.count; i++) {
        
        // BookMarkView *bookMark = [[BookMarkView alloc] initWithFrame: CGRectMake(0, yPos, BM_WIDTH, BM_HEIGHT)];
        
        MagazinRecord *mRec = [dataHolder.testData objectAtIndex: i];
        
        BookMarkView *bookMark = [[BookMarkView alloc] initWithFrame: CGRectMake(0, yPos, BM_WIDTH, BM_HEIGHT)
                                                           withImage: mRec.magazinIcon
                                                               title: mRec.magazinTitle
                                                                date: mRec.magazinDate
                                                                desc: mRec.magazinDetailsText
                                                          bookMarkId: i
                                  ];
        
        bookMark.backgroundColor = [UIColor redColor];
        
        [bookMarksScrollView addSubview: bookMark];
        
        yPos += BM_HEIGHT;
    }
    
    bookMarksScrollView.contentSize = CGSizeMake(BM_WIDTH, yPos);

}

- (void) animateUpAndDown: (BOOL) isUP {
    
    if(isUP) {
        [UIView beginAnimations:@"popingUP" context:nil];
        self.view.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        [UIView setAnimationDuration:1.0];
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    } else {
        [UIView beginAnimations:@"popingUP" context:nil];
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [UIView setAnimationDuration:1.0];
        self.view.frame = CGRectMake(0, self.view.frame.size.height+45, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
    
}

- (void) animateDown {
    [self animateUpAndDown:NO];
}

- (UIView *)titleLabelsWithBorder {
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 280, 30)];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
