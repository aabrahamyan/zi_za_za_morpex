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
        return [UIImage imageNamed:[NSString stringWithFormat:@"%@_iPad.png", name]];
    } else {
        return [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", name]];
    }
}

+ (NSString *) generateRequestBlock: (NSString *) pageNumber withMagazineId: (NSInteger) magazineId {
    NSString * queryUri = [RANDOM_BLOCK_NUMBER stringByAppendingFormat:@"%@%@%d", pageNumber,GK,magazineId];
    
    return queryUri;
}

+ (NSString *) generatePageRequestBlock: (NSString *) pageNumber pagePortion: (NSString *) portion withMagazineId: (NSInteger) magazineId {
    NSString * queryUri = [@"http://www.joomag.com/Frontend/WebService/getPageG.php?token=" stringByAppendingFormat:@"%@",RANDOM_BLOCK_NUMBER];
    
    queryUri = [queryUri stringByAppendingFormat:@"%@%@%d", pageNumber, portion,magazineId];
    queryUri = [queryUri stringByAppendingFormat:@"%@",@"&si=2"];
    
    return queryUri;
}

@end
