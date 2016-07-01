//
//  ViewController.m
//  customDecode
//
//  Created by tarena on 16/5/11.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self method1];    
}

-(void)method2
{
    Student *stu = Student.new;
    stu.name = @"wade";
    stu.age = 20;
    NSData *writeData = [NSKeyedArchiver archivedDataWithRootObject:stu];
    [[NSUserDefaults standardUserDefaults] setObject:writeData forKey:@"firstStu"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSData *readData = [[NSUserDefaults standardUserDefaults] objectForKey:@"firstStu"];
    
    Student *readStu = [NSKeyedUnarchiver unarchiveObjectWithData:readData];
    
    NSLog(@"%@",readStu);
}

-(void)method1
{
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"archiver"];
    
    NSMutableData *mutableData = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mutableData];
    

    Student *stu = Student.new;
    stu.name = @"wade";
    stu.age = 20;
    
    //encodeObject：会调用encodeWithCoder:
    [archiver encodeObject:stu forKey:@"firstStu"];
    NSLog(@"%@",mutableData);

    [archiver finishEncoding];
    
    NSLog(@"%@",mutableData);
    [mutableData writeToFile:filePath atomically:YES];
    
    //Unarchiver
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    //decodeObjectForKey：会调用initWithCoder:
    Student *readStu = [unarchiver decodeObjectForKey:@"firstStu"];
    NSLog(@"---%@",readStu);
    [unarchiver finishDecoding];
    NSLog(@"+++%@",readStu);

}
@end
