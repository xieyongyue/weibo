//
//  CenterCollectionViewCell.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/10.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "CenterCollectionViewCell.h"

@implementation CenterCollectionViewCell

- (void)dealloc
{
    self.Goodstitlelabel = nil;
    self.all_buy_view = nil;
    self.worth_to_buy_view = nil;
    self.tommorrow_view = nil;
    self.have_a_try_view = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        CGSize size = [[UIScreen mainScreen] bounds].size;
        self.all_buy_view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"大家都在买"]];
        self.all_buy_view.frame = CGRectMake(0, 0, size.width/3., size.height/5);
        [self addSubview:self.all_buy_view];
        [self.all_buy_view release];//大家都在买
        
        self.worth_to_buy_view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"值得买"]];
        self.worth_to_buy_view.frame = CGRectMake(size.width/3., 0, size.width/3, size.height/5);
        [self addSubview:self.worth_to_buy_view];
        [self.worth_to_buy_view release];//值得买
        
        
        
        self.tommorrow_view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"明日抢"]];
        self.tommorrow_view.frame = CGRectMake(size.width * 2/3.,size.height/10, size.width/3., size.height/10);
        [self addSubview:self.tommorrow_view];
        [self.tommorrow_view release];//明日抢
        
        self.have_a_try_view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"试试手气"]];
        self.have_a_try_view.frame = CGRectMake(size.width * 2/3., 0, size.width/3., size.height/10);
        [self addSubview:self.have_a_try_view];
        [self.have_a_try_view release];//试试手气
        
        self.Goodstitlelabel = [[UILabel alloc ] initWithFrame:CGRectMake(0, size.height/5, size.width/4 , size.height/15)];
        self.Goodstitlelabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.Goodstitlelabel];
        [self.Goodstitlelabel release];
        
        
    }
    return self;
}

@end
