//
//  DatePicker.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-09-05.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "DatePicker.h"

#define NUMBER_OF_SECTION 2

@interface DatePicker () {
    
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DatePicker

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor redColor];

        self.tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, 60, 390) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        
        [self addSubview: self.tableView];
        
    }
    
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((section == 0) ? 1 : 12);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize: 14.0f];
    
    if(indexPath.section == 0) {
        cell.textLabel.text = @"aaaa";
    }
    else if(indexPath.section == 1)
    {
        cell.textLabel.text = @"bbb";
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	// If our cell is selected, return double height
	return 30;
}

@end
