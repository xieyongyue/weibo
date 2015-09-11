//
//  ShoppingList.m
//  GouGouGou
//
//  Created by laouhn on 15/7/13.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "ShoppingList.h"

@implementation ShoppingList

- (void)dealloc
{
    self.title = nil;
    self.soldNumber = nil;
    self.picPath = nil;
    self.picId = nil;
    self.price = nil;
    self.ratePrice = nil;
    self.nick = nil;
    [super dealloc];
}

- (id)initWithTitle: (NSString *)title soldNumber: (NSString *)soldNuMber picPath: (NSString *)picPath picId: (NSString *)picId  price: (NSString *)price ratePrice: (NSString *)ratePrice nick: (NSString *)nick{
    if (self = [super init]) {
        self.title = title;
        self.soldNumber = soldNuMber;
        self.picPath = picPath;
        self.picId = picId;
        self.price = price;
        self.ratePrice = ratePrice;
        self.nick = nick;
    }
    return self;
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"title:%@, soldNumber: %@,picPath: %@, picId; %@, price: %@, ratePrice: %@, nick: %@", self.title, self.soldNumber, self.picPath, self.picId,self.price, self.ratePrice, self.nick];
}

@end
