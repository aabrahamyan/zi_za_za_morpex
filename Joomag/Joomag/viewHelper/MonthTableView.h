//
//  MonthTableView.h
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-09-07.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MonthPickerDelegate <NSObject>
@optional
- (void)didMonthSelected: (NSString *) month;
@end

@interface MonthTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) id <MonthPickerDelegate> monthDelegate;

@end
