//
//  HomeDataBaseHandle.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/15.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "HomeDataBaseHandle.h"
#import "DataBaseManager.h"
#import "Goods.h"
#import "Scroltltle.h"

static HomeDataBaseHandle *handle = nil;
@implementation HomeDataBaseHandle

+ (HomeDataBaseHandle *)shareDataBaseHandle{
    if (handle == nil) {
        handle = [[HomeDataBaseHandle alloc] init];
        handle.ScrollArray = [[NSMutableArray alloc] initWithCapacity:0];
        handle.Goodslist = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return handle;
}


- (void)createTable{
    sqlite3 *db =  [DataBaseManager openDataBase];
    sqlite3_stmt *stmt = nil;
    NSString *sqlString = [NSString stringWithFormat:@"create table if not exists \"GoodsTable1\"(\"id\" integer primary key, \"image_string\" text, \"now_price\" text, \"original_price\" text,\"discount\"  text,\"title\" text, \"goodsid\" text, \"goodskind\" text)"];
    int result = sqlite3_prepare_v2(db, [sqlString UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        char *error = NULL;
        int result1 = sqlite3_exec(db, [sqlString UTF8String], NULL, NULL, &error);
        if (result1 == SQLITE_OK) {
            
        }else{
            
        }
    }
    
    [DataBaseManager closeDataBase];
}
- (void)addGoods:(Goods *)goods{
    //打开数据库
    sqlite3  *db = [DataBaseManager openDataBase];
    //sql语句指针
    sqlite3_stmt *stmt = nil;
    //sql语句字符串
    NSString *sqlString = [NSString stringWithFormat:@"insert into \"GoodsTable1\" (\"image_string\", \"now_price\", \"original_price\", \"discount\", \"title\", \"goodsid\", \"goodskind\")values (\"%@\", \"%@\",\"%@\", \"%@\",\"%@\",\"%@\", \"%@\")", goods.image_string, goods.now_price, goods.original_price, goods.discount, goods.title, goods.goodsid, goods.goodskind];
    
    //准备sql, 判断语句的正确性
    
    int result = sqlite3_prepare_v2(db, [sqlString UTF8String], -1, &stmt, NULL);
   
    
    if (result == SQLITE_OK) {
        //执行语句
        char *error = NULL;
        int result1 = sqlite3_exec(db, [sqlString UTF8String], NULL, NULL, &error);
        
        if (result1 == SQLITE_OK) {
            
        }else{
            
        }
    }
    [DataBaseManager closeDataBase];
}

- (void)searcAlldic{
    sqlite3  *db = [DataBaseManager openDataBase];
    
    [handle.Goodslist removeAllObjects];
    sqlite3_stmt *stmt = nil;
    //sql语句字符串
    NSString *sqlString =@"select * from \"GoodsTable1\"";
    //准备语句, 判断语句正确性
    int result = sqlite3_prepare_v2(db, [sqlString UTF8String], -1, &stmt, NULL);
    //判断语句是否正确
    if (result == SQLITE_OK) {
        //执行语句
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            int  ID = sqlite3_column_int(stmt, 0);
            const unsigned char *image_string = sqlite3_column_text(stmt, 1);
            const unsigned char  *now_price = sqlite3_column_text(stmt, 2);
            const unsigned char  *original_price = sqlite3_column_text(stmt, 3);
            const unsigned char  *discount = sqlite3_column_text(stmt, 4);
            const unsigned char  *title = sqlite3_column_text(stmt, 5);
            const unsigned char  *goodsid = sqlite3_column_text(stmt, 6);
            const unsigned char  *goodskind = sqlite3_column_text(stmt, 7);
            Goods *goods = [[Goods alloc] init];
            goods.ID = ID;
            
            goods.image_string = [NSString stringWithUTF8String:(const char *) image_string];
            goods.now_price = (NSString *)[NSString stringWithUTF8String:(const char *) now_price];
            goods.original_price = (NSString *)[NSString stringWithUTF8String:(const char *) original_price];
            goods.discount = (NSString *)[NSString stringWithUTF8String:(const char *) discount];
            goods.title = (NSString *)[NSString stringWithUTF8String:(const char *) title];
            goods.goodsid = (NSString *)[NSString stringWithUTF8String:(const char *) goodsid];
            goods.goodskind = (NSString *)[NSString stringWithUTF8String:(const char *) goodskind];
            
            [handle.Goodslist addObject:goods];
        }
        
        
    }
    
    [DataBaseManager closeDataBase];
}

- (void)deleteGoods{
    //打开数据库
    sqlite3 *db = [DataBaseManager openDataBase];
    //sql语句指针
    sqlite3_stmt *stmt = nil;
    //sql语句字符串
    NSString *sqlString = [NSString stringWithFormat:@"delete from \"GoodsTable1\""];
    //sql准备字符串
    int result = sqlite3_prepare_v2(db, [sqlString UTF8String], -1, &stmt, NULL);
    //判断语句正确性
    if (result == SQLITE_OK) {
        //执行语句
        char *error = nil;
        int result = sqlite3_exec(db, [sqlString UTF8String], NULL, NULL, &error);
        if (result == SQLITE_OK) {
            
        }else{
            
        }
    }
    [DataBaseManager closeDataBase];
}

- (void)deleteSameGoodskind:(Goods *)good{
    sqlite3 *db = [DataBaseManager openDataBase];
    sqlite3_stmt *stmt = nil;
    NSString *sqlString = [NSString stringWithFormat:@"delete from \"GoodsTable1\" where \"ID\" = %ld", (long)good.ID];
    int result = sqlite3_prepare_v2(db, [sqlString UTF8String], -1, &stmt, NULL);

    if (result == SQLITE_OK) {
        
        char *error = nil;
        int result = sqlite3_exec(db, [sqlString UTF8String], NULL, NULL, &error);
        if (result == SQLITE_OK) {
           
        }else{
           
        }
    }
    [DataBaseManager closeDataBase];
}


//Scrolltitle的数据库
- (void)createScroltable{
    sqlite3 *db =  [DataBaseManager openDataBase];
    sqlite3_stmt *stmt = nil;
    NSString *sqlString = [NSString stringWithFormat:@"create table if not exists \"ScrollTable\"(\"id\" integer primary key, \"imagestring\" text, \"link\" text, \"title\" text)"];
    int result = sqlite3_prepare_v2(db, [sqlString UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        char *error = NULL;
        int result1 = sqlite3_exec(db, [sqlString UTF8String], NULL, NULL, &error);
        if (result1 == SQLITE_OK) {
            
        }else{
            
        }
    }
    
    [DataBaseManager closeDataBase];
}
- (void)addScrol:(Scroltltle *)title{
    //打开数据库
    sqlite3  *db = [DataBaseManager openDataBase];
    //sql语句指针
    sqlite3_stmt *stmt = nil;
    //sql语句字符串
    NSString *sqlString = [NSString stringWithFormat:@"insert into \"ScrollTable\" (\"imagestring\", \"link\", \"title\")values (\"%@\", \"%@\", \"%@\")", title.imagestring, title.link,title.title];
    
    //准备sql, 判断语句的正确性
    
    int result = sqlite3_prepare_v2(db, [sqlString UTF8String], -1, &stmt, NULL);
   
    
    if (result == SQLITE_OK) {
        //执行语句
        char *error = NULL;
        int result1 = sqlite3_exec(db, [sqlString UTF8String], NULL, NULL, &error);
        
        if (result1 == SQLITE_OK) {
            
        }else{
            
        }
    }
    [DataBaseManager closeDataBase];
}

- (void)searcAllscroll{
    sqlite3  *db = [DataBaseManager openDataBase];
    
    [handle.ScrollArray removeAllObjects];
    sqlite3_stmt *stmt = nil;
    //sql语句字符串
    NSString *sqlString =@"select * from \"ScrollTable\"";
    //准备语句, 判断语句正确性
    int result = sqlite3_prepare_v2(db, [sqlString UTF8String], -1, &stmt, NULL);
    //判断语句是否正确
    if (result == SQLITE_OK) {
        //执行语句
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            const unsigned char *imagestring = sqlite3_column_text(stmt, 1);
            const unsigned char  *link = sqlite3_column_text(stmt, 2);
            const unsigned char  *title = sqlite3_column_text(stmt, 3);
            Scroltltle *scroltitle = [[Scroltltle alloc] init];
            
            scroltitle.imagestring = [NSString stringWithUTF8String:(const char *) imagestring];
            scroltitle.link = (NSString *)[NSString stringWithUTF8String:(const char *) link];
            scroltitle.title = (NSString *)[NSString stringWithUTF8String:(const char *) title];
            
            [handle.ScrollArray addObject:scroltitle];
        }
        
}
    [DataBaseManager closeDataBase];
    
}
- (void)deleteAllscroll{
    //打开数据库
    sqlite3 *db = [DataBaseManager openDataBase];
    //sql语句指针
    sqlite3_stmt *stmt = nil;
    //sql语句字符串
    NSString *sqlString = [NSString stringWithFormat:@"delete from \"ScrollTable\""];
    //sql准备字符串
    int result = sqlite3_prepare_v2(db, [sqlString UTF8String], -1, &stmt, NULL);
    //判断语句正确性
    if (result == SQLITE_OK) {
        //执行语句
        char *error = nil;
        int result = sqlite3_exec(db, [sqlString UTF8String], NULL, NULL, &error);
        if (result == SQLITE_OK) {
            
        }else{
            
        }
    }
    [DataBaseManager closeDataBase];
}

@end
