//
//  PathGroup.m
//  zoomdemo
//
//  Created by Michael Heyeck on 3/10/10.
//  Copyright 2010 Fair Oaks Labs, Inc.. All rights reserved.
//

#import "PathGroup.h"


@implementation PathGroup

@synthesize paths;
@synthesize modelTransform;

- (NSMutableArray*)paths
{
	if (!paths)
	{
		paths = [[NSMutableArray alloc] initWithCapacity:1];
	}
	return paths;
}


- (id)init {
	if (self = [super init])
	{
		modelTransform = CGAffineTransformMakeScale(1.0, 1.0);
	}
	return self;
}

@end
