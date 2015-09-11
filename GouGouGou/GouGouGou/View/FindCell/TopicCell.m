//
//  TopicCell.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/3.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "TopicCell.h"
#import "TitleList.h"
#import "UIImageView+WebCache.h"

@implementation TopicCell

- (void)dealloc
{
    self.pictureView = nil;
    self.label = nil;
    self.timeLabel = nil;
    self.titleList = nil;
    [super dealloc];
}

- (void)setTitleList:(TitleList *)titleList {
    if (_titleList != titleList) {
        [_titleList release];
        _titleList = [titleList retain];
    }
    self.timeLabel.text = titleList.topicTime;
    self.label.text = titleList.title;
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:titleList.pictureName] placeholderImage:[UIImage imageNamed:@"暂无图片"]];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect rect = [UIScreen mainScreen].bounds;
        self.pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height / 4.5)];
        [self addSubview:self.pictureView];
        [self.pictureView release];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, rect.size.height / 4.5, rect.size.width / 5 * 2, rect.size.height / 12.0)];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        self.timeLabel.font = [UIFont systemFontOfSize:13];
        self.timeLabel.numberOfLines = 0;
        self.timeLabel.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
        [self addSubview:self.timeLabel];
        [self.timeLabel release];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(rect.size.width / 5 * 2.05, rect.size.height / 4.5, rect.size.width / 5 * 3, rect.size.height / 12.0)];
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
