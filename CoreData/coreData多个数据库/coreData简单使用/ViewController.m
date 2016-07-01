//
//  ViewController.m
//  coreData简单使用
//
//  Created by tarena on 16/5/10.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "Employee.h"
#import "Status.h"



@interface ViewController ()
@property (nonatomic, strong) NSManagedObjectContext *companyContext;
@property (nonatomic, strong) NSManagedObjectContext *weiboContext;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSString *bundle = [NSBundle mainBundle].bundlePath;
/**
 1.数据结构比较简单使用CoreData，开发效率高（面向对象，不用写sql语句），结构复杂，表与表之间关联比较多时使用FMDatabases
 2.FMDatabases使用多，CoreData使用少
 3.CURD （Create,Update,Read,Delete）
 4.CoreData底层其实也要写sql语句
 */
    
    //一个数据库对应一个上下文
    self.companyContext = [self setupContextWithModelName:@"company"];
    self.weiboContext = [self setupContextWithModelName:@"Weibo"];
}

-(NSManagedObjectContext *)setupContextWithModelName:(NSString *)modelName
{
   NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    //使用下面的方法，若bundles参数为nil，会把bundles里面的所有模型文件的表放到一个数据库
    //    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSURL *companyURL = [[NSBundle mainBundle] URLForResource:modelName withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:companyURL];
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *sqlitePath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite",modelName]];
    
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:sqlitePath] options:nil error:nil];
    context.persistentStoreCoordinator = store;
    
    return context;
}

-(IBAction)addEmployee:(id)sender
{
    
    for (int i = 0; i < 15; i++) {
        Employee *emp = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:self.companyContext];
        emp.name = [NSString stringWithFormat:@"emp%02d",i];
        emp.height = @(2.14 + i);
        emp.birthday = [NSDate date];
    }

    NSError *error = nil;
    [self.companyContext save:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    
    for (int i = 0; i < 15; i++) {
        Status *status = [NSEntityDescription insertNewObjectForEntityForName:@"Status" inManagedObjectContext:self.weiboContext];
        status.text = [NSString stringWithFormat:@"status%02d",i];
        status.date = [NSDate date];
    }
    
    [self.weiboContext save:&error];
    if (error) {
        NSLog(@"%@",error);
    }
}
- (IBAction)readEmployee:(id)sender {
    //1.创建请求对象
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    //分页查询
//    fetchRequest.fetchOffset = 12;
////    fetchRequest.fetchBatchSize = 6;
//    fetchRequest.fetchLimit = 6;
    
//    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name BEGINSWITH %@",@"emp0"];
    
//    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name ENDSWITH %@",@"2"];
    
//        NSPredicate *pre = [NSPredicate predicateWithFormat:@"name contains %@",@"1"];
    //谓词大写小写都可以
//        NSPredicate *pre = [NSPredicate predicateWithFormat:@"name like %@",@"*02"];
//    fetchRequest.predicate = pre;
//    
//    //3.设置排序
//    NSSortDescriptor *heightSort = [NSSortDescriptor sortDescriptorWithKey:@"height" ascending:NO];
//    fetchRequest.sortDescriptors = @[heightSort];
    
    //4.执行请求
    NSError *error = nil;
    NSArray *emps = [self.companyContext executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"error");
    }
    for (Employee *emp in emps) {
        NSLog(@"%@----%g",emp.name,emp.height.floatValue);
    }
}
- (IBAction)updateEmployee:(id)sender {
//1.查找出待修改对象
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name = %@",@"james"];
    fetchRequest.predicate = pre;
    NSError *error = nil;
    NSArray *emps = [self.companyContext executeFetchRequest:fetchRequest error:&error];
//2.做出修改
    for (Employee *emp in emps) {
        emp.height = @2.05;
    }
//3.保存
    [self.companyContext save:nil];
}
- (IBAction)deleteEmployee:(id)sender {
    //1.查找出待删除对象
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name = %@",@"bosh"];
    fetchRequest.predicate = pre;
    NSError *error = nil;
    NSArray *emps = [self.companyContext executeFetchRequest:fetchRequest error:&error];

    //2.删除
    for (Employee *emp in emps) {
        [self.companyContext deleteObject:emp];
    }
    //3.保存
    [self.companyContext save:nil];
    
}

@end
