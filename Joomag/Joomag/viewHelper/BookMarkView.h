//
//  BookMarkView.h
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-09-09.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookMarkView : UIView

- (id)initWithFrame: (CGRect)frame
          withImage: (UIImage *)image
              title: (NSString *)titleStr
               date: (NSString *)dateStr
               desc: (NSString *)descStr
         bookMarkId: (int)bookMarkID;

@end
