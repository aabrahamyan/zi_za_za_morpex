//
//  ExploreViewController.m
//  Joomag
//
//  Created by Armen Abrahamyan on 7/19/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "ExploreViewController.h"
#import "Util.h"

@interface ExploreViewController () {
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    UIView  *border;
}

@end

@implementation ExploreViewController

- (void)loadView {
    [super loadView];
    
    self.view.backgroundColor = RGBA(43, 43, 44, 1);
    
    [self.view addSubview:[self titleLabelsWithBorder]];
}


- (UIView *)titleLabelsWithBorder {
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, 30)];
    //container.backgroundColor = [UIColor lightGrayColor];
    
    label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 88, 20)]; label1.text = @"FEATURED";
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 80, 20)]; label2.text = @"POPULAR";
    label3 = [[UILabel alloc] initWithFrame:CGRectMake(190, 0, 81, 20)]; label3.text = @"NEW ARRIVALS";
    
    UITapGestureRecognizer *labelTap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleLabelTapHandler:)];
    UITapGestureRecognizer *labelTap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleLabelTapHandler:)];
    UITapGestureRecognizer *labelTap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleLabelTapHandler:)];
    
    NSArray *labelArr = [NSArray arrayWithObjects:label1, label2, label3, nil];
    NSArray *gestureArr = [NSArray arrayWithObjects:labelTap1, labelTap2, labelTap3, nil];
    
    for (int i = 0; i < labelArr.count; i ++) {
        [container addSubview:[labelArr objectAtIndex:i]];
        ((UILabel *)[labelArr objectAtIndex:i]).backgroundColor = [UIColor clearColor];
        ((UILabel *)[labelArr objectAtIndex:i]).textColor = [UIColor whiteColor];
        ((UILabel *)[labelArr objectAtIndex:i]).font = [UIFont boldSystemFontOfSize:16.0];
        ((UILabel *)[labelArr objectAtIndex:i]).numberOfLines = 1;
        ((UILabel *)[labelArr objectAtIndex:i]).lineBreakMode = NSLineBreakByWordWrapping;
        // ((UILabel *)[labelArr objectAtIndex:i]).shadowColor = [UIColor grayColor];
        // ((UILabel *)[labelArr objectAtIndex:i]).shadowOffset = CGSizeMake(0, 1);
        // ((UILabel *)[labelArr objectAtIndex:i]).autoresizingMask = UIViewAutoresizingFlexibleWidth;
        ((UILabel *)[labelArr objectAtIndex:i]).tag = i;
        [((UILabel *)[labelArr objectAtIndex:i]) sizeToFit];
        ((UILabel *)[labelArr objectAtIndex:i]).userInteractionEnabled = YES;
        
        // Add Gesture Recognizer To Label
        ((UITapGestureRecognizer *)[gestureArr objectAtIndex:i]).numberOfTapsRequired = 1;
        [((UILabel *)[labelArr objectAtIndex:i]) addGestureRecognizer: ((UITapGestureRecognizer *)[gestureArr objectAtIndex:i])];
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
        // Do stuff here
    } else if(gesture.view.tag == 1){
        [self animateLabelBorder: label2];
        // Do stuff here
    } else if(gesture.view.tag == 2) {
        [self animateLabelBorder: label3];
        // Do stuff here
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
