//
//  MainDataHolder.m
//  Joomag
//
//  Created by Armen Abrahamyan on 8/14/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "MainDataHolder.h"

@implementation MainDataHolder

static MainDataHolder * mainDataHolder;

- (id) init {
    if((self = [super init])) {
        // Init data here
        self.testData = [[NSMutableArray alloc] init];
    }
    
    return self;
}

+ (MainDataHolder *) getInstance {
    
    if(mainDataHolder == nil) {
        mainDataHolder = [[MainDataHolder alloc] init];
    }
    
    return mainDataHolder;
}

@end
