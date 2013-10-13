//
//  MyLIbMagazinesTabelView.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-10-06.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "MyLIbMagazinesTabelView.h"
#import "Util.h"
#import "UIImageView+WebCache.h"
#import "MainDataHolder.h"

@implementation MyLIbMagazinesTabelView {
    NSMutableArray *myLibData; // TODO: real data
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        

        
        myLibData =  [MainDataHolder getInstance].myLibMagazines;
        
        
        
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = RGBA(41, 41, 42, 1);
        self.backgroundColor = [UIColor clearColor];
        self.separatorColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = NO;
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [myLibData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    return ((section == 0) ? [[myLibData objectAtIndex:0] count] : [[myLibData objectAtIndex:1] count]); // TODO
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSString *path = @"http://tim-dawson.com/wp-content/uploads/RAP_May_78_cover-200x100.jpg"; // TODO: set real data
    UIImageView *imageView = [[UIImageView alloc] initWithFrame: CGRectMake(20, 10, 70, 90)];
    [imageView setImageWithURL: [NSURL URLWithString: path] placeholderImage: nil options:SDWebImageProgressiveDownload];
    
    [cell.contentView addSubview: imageView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(110, 35, 130, 20)];
	title.backgroundColor = [UIColor clearColor];
    title.font = [UIFont boldSystemFontOfSize:17.5] ;
    title.text = [[[myLibData objectAtIndex:1] objectAtIndex: indexPath.row] objectAtIndex: 1];
    title.textAlignment = NSTextAlignmentLeft;

	title.textColor = [UIColor whiteColor];
	title.tag = indexPath.row;
    
    [cell.contentView addSubview: title];
    
    UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(110, 55, 130, 20)];
	date.backgroundColor = [UIColor clearColor];
    date.font = [UIFont systemFontOfSize:14] ;
    date.text = [[[myLibData objectAtIndex:1] objectAtIndex: indexPath.row] objectAtIndex: 2];
    date.textAlignment = NSTextAlignmentLeft;
    
	date.textColor = [UIColor whiteColor];
	date.tag = indexPath.row;
    
    [cell.contentView addSubview: date];
    
    CGFloat width = CGRectGetWidth(tableView.bounds);
    UIView *border = [[UIView alloc] initWithFrame:CGRectMake(0, 109, width, 0.5)];
    border.backgroundColor = [UIColor grayColor];
    border.alpha = 0.1;
    [cell.contentView addSubview: border];
    
    return cell;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGFloat width = CGRectGetWidth(tableView.bounds);
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0,0,width,height)];
    container.backgroundColor = [UIColor grayColor];
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    backgroundView.image = [UIImage imageNamed:@"myLibTableHeader.png"];
    [container addSubview: backgroundView];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,0,width,height)];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.font= [UIFont systemFontOfSize:14.0f];
    headerLabel.textColor = [UIColor grayColor];
    NSString *title = [self tableView:tableView titleForHeaderInSection:section];
    headerLabel.text = title;
    
    [container addSubview: headerLabel];
    
    return container;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = [[[myLibData objectAtIndex:0] objectAtIndex: 0] objectAtIndex: 0];
            break;
        case 1:
            sectionName = [[[myLibData objectAtIndex:1] objectAtIndex: 0] objectAtIndex: 0];
            break;
            // ...
        default:
            sectionName = @"Not Title";
            break;
    }
    return sectionName;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	// If our cell is selected, return double height
	return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"SELECTED ROW: %i", indexPath.row);
}

@end
