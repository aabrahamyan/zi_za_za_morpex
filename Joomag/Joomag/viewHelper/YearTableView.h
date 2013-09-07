//
//  YearTableView.h
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-09-07.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YearPickerDelegate <NSObject>
@optional
- (void)didYearSelected: (NSInteger) year;
@end

@interface YearTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) id <YearPickerDelegate> yearDelegate;

@end
