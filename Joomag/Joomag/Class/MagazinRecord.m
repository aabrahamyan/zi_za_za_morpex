//
//  MagazinRecord.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-07-19.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "MagazinRecord.h"


@implementation MagazinRecord

- (id)init {
    if (self = [super init]) {
        self.pageImageURLsArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@end


