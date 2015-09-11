//
//  DataBaseManager.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/14.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "DataBaseManager.h"

@implementation DataBaseManager

static sqlite3 *sqlite = nil;

+ (sqlite3 *)openDataBase {
    if (sqlite != nil) {
        return sqlite;
    }
    NSString *docmentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dataBasePath = [docmentsPath stringByAppendingPathComponent:@"Goods.sqlite"];
    sqlite3_open([dataBasePath UTF8String], &sqlite);
    return sqlite;
}

+ (void)closeDataBase {
    //传入数据库指针, 关闭数据库
    sqlite3_close(sqlite);
    sqlite = nil;
}














@end
