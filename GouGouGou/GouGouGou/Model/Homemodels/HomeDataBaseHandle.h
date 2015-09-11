//
//  HomeDataBaseHandle.h
//  GouGouGou
//
//  Created by lanouhn on 15/7/15.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Goods;
@class Scroltltle;
@interface HomeDataBaseHandle : NSObject

@property(nonatomic, retain)NSMutableArray *ScrollArray, *Goodslist;
+ (HomeDataBaseHandle *)shareDataBaseHandle;
- (void)addGoods:(Goods *)goods;
- (void)createTable;
- (void)searcAlldic;
- (void)deleteGoods;
- (void)deleteSameGoodskind:(Goods *)good;


- (void)addScrol:(Scroltltle *)title;
- (void)createScroltable;
- (void)searcAllscroll;
- (void)deleteAllscroll;

@end
