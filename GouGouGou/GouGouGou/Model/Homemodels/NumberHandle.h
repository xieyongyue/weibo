//
//  NumberHandle.h
//  GouGouGou
//
//  Created by lanouhn on 15/7/10.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NumberHandle : NSObject

@property (nonatomic, assign) NSInteger selectedIndex;
@property(nonatomic, assign)BOOL flag;

+ (NumberHandle *)defaultNumberHandle;
@end
