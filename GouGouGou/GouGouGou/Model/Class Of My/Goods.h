//
//  Goods.h
//  GouGouGou
//
//  Created by lanouhn on 15/7/14.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Goods : NSObject

@property(nonatomic ,retain)NSString *image_string,*now_price, *original_price, *discount, *title, *goodsid, *goodskind;
@property (nonatomic, assign) NSInteger  ID;

@end
