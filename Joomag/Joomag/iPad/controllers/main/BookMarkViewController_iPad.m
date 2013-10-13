//
//  BookMarkViewController_iPad.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-09-09.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "BookMarkViewController_iPad.h"
#import "Util.h"
#import "MainDataHolder.h"
#import "MagazinRecord.h"
#import "SIAlertView.h"

#define TEST_UIAPPEARANCE 1
#define BookMark_Tag 666600

@interface BookMarkViewController_iPad () {
    CGRect topBarFrame, filterLabelsFrame, noBookMarksContainerFrame, bookMarkViewFrame;
    UILabel        *label1;
    UILabel        *label2;
    UIView         *border;
    bool isBookMarksExist;
    NSMutableArray *bookMarkData; // TODO: real data
}

@end

@implementation BookMarkViewController_iPad

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        bookMarkData =  [NSMutableArray  arrayWithObjects:
                         [NSArray arrayWithObjects:@"title 1",@"Jul 1", @"placeholder.png", nil],
                         [NSArray arrayWithObjects:@"title 2",@"Sep 10", @"placeholder.png", nil],
                         [NSArray arrayWithObjects:@"title 3",@"Dec 6", @"placeholder.png", nil],
                         [NSArray arrayWithObjects:@"title 4",@"Nov 9", @"placeholder.png", nil],
                         [NSArray arrayWithObjects:@"title 1",@"Jun 8", @"placeholder.png", nil],
                         [NSArray arrayWithObjects:@"title 1",@"Jun 8", @"placeholder.png", nil],
                         nil];
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    isBookMarksExist = YES; // TODO: check bookmarks
    
    self.view.frame = CGRectMake(0, 1024, 1024, 768);
    self.view.backgroundColor = RGBA(49, 49, 49, 1);
    
    //-------------------------------- Top Bar ------------------------------------
    topBar = [[UIView alloc] init]; //TODO: BG IMAGE
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topTabBarBg.png"]];
    [topBar addSubview:backgroundView];
    [self.view addSubview: topBar];
    
    //-------------------------------- Close Button ------------------------------------
    closeButtonView = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButtonView.frame = CGRectMake(0, 0, 46, 44);
    [closeButtonView setImage:[Util imageNamedSmart:@"closeButton"] forState:UIControlStateNormal];
    [closeButtonView setImage:[Util imageNamedSmart:@"closeButton"] forState:UIControlStateSelected];
    [closeButtonView setImage:[Util imageNamedSmart:@"closeButton"] forState:UIControlStateHighlighted];
    closeButtonView.showsTouchWhenHighlighted = YES;
    [closeButtonView addTarget:self action:@selector(animateDown) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:closeButtonView];
    
    //-------------------------------- Top Bar Title ------------------------------------
    
    UIImageView *bookMarkImage = [[UIImageView alloc] initWithFrame:CGRectMake(52, 10, 18, 22)];
    bookMarkImage.image = [Util imageNamedSmart:@"barBookMark"];
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
    filterLabels.backgroundColor = [UIColor clearColor];
    [filterLabels addSubview: [self titleLabelsWithBorder]];
    
    [topBar addSubview: filterLabels];
    
    noBookMarksContainer = [[UIView alloc] init];
    noBookMarksContainer.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview: noBookMarksContainer];
    
    //------------------------ Text Labels In Login Container -------------------------
    UILabel *noBookMarksText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 50)];
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
    bookMarksScrollView = [[UIScrollView alloc] init];
    bookMarksScrollView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview: bookMarksScrollView];
    
    self.bookMarkTable = [[UITableView alloc] initWithFrame:CGRectMake(20, 80, 540, 600) style:UITableViewStylePlain];
    self.bookMarkTable.backgroundColor = [UIColor clearColor];
    self.bookMarkTable.separatorColor = [UIColor clearColor];
    self.bookMarkTable.showsVerticalScrollIndicator = NO;
    self.bookMarkTable.delegate = self;
    self.bookMarkTable.dataSource = self;
    
    [self.view addSubview: self.bookMarkTable];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboardOnScreenTap)];
    
    [self.view addGestureRecognizer:tap];
    
    
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
    
}

- (void)viewDidLayoutSubviews {

    UIInterfaceOrientation iOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (iOrientation == UIDeviceOrientationPortrait) {
        topBarFrame = CGRectMake(0, 0, 768, 44);
        filterLabelsFrame = CGRectMake(620, 0, 300, 44);
        noBookMarksContainerFrame = CGRectMake(259, 80, 250, 100);
        bookMarkViewFrame = CGRectMake(114, 100, 540, 850);
    } else {
        topBarFrame = CGRectMake(0, 0, 1024, 44);
        filterLabelsFrame = CGRectMake(880, 0, 300, 44);
        noBookMarksContainerFrame = CGRectMake(387, 80, 250, 100);
        bookMarkViewFrame = CGRectMake(242, 100, 540, 590);
    }
    
    topBar.frame = topBarFrame;
    filterLabels.frame = filterLabelsFrame;
    noBookMarksContainer.frame = noBookMarksContainerFrame;
    self.bookMarkTable.frame = bookMarkViewFrame;
}


