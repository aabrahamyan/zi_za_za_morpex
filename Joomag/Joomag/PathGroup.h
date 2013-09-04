//
//  PathGroup.h
//  zoomdemo
//
//  Created by Michael Heyeck on 3/10/10.
//  Copyright 2010 Fair Oaks Labs, Inc.. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PathGroup : NSObject
{
	NSMutableArray*		paths;
	CGAffineTransform	modelTransform;
}

@property (nonatomic, retain) NSMutableArray* paths;
@property (nonatomic, assign) CGAffineTransform	modelTransform;

@end
