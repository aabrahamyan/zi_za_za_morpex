//
//  ResponseTracker.h
//  Joomag
//
//  Created by Armen Abrahamyan on 8/2/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ResponseTrackerDelegate <NSObject>

- (void) didFailResponse: (id) responseObject;
- (void) didFinishResponse: (id) responseObject;

@end
