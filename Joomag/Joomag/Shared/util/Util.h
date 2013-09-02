//
//  Util.h
//  Joomag
//
//  Created by Armen Abrahamyan on 7/29/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface Util : NSObject


+ (UIImage *) imageNamedSmart:(NSString *) name;

+ (NSString *) generateRequestBlock: (NSString *) pageNumber withMagazineId: (NSInteger) magazineId;

@end
