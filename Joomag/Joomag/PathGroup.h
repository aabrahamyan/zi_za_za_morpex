

#import <Foundation/Foundation.h>


@interface PathGroup : NSObject
{
	NSMutableArray*		paths;
	CGAffineTransform	modelTransform;
}

@property (nonatomic, retain) NSMutableArray* paths;
@property (nonatomic, assign) CGAffineTransform	modelTransform;

@end
