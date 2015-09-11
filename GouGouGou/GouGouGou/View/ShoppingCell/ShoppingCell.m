//
//  ShoppingCell.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/2.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "ShoppingCell.h"

@implementation ShoppingCell

- (void)dealloc
{
    self.nameLabel = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGSize size = [UIScreen mainScreen].bounds.size;
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width / 4.68, (size.height - 108) / 8)];
        self.nameLabel.font = [UIFont systemFontOfSize:15];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.backgroundColor = [UIColor colorWithWhite:0.958 alpha:1.000];
        [self addSubview:self.nameLabel];
        [self.nameLabel release];
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
