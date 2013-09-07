//
//  MonthTableView.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-09-07.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "MonthTableView.h"
#import "Util.h"

@implementation MonthTableView {
    NSArray *monthData;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor clearColor];
        self.separatorColor = [UIColor clearColor];
        
        monthData = [NSArray arrayWithObjects:@"ALL",@"JAN",@"FEB",@"MAR",@"APR",@"MAY",@"JUN",@"JUL",@"AUG",@"SEP",@"OCT",@"NOV",@"DEC", nil];
    }
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    return [monthData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    
    // cell.textLabel.text = [[data objectAtIndex: indexPath.row] objectForKey:@"name"]; // !!!!!!!! TODO !!!!!!!!!!!
    cell.textLabel.text = [monthData objectAtIndex:indexPath.row];
    cell.textLabel.textColor = RGBA(85, 85, 85, 1);
    cell.textLabel.font = [UIFont boldSystemFontOfSize:12.0];
    cell.textLabel.highlightedTextColor = [UIColor redColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    for (int i = 0; i < [self numberOfRowsInSection:0]; i++) {
        UITableViewCell* cell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.textLabel.textColor = RGBA(85, 85, 85, 1);
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor redColor];
    
    [self.monthDelegate didMonthSelected: [monthData objectAtIndex: indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	// If our cell is selected, return double height
	return 36;
}
@end
