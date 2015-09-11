//
//  ThemeCollectionViewCell.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/3.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "ThemeCollectionViewCell.h"

@implementation ThemeCollectionViewCell

- (void)dealloc
{
    self.imageView = nil;
    self.titleLabel = nil;
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height * 0.75)];
        [self addSubview:self.imageView];
        [self.imageView release];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height * 0.80, frame.size.width, frame.size.height * 0.20)];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        [self.titleLabel release];
    }
    return self;
}

@end
