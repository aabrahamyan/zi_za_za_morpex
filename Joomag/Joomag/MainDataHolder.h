//
//  MainDataHolder.h
//  Joomag
//
//  Created by Armen Abrahamyan on 8/14/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainDataHolder : NSObject



@property (nonatomic, strong) NSArray * magazinesList;
@property (strong, nonatomic) NSMutableArray * testData;

@property (nonatomic, strong) NSArray *categoriesList;


+ (MainDataHolder *) getInstance;

@end
