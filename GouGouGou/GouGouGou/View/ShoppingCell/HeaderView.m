//
//  HeaderView.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/8.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "HeaderView.h"
#import "TitleList.h"
#import "UIImageView+WebCache.h"

@implementation HeaderView

- (void)dealloc
{
    self.pictureView = nil;
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.pictureView];
        [self.pictureView release];
    }
    return self;
}

@end
