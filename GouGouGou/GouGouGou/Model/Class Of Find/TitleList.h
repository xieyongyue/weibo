//
//  TitleList.h
//  GouGouGou
//
//  Created by lanouhn on 15/7/2.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TitleList : NSObject<NSCoding>

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, retain) NSString *CID;//商品ID

@property (nonatomic, retain) NSString *title, *pictureName;//列表标题, 列表图片名字

@property (nonatomic, retain)  NSString *topicTime;//主题街商品当前时间 空白

@property (nonatomic, retain) NSString *brandName;//品牌团商品名称

@property (nonatomic, retain) NSString *discount, *goodName, *logo;//折扣, 商品名, logo

@property (nonatomic, retain) NSString *now_price, *origin_price;//现价, 旧价格

- (id)initWithTitle:(NSString *)title pictureName:(NSString *)pictureName;//Find页面初始化

+ (id)titleListWithTitle:(NSString *)title pictureName:(NSString *)pictureName;//Find页面便利构造器

@end
