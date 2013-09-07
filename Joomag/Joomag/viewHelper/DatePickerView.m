//
//  DatePickerView.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-09-07.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "DatePickerView.h"

@implementation DatePickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // self.backgroundColor = [UIColor redColor];
        
        yearTable = [[YearTableView alloc] initWithFrame: CGRectMake(0, 0, self.frame.size.width, 30)];
        
        [self addSubview: yearTable];
        
        monthTable = [[MonthTableView alloc] initWithFrame: CGRectMake(0, 50, self.frame.size.width, self.frame.size.height-50)];
        
        [self addSubview: monthTable];
        
        yearTable.yearDelegate = self;
        monthTable.monthDelegate = self;
    }
    
    return self;
}

- (void)didYearSelected:(NSInteger)year {
    [self.delegate didDatePckerYearChanged: year];
}

- (void)didMonthSelected: (NSString *) month {
    [self.delegate didDatePckerMonthChanged: month];
}

@end
