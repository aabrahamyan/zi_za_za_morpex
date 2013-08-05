//
//  FeaturedScrollView.h
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-07-20.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeaturedScrollView : UIScrollView <UIScrollViewDelegate>

// the main data model for our UIScrollView
@property (nonatomic, strong) NSArray *entries;

@property (nonatomic, assign) NSInteger currentPage;

@end
