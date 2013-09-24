//
//  MoreViewController.h
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-09-20.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property bool isOpen;

@property (nonatomic, strong) UITableView *bookMarkTable;

@end
