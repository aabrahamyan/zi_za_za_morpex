//
//  ReadViewController.h
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-08-12.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResponseTrackerDelegate.h" 
#import "SDImageCacheDelegate.h"

@interface ReadViewController : UIViewController <UIGestureRecognizerDelegate, UIScrollViewDelegate, ResponseTrackerDelegate, SDImageCacheDelegate> {

    NSMutableDictionary * pageImages;
    NSMutableArray * pageViews;
    
@protected
    UIView       *topView;
    UIButton     *backButtonView;
    UILabel      *titleLabelWithDate;
    UIScrollView *pageScrollView;
    UIView       *navScrollViewContainer;
    UIView       *buyView;
    
}

@property (nonatomic, assign) NSInteger currentMagazineId;

- (void)startDownloadMagazine: (NSInteger)number withImageUrl : (NSString *) imgUrl;

- (void) hitPageDescription : (NSInteger) magazineId;

@end
