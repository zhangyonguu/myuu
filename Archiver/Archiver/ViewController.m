//
//  ViewController.m
//  Archiver
//
//  Created by tarena on 16/5/11.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"archiver"];
    //Archiver
    NSArray *array = @[@"jack",@16,@[@"c",@"oc",@"swift"]];
    //创建对象，并与数据关联
    NSMutableData *mutableData = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mutableData];
    [archiver encodeObject:array forKey:@"arrayKey"];
    //执行下一步后，完成编码
    [archiver finishEncoding];
    [mutableData writeToFile:filePath atomically:YES];
    //Unarchiver
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSArray *readArray = [unarchiver decodeObjectForKey:@"arrayKey"];
    [unarchiver finishDecoding];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
