//
//  ScrollView.h
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-07-20.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollView : UIScrollView <UIScrollViewDelegate>

// the main data model for our UIScrollView
@property (nonatomic, strong) NSArray *entries;

@end
