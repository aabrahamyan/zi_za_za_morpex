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
@property (nonatomic, strong) NSArray * popularMagList;
@property (nonatomic, strong) NSArray * highlightedMagList;

@property (strong, nonatomic) NSMutableArray * testData;

@property (nonatomic, strong) NSArray *categoriesList;

@property (strong, nonatomic) NSMutableArray * bookMarkData;

+ (MainDataHolder *) getInstance;

@end
