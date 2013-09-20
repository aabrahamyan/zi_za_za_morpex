//
//  ExploreTableView.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-08-07.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "ExploreTableView.h"
#import "MainDataHolder.h"
#import "Util.h"
#import "ConnectionManager.h"
#import "ExploreViewController.h"


@interface ExploreTableView () {
    NSMutableArray *data;
}

@end

@implementation ExploreTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        data = [NSArray array];

        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = RGBA(41, 41, 42, 1);
        self.separatorColor = [UIColor clearColor];
        
        reloadFromDidSelect = NO;
        hierarchy = 0;
    }
    return self;
}

- (void)reloadExploreTable {

    data = [MainDataHolder getInstance].categoriesList;
   
    [self reloadData];
}

- (void) didSelectedRowAt : (NSInteger) ider {
    data = [[data objectAtIndex:ider] objectForKey:@"cats"];
    
    if([data count] == 0) {
        self.hidden = YES;
    } else {
        self.hidden = NO;
    }
    
    [self reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    
    NSInteger numberOfRows = [data count];
    
    if (numberOfRows % 2) { //odd
        //NSLog(@"odd: %i", numberOfRows/2);
    } else {
        //NSLog(@"even: %i", numberOfRows/2);
        numberOfRows = numberOfRows/2;
    }
    
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }

    UIImageView *cellBg = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"exploreCell.png"]];
    cellBg.frame = CGRectMake(0, 0, 320, 50);
    
    [cell.contentView addSubview: cellBg];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 140, 50)];
    label1.text = [[data objectAtIndex: indexPath.row] objectForKey:@"name"];
    label1.textColor = [UIColor whiteColor];
    label1.backgroundColor = [UIColor clearColor];
    label1.font = [UIFont boldSystemFontOfSize:16.0];
    label1.highlightedTextColor = [UIColor redColor];
    
    [cell.contentView addSubview: label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(180, 0, 140, 50)];
    label2.text = [[data objectAtIndex: indexPath.row+1] objectForKey:@"name"];
    label2.textColor = [UIColor whiteColor];
    label2.backgroundColor = [UIColor clearColor];
    label2.font = [UIFont boldSystemFontOfSize:16.0];
    label2.highlightedTextColor = [UIColor redColor];
    
    [cell.contentView addSubview: label2];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //cell.
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    for (int i = 0; i < [self numberOfRowsInSection:0]; i++) {
        UITableViewCell* cell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor redColor];

    ConnectionManager * connManager = [[ConnectionManager alloc] init];
    [connManager constructGetMagazinesListRequest:self:nil:nil:nil:[[data objectAtIndex:indexPath.row] objectForKey:@"name"]];
    
    NSLog(@"[[data objectAtIndex:indexPath.row] objectForKey: = %@",  [[data objectAtIndex:indexPath.row] objectForKey:@"name"]);
    
    NSLog(@"hierarchy = %d",hierarchy);
    [self.callbacker redrawDataAndTopBar:[[data objectAtIndex:indexPath.row] objectForKey:@"name"] withHierarchy:hierarchy];
    
    [self didSelectedRowAt:indexPath.row];
    
    hierarchy++;
}

#pragma Response Tracker Delegates ---
 
- (void) didFailResponse: (id) responseObject {
    NSLog(@"Failed getting Response !"); 
}


- (void) didFinishResponse: (id) responseObject {
    [self.callbacker redrawData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	// If our cell is selected, return double height
	return 50;
}

@end
