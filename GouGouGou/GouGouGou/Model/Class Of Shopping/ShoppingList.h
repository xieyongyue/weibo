//
//  ShoppingList.h
//  GouGouGou
//
//  Created by laouhn on 15/7/13.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingList : NSObject
@property(nonatomic, retain)NSString *title, *soldNumber, *picPath, *picId, *price, *ratePrice, *nick;

- (id)initWithTitle: (NSString *)title soldNumber: (NSString *)soldNuMber picPath: (NSString *)picPath picId: (NSString *)picId  price: (NSString *)price ratePrice: (NSString *)ratePrice nick: (NSString *)nick;
                                                                                        

@end
