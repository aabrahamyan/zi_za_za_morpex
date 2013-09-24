//
//  Util.h
//  Joomag
//
//  Created by Armen Abrahamyan on 7/29/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPAD ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPad" ] )

@interface Util : NSObject

+ (UIImage *) imageNamedSmart:(NSString *) name;

+ (NSString *) generateRequestBlock: (NSString *) pageNumber withMagazineId: (NSInteger) magazineId;

+ (NSString *) generatePageRequestBlock: (NSString *) pageNumber pagePortion: (NSString *) portion withMagazineId: (NSInteger) magazineId;

+ (CGRect) calculateLabelFrame : (UILabel *) lbl;

@end
