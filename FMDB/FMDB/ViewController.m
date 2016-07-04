//
//  ViewController.m
//  FMDB
//
//  Created by tarena on 16/6/4.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "FMDatabase.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *dbFliePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"test.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbFliePath];
    if ([db open]) {
        if([db executeUpdate:@"create table if not exists student(id integer primary key, name text, height real)"])
        {
            BOOL isInsert = [db executeUpdate:@"insert into student(name, height) values ('Maggie', 1.66)"];
            if (isInsert) {

              FMResultSet *resultSet = [db executeQuery:@"select * from student"];
                while ([resultSet next]) {
                    int idValue = [resultSet intForColumn:@"id"];
                    NSString *name = [resultSet stringForColumn:@"name"];
                    double height = [resultSet doubleForColumn:@"height"];
                    NSLog(@"%d---%@-----%g",idValue, name, height);
                }
            }
        }
    }
    [db close];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
