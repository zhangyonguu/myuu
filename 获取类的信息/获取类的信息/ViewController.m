//
//  ViewController.m
//  获取类的信息
//
//  Created by tarena on 16/6/23.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "Student.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self getAllMethod];
//    [self getAllProperty];
    [self getAllClassMethod];
}

-(void)getAllMethod
{
    u_int count = 0;
    Method *methods = class_copyMethodList([Student class], &count);
    for (int i = 0; i < count; i++) {
        SEL name = method_getName(methods[i]);
        NSString *strname = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        NSLog(@"%@",strname);
    }
}

-(void)getAllProperty
{
    u_int count = 0;
    objc_property_t *propertyList = class_copyPropertyList([Student class], &count);
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"%@",[NSString stringWithUTF8String:propertyName]);
    }
}

-(void)getAllClassMethod
{//获取元类
    //方式一
    Class c = objc_getMetaClass("Student");
    //方式二
//    Class c1 = object_getClass([Student class]);
    u_int count = 0;
    Method *methods = class_copyMethodList(c, &count);
    for (int i = 0; i < count; i++) {
        SEL name = method_getName(methods[i]);
        NSString *strname = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        NSLog(@"%@",strname);
    }
}

@end
