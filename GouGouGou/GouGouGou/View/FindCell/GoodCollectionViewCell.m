//
//  GoodCollectionViewCell.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/10.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "GoodCollectionViewCell.h"
#import "TitleList.h"
#import "UIImageView+WebCache.h"

@implementation GoodCollectionViewCell

- (void)dealloc
{
    self.pictureView = nil;
    self.titleLabel = nil;
    self.countLabel = nil;
    self.nowLabel = nil;
    self.originLabel = nil;
    self.titleList = nil;
    [super dealloc];
}

- (void)setTitleList:(TitleList *)titleList {
    if (_titleList != titleList) {
        [_titleList release];
        _titleList = [titleList retain];
    }
    self.countLabel.text = titleList.discount;
    self.nowLabel.text = [NSString stringWithFormat:@"￥%@", titleList.now_price];
    self.originLabel.text = titleList.origin_price;
    self.titleLabel.text = titleList.title;
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:titleList.pictureName]placeholderImage:[UIImage imageNamed:@"暂无图片"]];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height / 1.3)];
        [self addSubview:self.pictureView];
        [self.pictureView release];
        
        self.originLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, frame.size.height / 1.53, 40, frame.size.height / 15)];
        self.originLabel.font = [UIFont systemFontOfSize:12];
        self.originLabel.textAlignment = NSTextAlignmentCenter;
        self.originLabel.numberOfLines = 0;
        self.originLabel.font = [UIFont systemFontOfSize:14];
        self.originLabel.layer.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000].CGColor;
        self.originLabel.textColor = [UIColor colorWithWhite:0.702 alpha:1.000];
        self.originLabel.layer.cornerRadius = 10;
        [self addSubview:self.originLabel];
        [self.originLabel release];

        self.nowLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height / 1.6, 40, frame.size.height / 10.0)];
        self.nowLabel.textAlignment = NSTextAlignmentCenter;
        self.nowLabel.font = [UIFont systemFontOfSize:14];
        self.nowLabel.numberOfLines = 0;
        [self addSubview:self.nowLabel];
        [self.nowLabel release];
       
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height / 1.3, frame.size.width, 40)];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor colorWithRed:0.400 green:0.800 blue:1.000 alpha:1.000];
        self.titleLabel.numberOfLines = 0;
        [self addSubview:self.titleLabel];
        [self.titleLabel release];
        
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width - frame.size.width / 2.5, -5, frame.size.width / 2.3, frame.size.height / 6.9)];
        self.countLabel.textColor = [UIColor colorWithRed:1.000 green:0.000 blue:0.502 alpha:1.000];
        self.countLabel.textAlignment = NSTextAlignmentLeft;
        self.countLabel.font = [UIFont systemFontOfSize:12];
        self.countLabel.numberOfLines = 0;
        [self addSubview:self.countLabel];
        [self.countLabel release];        
    }
    return self;
}

@end
