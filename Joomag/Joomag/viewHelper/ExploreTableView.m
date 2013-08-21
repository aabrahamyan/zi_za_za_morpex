//
//  ExploreTableView.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-08-07.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "ExploreTableView.h"
#import "Util.h"

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
        data = [NSArray arrayWithObjects: @"Categories",@"Art",@"Automotive",
                @"Entertainment",@"Home",@"Lifestyle", @"Men",@"News",@"Science and Tech",
                @"Business",@"Sports",@"Travel", @"Women", nil];
        
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = RGBA(41, 41, 42, 1);
        self.separatorColor = RGBA(65, 65, 65, 1);;
    }
    return self;
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
    
    cell.textLabel.text = [data objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16.0];
    cell.textLabel.highlightedTextColor = [UIColor redColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor redColor];
    
    /*
     data = [NSArray arrayWithObjects: @"Sub Categories",@"Sub Art",@"Sub Automotive",
     @"Sub Entertainment",@"Sub Home", nil];
     */
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTitles" object:nil];
    
    [tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	// If our cell is selected, return double height
	return 50;
}

@end
