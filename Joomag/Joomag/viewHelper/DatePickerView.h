//
//  DatePickerView.h
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-09-07.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YearTableView.h"
#import "MonthTableView.h"

@protocol DatePickerDelegate <NSObject>
@optional
- (void)didDatePckerYearChanged: (NSInteger) year;
- (void)didDatePckerMonthChanged: (NSString *) month;
@end

@interface DatePickerView : UIView <YearPickerDelegate, MonthPickerDelegate> {
    YearTableView *yearTable;
    MonthTableView *monthTable;
}

@property (weak, nonatomic) id <DatePickerDelegate> delegate;

@end
