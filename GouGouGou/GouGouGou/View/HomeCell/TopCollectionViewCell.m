//
//  TopCollectionViewCell.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/10.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "TopCollectionViewCell.h"

@implementation TopCollectionViewCell

- (void)dealloc
{
    self.sdCycleScrollView = nil;
    
    //self.Homepagescrollview = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
       
        CGSize size = [[UIScreen mainScreen] bounds].size;
        self.purchaseimageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"限时抢"]];
        self.purchaseimageview.frame = CGRectMake(0, size.height/4, size.width/4., size.height/15);
        [self addSubview:self.purchaseimageview];//限时抢button的添加
        
        self.rechargeimageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"充值"]];
        self.rechargeimageview.frame = CGRectMake(size.width/4., size.height/4, size.width/4., size.height/15);
        [self addSubview:self.rechargeimageview];//充值button的添加
        
        self.lifestreetimageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"生活街"]];
        self.lifestreetimageview.frame = CGRectMake(size.width/2., size.height/4, size.width/4., size.height/15);
        [self addSubview:self.lifestreetimageview];//生活街button添加
        
        self.lotteryimageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"彩票"]];
        self.lotteryimageview.frame = CGRectMake(size.width*3/4., size.height/4, size.width/4., size.height/15);
        [self addSubview:self.lotteryimageview];//彩票button添加
        
        self.sdCycleScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, size.width   , size.height/4)];
        [self addSubview:self.sdCycleScrollView];
                                  
        
        
        
        
    }
    return self;
}

@end
