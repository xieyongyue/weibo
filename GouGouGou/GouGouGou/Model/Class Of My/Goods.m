//
//  Goods.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/14.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "Goods.h"

@implementation Goods

- (void)dealloc{
//    *now_price, *original_price, *discount, *title
    self.goodskind = nil;
    self.image_string = nil;
    self.now_price = nil;
    self.original_price = nil;
    self.discount = nil;
    self.title = nil;
    [super dealloc];
}



@end
