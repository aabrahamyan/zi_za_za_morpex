//
//  ConnectionManager.h
//  Joomag
//
//  Created by Armen Abrahamyan on 8/1/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseTrackerDelegate.h"

@interface ConnectionManager : NSObject


- (void) constructLoginRequest: (NSString * ) email withPassword : (NSString *) password withCallback : (id<ResponseTrackerDelegate>) callback;

- (void) constructGetMagazineRequest: (NSInteger) magazineId withCallback : (id<ResponseTrackerDelegate>) callback;

- (void) constructGetMapagzinePage: (NSInteger) magazineId withPageNumber : (NSInteger) pageNumber andWithDelegate : (id<ResponseTrackerDelegate>) callback;

@end
