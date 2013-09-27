
#import <UIKit/UIKit.h>


@interface TiledView : UIView<UIGestureRecognizerDelegate> {

    NSMutableDictionary * mappingMatrix;
    NSArray *arrayTiles;
    int counterX;
    int counterY;
}

@property (nonatomic, assign) NSInteger magazineId;
@property (nonatomic, assign) NSInteger pageIdLeft;
@property (nonatomic, assign) NSInteger pageIdRight;

@end
