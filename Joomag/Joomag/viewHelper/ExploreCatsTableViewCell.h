//
//  ExploreCatsTableViewCell.h
//  Joomag
//
//  Created by Armen Abrahamyan on 9/20/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExploreCatsTableViewCell : UITableViewCell {
    
    UILabel * label1;
    UILabel * label2;
    
}

- (void) constructStructure: (CGFloat) x1 : (CGFloat) x2;
- (void) setData: (NSDictionary *) data1 : (NSDictionary *) data2;

@end
