//
//  HelpBU.h
//  Joomag
//
//  Created by Armen Abrahamyan on 10/4/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HelpBO;

@interface HelpBU : UIView {
    
    UIButton * mainClickableButton;
}

@property (nonatomic, strong) HelpBO * helpBo;


- (void) setTileTitle: (int)xPosition : (int)yPosition ;

@end
