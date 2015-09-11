//
//  GoodCell.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/7.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "GoodCell.h"
#import "TitleList.h"
#import "UIImageView+WebCache.h"

@implementation GoodCell

- (void)dealloc
{
    self.pictureView = nil;
    self.label = nil;
    self.logoView = nil;
    self.countLabel = nil;
    self.nameLabel = nil;
    self.timeLabel = nil;
    self.titleList = nil;
    [super dealloc];
}

- (void)setTitleList:(TitleList *)titleList {
    if (_titleList != titleList) {
        [_titleList release];
        _titleList = [titleList retain];
    }
    self.countLabel.text = titleList.discount;
    self.nameLabel.text = titleList.goodName;
    self.timeLabel.text = titleList.topicTime;
    self.label.text = titleList.title;
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:titleList.pictureName] placeholderImage:[UIImage imageNamed:@"暂无图片"]];
    [self.logoView sd_setImageWithURL:[NSURL URLWithString:titleList.logo]];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect rect = [UIScreen mainScreen].bounds;
        self.logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, rect.size.height / 22.2)];
        [self addSubview:self.logoView];
        [self.logoView release];
        
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 0,rect.size.width / 2.0 , rect.size.height / 22.2)];
        self.countLabel.textColor = [UIColor colorWithRed:0.986 green:0.126 blue:0.705 alpha:1.000];
        self.countLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.countLabel];
        [self.countLabel release];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, rect.size.height / 22.2, rect.size.width / 5.0 * 2.8, rect.size.height / 5.1)];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.numberOfLines = 0;
        [self addSubview:self.nameLabel];
        [self.nameLabel release];
        
        self.pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(rect.size.width / 5.0 * 3, rect.size.height / 22.2 - 10, rect.size.width / 5.0 * 1.7, rect.size.height / 5.1)];
        [self addSubview:self.pictureView];
        [self.pictureView release];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, rect.size.height / 5.1 + rect.size.height / 22.2, rect.size.width / 5 * 2, rect.size.height / 22.2)];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        self.timeLabel.numberOfLines = 0;
        self.timeLabel.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
        [self addSubview:self.timeLabel];
        [self.timeLabel release];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(rect.size.width / 5 * 2.05, rect.size.height / 5.1 + rect.size.height / 22.2, rect.size.width / 5 * 3, rect.size.height / 22.2)];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
        self.label.numberOfLines = 0;
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