- (UIView *)titleLabelsWithBorder {
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 44)];
    
    label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 44)]; label1.text = @"DATE";
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 41, 44)]; label2.text = @"TITLE";
    
    NSArray *labelArr = [NSArray arrayWithObjects:label1, label2, nil];
    
    for (int i = 0; i < labelArr.count; i ++) {
        [container addSubview:[labelArr objectAtIndex:i]];
        
        ((UILabel *)[labelArr objectAtIndex:i]).backgroundColor = [UIColor clearColor];
        ((UILabel *)[labelArr objectAtIndex:i]).textColor = [UIColor whiteColor];
        ((UILabel *)[labelArr objectAtIndex:i]).font = [UIFont boldSystemFontOfSize:14.0];
        ((UILabel *)[labelArr objectAtIndex:i]).numberOfLines = 1;
        ((UILabel *)[labelArr objectAtIndex:i]).tag = i;
        ((UILabel *)[labelArr objectAtIndex:i]).userInteractionEnabled = YES;
        // [((UILabel *)[labelArr objectAtIndex:i]) sizeToFit];
        
        // Add Gesture Recognizer To Label
        UITapGestureRecognizer *labelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleLabelTapHandler:)];
        [((UILabel *)[labelArr objectAtIndex:i]) addGestureRecognizer: labelTap];
    }
    
    border = [[UIView alloc] initWithFrame:CGRectMake(0, 31, label1.frame.size.width, 2)];
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
    
    CGFloat width = CGRectGetWidth(tableView.bounds);
    CGFloat height = [self tableView: tableView heightForRowAtIndexPath: indexPath];
    
    UIView *backGround = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, width, height)];
    backGround.backgroundColor = RGBA(30, 30, 31, 0.95);
    [cell.contentView addSubview: backGround];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame: CGRectMake(20, 20, 160, 100)];
    imageView.image = [UIImage imageNamed:@"placeholder.png"]; // TODO
    imageView.alpha = 1;
    [cell.contentView addSubview: imageView];
    
    
    UITextField *title = [[UITextField alloc] initWithFrame: CGRectMake(200, 30, width-260, 20)];
	title.backgroundColor = [UIColor clearColor];
    title.font = [UIFont systemFontOfSize:17.5] ;
	title.returnKeyType = UIReturnKeyDone;
	title.delegate = self;
    title.text = [NSString stringWithFormat:@"%@ | %@", [[bookMarkData objectAtIndex: indexPath.row] objectAtIndex: 0],
                                                        [[bookMarkData objectAtIndex: indexPath.row] objectAtIndex: 1]];
    title.textAlignment = NSTextAlignmentLeft;
    title.enabled = NO;
    title.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	title.borderStyle = UITextBorderStyleNone;
	title.textColor = [UIColor whiteColor];
	title.tag = indexPath.row+BookMark_Tag;
    
    [cell.contentView addSubview: title];
    
    UITextView *text = [[UITextView alloc] initWithFrame: CGRectMake(190, 60, width-260, 60)];
    text.backgroundColor = [UIColor clearColor];
    text.font = [UIFont systemFontOfSize:12];
    text.textColor = [UIColor whiteColor];
    text.text = @"Loem ipsum asasa scasds ";
    text.editable = NO;
    [cell.contentView addSubview: text];
    
    UIImageView *bottomBorder = [[UIImageView alloc] initWithFrame: CGRectMake(0, height-2, width, 2)];
    bottomBorder.image = [UIImage imageNamed:@"bookMarkSeparator.png"];
    [cell.contentView addSubview: bottomBorder];
    
    UIButton *closeBookMarkView = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBookMarkView.frame = CGRectMake(width-50, 20, 44, 44);
    [closeBookMarkView setImage:[Util imageNamedSmart:@"closeButton"] forState:UIControlStateNormal];
    [closeBookMarkView setImage:[Util imageNamedSmart:@"closeButton"] forState:UIControlStateSelected];
    [closeBookMarkView setImage:[Util imageNamedSmart:@"closeButton"] forState:UIControlStateHighlighted];
    closeBookMarkView.showsTouchWhenHighlighted = YES;
    [closeBookMarkView addTarget:self action:@selector(removeBookMarkHandler:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.contentView addSubview: closeBookMarkView];
    
    UIButton *editButtonView = [UIButton buttonWithType:UIButtonTypeCustom];
    editButtonView.frame = CGRectMake(width-50, 55, 44, 44);
    [editButtonView setImage:[UIImage imageNamed:@"editIcone.png"] forState:UIControlStateNormal];
    [editButtonView setImage:[UIImage imageNamed:@"editIcone.png"] forState:UIControlStateSelected];
    [editButtonView setImage:[UIImage imageNamed:@"editIcone.png"] forState:UIControlStateHighlighted];
    editButtonView.showsTouchWhenHighlighted = YES;
    editButtonView.tag = indexPath.row;
    [editButtonView addTarget:self  action:@selector(bookMarkEditHandler:) forControlEvents:UIControlEventTouchDown];
    
    [cell.contentView addSubview: editButtonView];
    
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
	return 150;
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

- (void)removeBookMarkHandler:(id)sender  {
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
