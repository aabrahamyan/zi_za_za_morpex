

#import "Path.h"
#import "PathGroup.h"
#import "TiledView.h"
#import <QuartzCore/QuartzCore.h>


@interface TiledView ()

- (CGAffineTransform)transformForTile:(CGPoint)tile;
- (NSArray*)pathGroupsForTile:(CGPoint)tile;

@end


@implementation TiledView

+ (Class)layerClass
{
	return [CATiledLayer class];
}


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
	{
        CATiledLayer * tiledLayer = (CATiledLayer *)[self layer];
        //tiledLayer.levelsOfDetail = 4;
        //tiledLayer.levelsOfDetailBias = 4;
        tiledLayer.tileSize = CGSizeMake(500.0, 500.0);
        
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


#pragma mark Tiled layer delegate methods

- (void)drawLayer:(CALayer*)layer inContext:(CGContextRef)context
{
	// Fetch clip box in *view* space; context's CTM is preconfigured for view space->tile space transform
	CGRect box = CGContextGetClipBoundingBox(context);
	//box.size.width = 500;
    //box.size.height = 500;
	// Calculate tile index
	CGFloat contentsScale = [layer respondsToSelector:@selector(contentsScale)]?[layer contentsScale]:1.0;

	CGSize tileSize = [(CATiledLayer*)layer tileSize];
	CGFloat x = box.origin.x * contentsScale / tileSize.width;
	CGFloat y = box.origin.y * contentsScale / tileSize.height;
	CGPoint tile = CGPointMake(x, y);
	
	// Clear background
	CGContextSetFillColorWithColor(context, [[UIColor grayColor] CGColor]);
	CGContextFillRect(context, box);
	
	// Rendering the paths
	CGContextSaveGState(context);
	CGContextConcatCTM(context, [self transformForTile:tile]);

	
	// Render label (Setup)
	UIFont* font = [UIFont fontWithName:@"CourierNewPS-BoldMT" size:16];
	CGContextSelectFont(context, [[font fontName] cStringUsingEncoding:NSASCIIStringEncoding], [font pointSize], kCGEncodingMacRoman);
	CGContextSetTextDrawingMode(context, kCGTextFill);
	CGContextSetTextMatrix(context, CGAffineTransformMakeScale(1, -1));
	CGContextSetFillColorWithColor(context, [[UIColor greenColor] CGColor]);
	
	// Draw label
	NSString* s = [NSString stringWithFormat:@"(%.1f, %.1f)",x,y];
	CGContextShowTextAtPoint(context,
							 box.origin.x,
							 box.origin.y + [font pointSize],
							 [s cStringUsingEncoding:NSMacOSRomanStringEncoding],
							 [s lengthOfBytesUsingEncoding:NSMacOSRomanStringEncoding]);
     
}

#pragma mark Extension methods

- (CGAffineTransform)transformForTile:(CGPoint)tile
{
	return CGAffineTransformIdentity;
}


- (NSArray*)pathGroupsForTile:(CGPoint)tile
{
	CGMutablePathRef	p;
	Path*				path;
	PathGroup*			pg = [PathGroup new];
	
	// Path 1
	path = [Path new];
	p = CGPathCreateMutable();
	CGPathAddEllipseInRect(p, NULL, CGRectMake(-95, -95, 190, 190));
	path.path = p;
	path.strokeWidth = 10;
	CGPathRelease(p);
	[pg.paths addObject:path];
	// Path 2
	path = [Path new];
	p = CGPathCreateMutable();
	CGPathAddRect(p, NULL, CGRectMake(-69.5, -51.5, 139, 103));
	path.path = p;
	path.strokeWidth = 5;
	CGPathRelease(p);
	[pg.paths addObject:path]; 
	
	// Center it, at some reasonable fraction of the world size
	// * The TiledView's bounds area always equals the size of view space
	// * With no scaling, the size of view space equals the size of world space
	// * The bounding box of the preceeding model is 200x200, centered about 0
	CGFloat scaleToFit = self.bounds.size.width*.25/200.0;
	CGAffineTransform s = CGAffineTransformMakeScale(scaleToFit, scaleToFit);
	CGAffineTransform t = CGAffineTransformMakeTranslation(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
	pg.modelTransform =  CGAffineTransformConcat(s, t);
	
	return [NSArray arrayWithObject:pg];
}

@end
