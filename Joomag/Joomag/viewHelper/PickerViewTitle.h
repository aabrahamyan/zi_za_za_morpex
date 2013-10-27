//
//  PickerViewTitle.h
//  Joomag
//
//  Created by Anatoli Petrosyants on 10/27/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerViewTitle : UIView <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) UIPickerView *pickerView;
@property bool isOpen;

- (void) animateUpAndDown: (BOOL) isUP;

@end
