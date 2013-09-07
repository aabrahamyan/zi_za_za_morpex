//
//  YearTableView.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-09-07.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "YearTableView.h"
#import "Util.h"

@interface YearTableView () <UIScrollViewDelegate>

@end

@implementation YearTableView {
    NSMutableArray *yearData;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = RGBA(40, 40, 30, 1); // TODO: set topbar color
        self.pagingEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        self.separatorColor = [UIColor clearColor];
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = [UIColor colorWithRed:2 green:2 blue:2 alpha:1].CGColor; // TODO: gray color
        
        // Set Years
        NSDateComponents *components = [[NSCalendar currentCalendar] components: NSYearCalendarUnit fromDate:[NSDate date]];
        NSInteger year = [components year];
        
        yearData = [NSMutableArray array];
        
        for (NSInteger i = year-10; i < year; i++) {
            [yearData addObject: [NSNumber numberWithInteger: i]];
        }
        
        for (NSInteger i = year; i <= year+10; i++) {
            [yearData addObject: [NSNumber numberWithInteger: i]];
        }
        
        // NSLog(@"arr: %@", yearData);
        
        // Select Current Year
        int currentYear = [self numberOfRowsInSection: 0] - 11;
        NSIndexPath* ip = [NSIndexPath indexPathForRow: currentYear inSection:0];
        [self scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:NO];
        
    }
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [yearData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"yearCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [yearData objectAtIndex: indexPath.row]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:13.0];
    cell.textLabel.highlightedTextColor = [UIColor redColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // cell.textLabel.textColor = [UIColor redColor];
    
    // NSLog(@"selected year: %i", indexPath.row);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	// If our cell is selected, return double height
	return 30;
}

// -------------------------------------------------------------------------------
//	scrollViewDidEndDecelerating:
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSArray *visiblePaths = [self indexPathsForVisibleRows];
    for (NSIndexPath *indexPath in visiblePaths) {
        [self.yearDelegate didYearSelected: [[yearData objectAtIndex: indexPath.row] intValue]];
    }
}
@end
