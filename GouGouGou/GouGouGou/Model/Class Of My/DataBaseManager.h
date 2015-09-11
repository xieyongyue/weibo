//
//  DataBaseManager.h
//  GouGouGou
//
//  Created by lanouhn on 15/7/14.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface DataBaseManager : NSObject

//sqlite, 数据库

//打开数据库, 并返回数据库指针
+ (sqlite3 *)openDataBase;

//关闭数据库
+ (void)closeDataBase;

@end
