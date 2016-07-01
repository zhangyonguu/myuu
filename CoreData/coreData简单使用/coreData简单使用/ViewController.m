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
#import "Department.h"


@interface ViewController ()
@property (nonatomic, strong) NSManagedObjectContext *context;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
/**
 1.数据结构比较简单使用CoreData，开发效率高（面向对象，不用写sql语句），结构复杂，表与表之间关联比较多时使用FMDatabases
 2.FMDatabases使用多，CoreData使用少
 3.CURD （Create,Update,Read,Delete）
 */
    self.context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    NSString *documentPath =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *sqlitePath = [documentPath stringByAppendingPathComponent:@"company.sqlite"];
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:sqlitePath] options:nil error:nil];
    
    self.context.persistentStoreCoordinator = store;
}



-(IBAction)addEmployee:(id)sender
{
    Department *iosDepart = [NSEntityDescription insertNewObjectForEntityForName:@"Department" inManagedObjectContext:self.context];
    iosDepart.name = @"ios";
    iosDepart.departNo = @"0001";
    iosDepart.createDate = [NSDate date];
    
    Department *androidDepart = [NSEntityDescription insertNewObjectForEntityForName:@"Department" inManagedObjectContext:self.context];
    androidDepart.name = @"android";
    androidDepart.departNo = @"0002";
    androidDepart.createDate = [NSDate date];
    
    Employee *bosh = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:self.context];
    bosh.name = @"bosh";
    bosh.height = @2.14;
    bosh.birthday = [NSDate date];
    bosh.depart = iosDepart;
    
    Employee *james = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:self.context];
    james.name = @"james";
    james.height = @1.94;
    james.birthday = [NSDate date];
    james.depart = androidDepart;
    
    NSError *error = nil;
    [self.context save:&error];
    if (error) {
        NSLog(@"%@",error);
    }
}
- (IBAction)readEmployee:(id)sender {
    //1.创建请求对象
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    //2.设置谓词（筛选条件）
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"depart.name = %@",@"ios"];
    fetchRequest.predicate = pre;
    
    //3.设置排序
//    NSSortDescriptor *heightSort = [NSSortDescriptor sortDescriptorWithKey:@"height" ascending:NO];
//    fetchRequest.sortDescriptors = @[heightSort];
    
    //4.执行请求
    NSError *error = nil;
    NSArray *emps = [self.context executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"error");
    }
    for (Employee *emp in emps) {
        NSLog(@"%@---%@",emp.name,emp.depart.name);
    }
}
- (IBAction)updateEmployee:(id)sender {
//1.查找出待修改对象
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name = %@",@"james"];
    fetchRequest.predicate = pre;
    NSError *error = nil;
    NSArray *emps = [self.context executeFetchRequest:fetchRequest error:&error];
//2.做出修改
    for (Employee *emp in emps) {
        emp.height = @2.05;
    }
//3.保存
    [self.context save:nil];
}
- (IBAction)deleteEmployee:(id)sender {
    //1.查找出待删除对象
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name = %@",@"bosh"];
    fetchRequest.predicate = pre;
    NSError *error = nil;
    NSArray *emps = [self.context executeFetchRequest:fetchRequest error:&error];

    //2.删除
    for (Employee *emp in emps) {
        [self.context deleteObject:emp];
    }
    //3.保存
    [self.context save:nil];
    
}

@end
