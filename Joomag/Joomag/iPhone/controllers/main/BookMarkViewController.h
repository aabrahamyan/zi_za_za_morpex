//
//  BookMarkViewController.h
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-09-09.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookMarkViewController : UIViewController

@property bool isOpen;

- (void) animateUpAndDown: (BOOL) isUP;
- (void) animateDown;

@end
