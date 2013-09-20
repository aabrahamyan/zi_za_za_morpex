//
//  ExploreCatsTableViewCell.m
//  Joomag
//
//  Created by Armen Abrahamyan on 9/20/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "ExploreCatsTableViewCell.h"
#import "Util.h"

@implementation ExploreCatsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL) animated {
    [super setSelected:selected animated:animated];    
}

- (void) constructStructure: (CGFloat) x1 : (CGFloat) x2 {
    
    UIImageView *cellBg = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"exploreCell.png"]];
    
    self.backgroundView = cellBg;
    CGRect lbl1Frame;
    CGRect lbl2Frame;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        self.backgroundView.frame = CGRectMake(0, 0, 320, 50);
        lbl1Frame = CGRectMake(20, 0, 140, 50);
        lbl2Frame = CGRectMake(180, 0, 140, 50);
    } else {
        lbl1Frame = CGRectMake(x1 , 0, 140, 50);
        lbl2Frame = CGRectMake(x2, 0, 140, 50);
    }
    
    label1 = [[UILabel alloc] initWithFrame:lbl1Frame];
    label1.textColor = [UIColor whiteColor];
    label1.backgroundColor = [UIColor clearColor];
    label1.font = [UIFont boldSystemFontOfSize:16.0];
    label1.highlightedTextColor = [UIColor redColor];
    
    [self.contentView addSubview: label1];
    
    label2 = [[UILabel alloc] initWithFrame:lbl2Frame]; 
        
    label2.textColor = [UIColor whiteColor];
    label2.backgroundColor = [UIColor clearColor];
    label2.font = [UIFont boldSystemFontOfSize:16.0];
    label2.highlightedTextColor = [UIColor redColor];
    
    [self.contentView addSubview: label2];

}

- (void) setData: (NSDictionary *) data1 : (NSDictionary *) data2 {
    label1.text = [data1 objectForKey:@"name"];
    label2.text = [data2 objectForKey:@"name"];
}

@end
