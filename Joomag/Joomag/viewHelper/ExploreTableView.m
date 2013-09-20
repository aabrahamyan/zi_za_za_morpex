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
    NSArray *data;
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
        self.separatorColor = RGBA(65, 65, 65, 1);
        
        reloadFromDidSelect = NO;
    }
    return self;
}

- (void)reloadExploreTable {

    data = [MainDataHolder getInstance].categoriesList;
   
    [self reloadData];
}

- (void) didSelectedRowAt : (NSInteger) ider {
    data = [[data objectAtIndex:ider] objectForKey:@"cats"];
    
    [self reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    
    cell.textLabel.text = [[data objectAtIndex: indexPath.row] objectForKey:@"name"]; 
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16.0];
    cell.textLabel.highlightedTextColor = [UIColor redColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    for (int i = 0; i < [self numberOfRowsInSection:0]; i++) {
        UITableViewCell* cell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor redColor];

   // NSLog(@"SELECTED ROW ID : %@", [[[[data objectAtIndex:0] objectForKey:@"cats"] objectAtIndex: indexPath.row] objectForKey:@"ID"]);
    ConnectionManager * connManager = [[ConnectionManager alloc] init];
    [connManager constructGetMagazinesListRequest:self:nil:nil:nil:[[data objectAtIndex:indexPath.row] objectForKey:@"name"]];
    
    [self didSelectedRowAt:indexPath.row];  
    
    
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
