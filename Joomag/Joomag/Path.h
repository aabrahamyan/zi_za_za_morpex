

#import <Foundation/Foundation.h>


@interface Path : NSObject
{
	CGPathDrawingMode	drawMode;
	CGFloat				strokeWidth;
	UIColor*			color;
	CGPathRef			path;
}

@property (nonatomic, assign) CGPathDrawingMode drawMode;
@property (nonatomic, assign) CGFloat strokeWidth;
@property (nonatomic, retain) UIColor* color;

- (CGPathRef)path;
- (void)setPath:(CGPathRef)newPath;

- (void)renderToContext:(CGContextRef)context;

@end
