//
//  PickerViewTitle.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 10/27/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "PickerViewTitle.h"
#import "MainDataHolder.h"

#define TOP_BAR_HEIGHT 80

@implementation PickerViewTitle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        _dataArray = [NSMutableArray array];
        
        // Init the title picker view.
        _pickerView = [[UIPickerView alloc] init];
        [_pickerView setDataSource: self];
        [_pickerView setDelegate: self];
        // [_pickerView setFrame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _pickerView.showsSelectionIndicator = YES;
        
        [self addSubview: _pickerView];
        
        self.isOpen = NO;
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

// Number of components.
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// Total rows in our component.
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_dataArray count];
}

// Display each row's data.
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_dataArray objectAtIndex: row];
}

// Do something with the selected row.
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"You selected this: %@", [_dataArray objectAtIndex: row]);
}

/*
 -(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
 // Get the text of the row.
 NSString *rowItem = [_dataArray objectAtIndex: row];
 
 // Create and init a new UILabel.
 // We must set our label's width equal to our picker's width.
 // We'll give the default height in each row.
 UILabel *lblRow = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView bounds].size.width, 44.0f)];
 
 // Center the text.
 [lblRow setTextAlignment:UITextAlignmentCenter];
 
 // Make the text color red.
 [lblRow setTextColor: [UIColor redColor]];
 
 // Add the text.
 [lblRow setText:rowItem];
 
 // Clear the background color to avoid problems with the display.
 [lblRow setBackgroundColor:[UIColor clearColor]];
 
 // Return the label.
 return lblRow;
 }
 */

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
