//
//  ImageDownloader.h
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-07-19.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MagazinRecord;

@interface ImageDownloader : NSObject

@property (nonatomic, strong) MagazinRecord *magazinRecord;
@property (nonatomic, copy) void (^completionHandler)(void);

- (void)startDownload;
- (void)cancelDownload;

@end
