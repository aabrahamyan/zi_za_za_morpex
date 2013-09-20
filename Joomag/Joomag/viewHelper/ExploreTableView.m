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
#import "ExploreCatsTableViewCell.h"


@interface ExploreTableView () {
    
}

@end

@implementation ExploreTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.data = [NSMutableArray array];

        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = RGBA(41, 41, 42, 1);
        self.separatorColor = [UIColor clearColor];
        
        reloadFromDidSelect = NO;
        hierarchy = 0;
        self.orientationChanged = NO;
        
    }
    return self;
}

- (void)reloadExploreTable {

    self.data = [MainDataHolder getInstance].categoriesList;
   
    [self reloadData];
}

- (void) didSelectedRowAt : (NSInteger) ider {
    self.data = [[self.data objectAtIndex:ider] objectForKey:@"cats"];
    
    if([self.data count] == 0) {
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
    
    NSInteger numberOfRows = [self.data count];

    
    /*if (numberOfRows % 2 != 0) { //odd
        [data addObject:@""];
        numberOfRows = [data count];
    } else {
        numberOfRows = numberOfRows/2;
    } */
    
    
    if(UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) 
        return numberOfRows / 2;
    else
        return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyReuseIdentifier";   
    NSLog(@"[UIApplication sharedApplication].statusBarOrientation = %d",[UIApplication sharedApplication].statusBarOrientation); 

    if(UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
        ExploreCatsTableViewCell * cell = (ExploreCatsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        NSInteger firstIndex = indexPath.row + indexPath.row;
        NSInteger secondIndex = indexPath.row + indexPath.row + 1;
        
        NSDictionary * current1 = [self.data objectAtIndex:firstIndex];
        NSDictionary * current2 = [self.data objectAtIndex:secondIndex];
        
        if (cell == nil) {
            cell = [[ExploreCatsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
        
            [cell constructStructure:(self.center.x / 2.0f - 50.0f) :(self.center.x + self.center.x / 2 + 50)];
            
        }
    
        [cell setData:current1:current2];
        
        return cell;
        
    } else { 
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
            }
            

            cell.textLabel.text = [[self.data objectAtIndex: indexPath.row] objectForKey:@"name"];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont boldSystemFontOfSize:16.0];
            cell.textLabel.highlightedTextColor = [UIColor redColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone; 
            
        }
        
        return cell;
    }
  
     
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    for (int i = 0; i < [self numberOfRowsInSection:0]; i++) {
        UITableViewCell* cell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor redColor];

    ConnectionManager * connManager = [[ConnectionManager alloc] init];
    [connManager constructGetMagazinesListRequest:self:nil:nil:nil:[[self.data objectAtIndex:indexPath.row] objectForKey:@"name"]];
    
    NSLog(@"[[data objectAtIndex:indexPath.row] objectForKey: = %@",  [[self.data objectAtIndex:indexPath.row] objectForKey:@"name"]);
    
    NSLog(@"hierarchy = %d",hierarchy);
    [self.callbacker redrawDataAndTopBar:[[self.data objectAtIndex:indexPath.row] objectForKey:@"name"] withHierarchy:hierarchy];
    
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
