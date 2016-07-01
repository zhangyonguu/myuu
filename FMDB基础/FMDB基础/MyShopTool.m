//
//  MyShopTool.m
//  FMDB基础
//
//  Created by tarena on 16/5/12.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyShopTool.h"
#import "FMDB.h"

@implementation MyShopTool
static FMDatabase *_db;
+(void)initialize
{
    NSString *sqlPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"shops.db"];
    
    _db = [FMDatabase databaseWithPath:sqlPath];
    [_db open];
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_shop (id integer PRIMARY KEY, name TEXT NOT NULL, price real);"];
}

+(void)addShop:(MyShop *)shop
{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO t_shop(name, price) VALUES ('%@',%g);",shop.name,shop.price];
    [_db executeUpdate:sql];
}

+(NSArray *)shops
{
    FMResultSet *set = [_db executeQuery:@"SELECT * FROM t_shop"];
    NSMutableArray *shops = [NSMutableArray array];
    while (set.next) {//指向下一个
        MyShop *shop = [[MyShop alloc] init];
        shop.name = [set stringForColumn:@"name"];
        shop.price = [set doubleForColumn:@"price"];
        [shops addObject:shop];
    }
    return shops;
}
@end
