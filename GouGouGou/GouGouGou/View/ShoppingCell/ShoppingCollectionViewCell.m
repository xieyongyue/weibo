//
//  ShoppingCollectionViewCell.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/8.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "ShoppingCollectionViewCell.h"
#import "TitleList.h"
#import "UIImageView+WebCache.h"

@implementation ShoppingCollectionViewCell

- (void)dealloc
{
    self.titleList = nil;
    self.nameLabel = nil;
    self.pictureView = nil;
    [super dealloc];
}

- (void)setTitleList:(TitleList *)titleList {
    if (_titleList != titleList) {
        [_titleList release];
        _titleList = [titleList retain];
    }
     NSString *string = [NSString stringWithFormat:@"http://app.api.yijia.com/tb99/iphone/images/now_lsit/%@.png", titleList.CID];
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:string]placeholderImage:[UIImage imageNamed:@"暂无图片"]];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height * 0.7)];
        self.pictureView.userInteractionEnabled = YES;
        [self addSubview:self.pictureView];
        [self.pictureView release];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height * 0.8, frame.size.width, frame.size.height * 0.2)];
        self.nameLabel.font = [UIFont systemFontOfSize:13];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.nameLabel];
        [self.nameLabel release];
    }
    return self;
}

@end
