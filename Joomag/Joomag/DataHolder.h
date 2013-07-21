//
//  DataHolder.h
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-07-21.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataHolder : NSObject

//Test Data For Showing in ScrollView
@property (strong, nonatomic) NSArray *testData;
@property float screenWidth;
@property float screenHeight;

+ (DataHolder *) sharedData;

@end
