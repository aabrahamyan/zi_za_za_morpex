

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
