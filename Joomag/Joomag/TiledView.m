

#import "Path.h"
#import "PathGroup.h"
#import "TiledView.h"
#import <QuartzCore/QuartzCore.h>
#import "Util.h"
#import "MainDataHolder.h"


@interface TiledView ()

- (CGAffineTransform)transformForTile:(CGPoint)tile;
- (NSArray*)pathGroupsForTile:(CGPoint)tile;    

@end


@implementation TiledView

+ (Class)layerClass {
	return [CATiledLayer class];
}


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        counterX = 0;
        counterY = 0;

        CATiledLayer * tiledLayer = (CATiledLayer *)[self layer];
        //tiledLayer.levelsOfDetail = 4;
        //tiledLayer.levelsOfDetailBias = 4;
        tiledLayer.tileSize = CGSizeMake(723, 630);//CGSizeMake([MainDataHolder getInstance].tileWidth, [MainDataHolder getInstance].tileHeight);
        
        
        mappingMatrix = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"00", @"40",
                         @"10", @"50", @"20",@"60",@"01",@"41",@"11",@"51",@"21",@"61",@"31",@"71",@"02",@"42",@"12",@"52",@"22",@"62",@"32",@"72",@"03",@"43",@"13",@"53",@"23",@"63",@"33",@"73",@"04",@"44",@"14",@"54",@"24",@"64",@"34",@"74",@"05",@"45",@"15",@"55",@"25",@"65",@"35",@"75",nil];
        
        arrayTiles = @[          @[@0, @0], @[@1, @0], @[@2, @0],@[@3, @0]
                               , @[@0, @1], @[@1, @1], @[@2, @1],@[@3, @1]
                               , @[@0, @2], @[@1, @2], @[@2, @2],@[@3, @2]
                               , @[@0, @3], @[@1, @3], @[@2, @3],@[@3, @3]
                               , @[@0, @4], @[@1, @4], @[@2, @4],@[@3, @4]
                               , @[@0, @5], @[@1, @5], @[@2, @5],@[@3, @5]];
        
        //UIPinchGestureRecognizer * pincher = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(didZoom:)];
        
        //[self addGestureRecognizer:pincher];
        
    }
    
    return self;
    
}

- (void) didZoom:(UIPinchGestureRecognizer *)recognizer { 
    
    //NSLog(@"Pinch scale: %f", recognizer.scale);
    //CGAffineTransform transform = CGAffineTransformMakeScale(recognizer.scale, recognizer.scale);

    //self.transform = transform;
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    return YES;
    
}




#pragma mark Tiled layer delegate methods

