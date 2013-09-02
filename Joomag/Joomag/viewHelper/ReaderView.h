//
//  ReaderView.h
//  Joomag
//
//  Created by Armen Abrahamyan on 8/29/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReaderView : UIView {
    
    
    
}

@property (nonatomic, assign) BOOL isLandscape;
@property (nonatomic, strong) UIImageView * leftImageView;
@property (nonatomic, strong) UIImageView * rightImageView;
@property (nonatomic, strong) UIImage * leftImage;
@property (nonatomic, strong) UIImage * rightImage;
@property (nonatomic, assign) NSInteger zoomLevel;


- (id) initWithFrameAndImages:(CGRect) frame withLeftImageView: (UIImage *) leftImageView withRightImageView: (UIImage *) rightImageView withLeftFrame:  (CGRect) leftFrame withRightFrame: (CGRect) rightFrame;

@end
