//
//  LefisliderTableViewCell.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/3.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "LeftsliderTableViewCell.h"

@implementation LeftsliderTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)dealloc
{
    self.sliderimageview = nil;
    self.titillabel = nil;
    self.detaillabel = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.sliderimageview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 50, [UIScreen mainScreen].bounds.size.height/11)];
        [self addSubview:self.sliderimageview];
        [self.sliderimageview release];
        
        self.titillabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, 40, [UIScreen mainScreen].bounds.size.height/11)];
        [self addSubview:self.titillabel];
        [self.titillabel release];
        
        self.detaillabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 0, 20, [UIScreen mainScreen].bounds.size.height/11)];
        [self addSubview:self.detaillabel];
        [self.detaillabel release];
        
        
    }
    
    return self;
}

@end
