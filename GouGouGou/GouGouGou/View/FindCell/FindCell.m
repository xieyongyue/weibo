//
//  FindCell.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/2.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "FindCell.h"
#import "TitleList.h"

@implementation FindCell

- (void)dealloc
{
    self.photoView = nil;
    self.label = nil;
    self.titleList = nil;
    [super dealloc];
}

- (void)setTitleList:(TitleList *)titleList {
    if (_titleList != titleList) {
        [_titleList release];
        _titleList = [titleList retain];
    }
    self.label.text = titleList.title;
    self.photoView.image =[UIImage imageNamed:titleList.pictureName];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGSize size = [UIScreen mainScreen].bounds.size;
        self.photoView = [[UIImageView alloc] initWithFrame:CGRectMake(size.width / 16, size.width / 16, size.width / 16, size.width / 16)];
        [self addSubview:self.photoView];
        [self.photoView release];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(size.width / 8 + size.height / 28.4, size.width / 16, size.height / 5.68, size.height / 28.4)];
        self.label.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.label];
        [self.label release];
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
