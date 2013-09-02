//
//  Util.m
//  Joomag
//
//  Created by Armen Abrahamyan on 7/29/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "Util.h"
#import "Constants.h"

@implementation Util

+ (UIImage *) imageNamedSmart:(NSString *) name {
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        //NSLog(@"sadsadas %@", [NSString stringWithFormat:@"%@@2x.png", name]);
        //NSLog(@"sadsadas %@", [UIImage imageNamed:[NSString stringWithFormat:@"%@@2x.png", name]]);
        return [UIImage imageNamed:[NSString stringWithFormat:@"%@@2x.png", name]];
    } else {
        return [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", name]];
    }
}

+ (NSString *) generateRequestBlock: (NSString *) pageNumber withMagazineId: (NSInteger) magazineId {
    NSString * queryUri = [RANDOM_BLOCK_NUMBER stringByAppendingFormat:@"%@%@%d", pageNumber,GK,magazineId];
    
    return queryUri;
}

@end
