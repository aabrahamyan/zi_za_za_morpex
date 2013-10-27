//
//  PickerViewDate.h
//  Joomag
//
//  Created by Anatoli Petrosyants on 10/27/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerViewDate : UIView

@property (nonatomic, retain) UIDatePicker *pickerView;
@property bool isOpen;

- (void) animateUpAndDown: (BOOL) isUP;

@end
