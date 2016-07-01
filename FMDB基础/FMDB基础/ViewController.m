//
//  ViewController.m
//  FMDB基础
//
//  Created by tarena on 16/5/12.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
//#import "FMDB.h"
#import "MyShop.h"
#import "MyShopTool.h"

@interface ViewController ()
//@property (nonatomic, strong) FMDatabase *db;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSString *sqlPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"shops.db"];
//    
//    self.db = [FMDatabase databaseWithPath:sqlPath];
//    [self.db open];
//    
////创建表，FMDatabase提供2种操作，update和query，除query外其他操作都用update
//    [self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_shop (id integer PRIMARY KEY, name TEXT NOT NULL, price real);"];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self.db executeUpdate:@"DELETE FROM t_shop WHERE price < 500"];
//    [self query];
    [self insert];
}

-(void)query
{
//    FMResultSet *set = [self.db executeQuery:@"SELECT * FROM t_shop"];
//    while (set.next) {//指向下一个
//        NSString *name = [set stringForColumn:@"name"];
//        double price = [set doubleForColumn:@"price"];
//        NSLog(@"%@---%g", name, price);
//    }
    NSArray *shops = [MyShopTool shops];
    for (MyShop *shop in shops) {
        NSLog(@"%@---%g",shop.name, shop.price);
    }
}

-(void)insert
{
    for (int i = 0; i < 100; i++) {
        MyShop *shop = [[MyShop alloc] init];
        shop.name = [NSString stringWithFormat:@"手机--%02d",i];
        shop.price = arc4random()%1000;
        [MyShopTool addShop:shop];
    }   
}

@end
