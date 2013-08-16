//
//  ReadViewController.h
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-08-12.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReadViewController : UIViewController <UIGestureRecognizerDelegate, UIScrollViewDelegate> {
@protected
    UIView       *topView;
    UIButton     *backButtonView;
    UILabel      *titleLabelWithDate;
    UIScrollView *pageScrollView;
    UIView       *navScrollViewContainer;
    UIView       *buyView;
}

- (void)startDownloadMagazine: (NSInteger)number;

@end
