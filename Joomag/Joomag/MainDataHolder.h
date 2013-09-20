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
@property (strong, nonatomic) NSMutableArray * popularsData;
@property (strong, nonatomic) NSMutableArray * highlightedData;

@property (strong, nonatomic) NSMutableArray * filteredCategories;

@property (nonatomic, strong) NSMutableArray *categoriesList;

@property (strong, nonatomic) NSMutableArray * bookMarkData;

+ (MainDataHolder *) getInstance;

@end