- (void) drawLayer:(CALayer*) layer inContext:(CGContextRef) context {
	// Fetch clip box in *view* space; context's CTM is preconfigured for view space->tile space transform
	CGRect box = CGContextGetClipBoundingBox(context);

	// Calculate tile index
	CGFloat contentsScale = [layer respondsToSelector:@selector(contentsScale)]?[layer contentsScale]:1.0;

    
    //[MainDataHolder getInstance]._scalingFactor;
    //[layer respondsToSelector:@selector(contentsScale)]?[layer contentsScale]:1.0;
    
	CGSize tileSize = [(CATiledLayer*) layer tileSize];    
    
	CGFloat x = box.origin.x * contentsScale / tileSize.width;
	CGFloat y = box.origin.y * contentsScale / tileSize.height;
    
   
    
    if(x == 8 || y == 6) {
        return;
    }
    
	//CGPoint tile = CGPointMake(x, y);
	
	// Clear background
	//CGContextSetFillColorWithColor(context, [[UIColor grayColor] CGColor]);
	//CGContextFillRect(context, box);
	
	// Rendering the paths
	//CGContextSaveGState(context);
	//CGContextConcatCTM(context, [self transformForTile:tile]);
    
    CGImageRef image = [self imageForScale:[MainDataHolder getInstance]._scalingFactor row:x col:y coordToDdecide: box.origin.x];

    
    if(NULL != image) {
        CGContextTranslateCTM(context, 0.0, box.size.height);
        CGContextScaleCTM(context, 1.0, -1.0); 
        box = CGContextGetClipBoundingBox(context);
        NSLog(@"NSStringFromCGSize(tileSize) = %@", NSStringFromCGRect(box));
        
        CGContextDrawImage(context, box, image);
        CGImageRelease(image);
    }
	
	// Render label (Setup)
	/*UIFont* font = [UIFont fontWithName:@"CourierNewPS-BoldMT" size:16];
	CGContextSelectFont(context, [[font fontName] cStringUsingEncoding:NSASCIIStringEncoding], [font pointSize], kCGEncodingMacRoman);
	CGContextSetTextDrawingMode(context, kCGTextFill);
	CGContextSetTextMatrix(context, CGAffineTransformMakeScale(1, -1));
	CGContextSetFillColorWithColor(context, [[UIColor greenColor] CGColor]);
	
	// Draw label
	NSString* s = [NSString stringWithFormat:@"(%.1f, %.1f)",x,y];
//    NSString* s = [NSString stringWithFormat:@"(%i, %i)",x1,y1];
    
    //NSLog(@"Box = %@", NSStringFromCGRect(box));
    
	CGContextShowTextAtPoint(context,
							 box.origin.x,
							 box.origin.y + [font pointSize],
							 [s cStringUsingEncoding:NSMacOSRomanStringEncoding],
							 [s lengthOfBytesUsingEncoding:NSMacOSRomanStringEncoding]);
 
    */
  
}

-(CGImageRef) imageForScale:(CGFloat)scale row:(int)row col:(int)col coordToDdecide: (CGFloat) ider {
    
    CGImageRef image = NULL;
    CGDataProviderRef provider = NULL;
    //NSString *filename = [NSString stringWithFormat:@"img_name_here%0.0f_%d_%d",ceilf(scale * 100),col,row];
    //NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"png"];
    
    //if(path != nil) {
    NSString * imageURLString = @"";
    
    
    
        NSString * numString = @"";
        
        NSString * valueToSend = [mappingMatrix objectForKey:[NSString stringWithFormat:@"%d%d",row,col]];
        
        if(valueToSend) {
            NSString * currentNumberString = [NSString stringWithFormat:@"%d", self.pageIdRight];
            if([currentNumberString length] == 1) {
                numString = [NSString stringWithFormat:@"0%@",currentNumberString];
            } else {
                numString = [NSString stringWithFormat:@"%@", currentNumberString];
            }
            
            imageURLString = [Util generatePageRequestBlock:numString pagePortion: valueToSend withMagazineId:self.magazineId];
        } else {
            
            NSString * currentNumberString = [NSString stringWithFormat:@"%d", self.pageIdLeft];
            
            if([currentNumberString length] == 1) {
                numString = [NSString stringWithFormat:@"0%@",currentNumberString];
            } else {
                numString = [NSString stringWithFormat:@"%@", currentNumberString];
            }

            
            imageURLString = [Util generatePageRequestBlock:numString pagePortion: [NSString stringWithFormat:@"%d%d",row,col] withMagazineId:self.magazineId];
        }
    
        //NSLog(@"imageURLString = = %@", imageURLString);
    
         
        NSURL *imageURL = [NSURL URLWithString:imageURLString];
        
        provider = CGDataProviderCreateWithURL((CFURLRef)CFBridgingRetain(imageURL));
        
       image = CGImageCreateWithPNGDataProvider(provider,NULL,FALSE,kCGRenderingIntentDefault);
        if(!image) {
           image = CGImageCreateWithJPEGDataProvider(provider,NULL,FALSE,kCGRenderingIntentDefault);
        }

    
        //NSLog(@" Image = %@",image);
        CFRelease(provider);
    
    //}
    
    return image; 
    
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
