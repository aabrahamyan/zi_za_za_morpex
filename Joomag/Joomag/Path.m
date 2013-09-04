

#import "Path.h"


@implementation Path

@synthesize drawMode;
@synthesize strokeWidth;
@synthesize color;

- (CGPathRef)path
{
	return path;
}

- (void)setPath:(CGPathRef)newPath
{
	if (path != newPath)
	{
		CGPathRelease(path);
		path = CGPathRetain(newPath);
	}
}


- (id)init
{
    if (self = [super init])
	{
		self.drawMode		= kCGPathStroke;
		self.strokeWidth	= 10;
		self.color			= [UIColor blackColor];
    }
    return self;
}


- (void)renderToContext:(CGContextRef)context
{
	if (!path) return;
	
	CGContextAddPath(context, path);
	[color set];
	CGContextSetLineWidth(context, strokeWidth);
	CGContextDrawPath(context, drawMode);
}



@end
