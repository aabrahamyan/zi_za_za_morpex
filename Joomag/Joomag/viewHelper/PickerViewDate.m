//
//  PickerViewDate.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 10/27/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "PickerViewDate.h"
#import "MainDataHolder.h"

#define TOP_BAR_HEIGHT 80

@implementation PickerViewDate

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _pickerView = [[UIDatePicker alloc] init];
        _pickerView.datePickerMode = UIDatePickerModeDate;
        [_pickerView addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview: _pickerView];
        
    }
    return self;
}

- (void) animateUpAndDown: (BOOL) isUP {
    if(isUP) {
        self.isOpen = YES;
        
        CGRect rect = self.frame;
        rect.origin.y = [MainDataHolder getInstance].height - self.frame.size.height - TOP_BAR_HEIGHT;
        
        [UIView animateWithDuration: 0.3 animations:^{
            self.frame = rect;
        }];
    } else {
        self.isOpen = NO;
        
        CGRect rect = self.frame;
        rect.origin.y = [MainDataHolder getInstance].height;
        
        [UIView animateWithDuration: 0.3 animations:^{
            self.frame = rect;
        }];
    }
}

- (void)pickerChanged:(id)sender
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterMediumStyle;
    NSLog(@"value: %@",[NSString stringWithFormat:@"%@", [df stringFromDate: _pickerView.date]]);
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
