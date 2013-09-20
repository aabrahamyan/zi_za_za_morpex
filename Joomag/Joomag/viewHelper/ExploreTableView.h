//
//  ExploreTableView.h
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-08-07.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResponseTrackerDelegate.h"

@class ExploreViewController;

@interface ExploreTableView : UITableView  <UITableViewDelegate, UITableViewDataSource, ResponseTrackerDelegate> { 

    BOOL reloadFromDidSelect;
    NSInteger hierarchy;
}

@property (nonatomic, strong) ExploreViewController * callbacker;   

- (void)reloadExploreTable;

@end
