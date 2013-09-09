
#import <UIKit/UIKit.h>


@interface TiledView : UIView {

    NSMutableDictionary * mappingMatrix;
    
}

@property (nonatomic, assign) NSInteger magazineId;
@property (nonatomic, assign) NSInteger pageIdLeft;
@property (nonatomic, assign) NSInteger pageIdRight;

@end
