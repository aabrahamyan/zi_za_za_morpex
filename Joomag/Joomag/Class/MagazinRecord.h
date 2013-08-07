//
//  MagazinRecord.h
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-07-19.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MagazinRecord : NSObject

@property (nonatomic, strong) NSString *magazinTitle;
@property (nonatomic, strong) NSString *magazinAutor;
@property (nonatomic, strong) UIImage  *magazinIcon;
@property (nonatomic, strong) NSString *magazinImageURL;
@property (nonatomic, strong) NSString *magazinDetailsText;
@property (nonatomic, strong) NSString *magazinDetailsImageURL;
@property (nonatomic, strong) UIImage  *magazinDetailsIcon;

@property (nonatomic, strong) NSString *magazinTESTImageURL;
@property (nonatomic, strong) UIImage  *magazinTESTIcon;

@end
