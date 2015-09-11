//
//  NumberHandle.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/10.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "NumberHandle.h"

@implementation NumberHandle

+ (NumberHandle *)defaultNumberHandle {
    static NumberHandle *handle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //内部代码只会被执行一次, 无论是单线程还是多线程
        handle = [[NumberHandle alloc] init];
    });
    return handle;
}


@end
