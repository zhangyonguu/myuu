//
//  Person+Extension.m
//  协议中定义属性
//
//  Created by tarena on 16/6/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "Person+Extension.h"
#import <objc/runtime.h>

//static NSString *_name;
@implementation Person (Extension)
//-(void)setName:(NSString *)name
//{
//    _name = name;
//}

//-(NSString *)name
//{
//    return _name;
//}

//分类中添加属性方式一：
//1.定义静态变量，实现setter，getter
//2.使用runtime
-(void)setName:(NSString *)name
{
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)name
{
    return objc_getAssociatedObject(self, @selector(name));
}
@end
