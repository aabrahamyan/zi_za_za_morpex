//
//  MyLibScrollView.h
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-09-05.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLibScrollView : UIScrollView <UIScrollViewDelegate>

// the main data model for our UIScrollView
@property (nonatomic, strong) NSArray *entries;

@end
