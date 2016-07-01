//
//  ViewController.m
//  队列的使用
//
//  Created by tarena on 16/4/7.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
/**
 1. async - concurrent最常用
    async - serial有时用
 2. sync- concurrent
    sync- serial
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //Core Foundation： C
    //Foundation ： OC
    //Foundation，Core Foundation数据类型可以互相转化
    NSString *str = @"__bridge";
    CFStringRef str2 = (__bridge CFStringRef)str;//桥接，用于不同框架的数据类型转换
    NSString *str3 = (__bridge NSString *)str2;
    //同理
    //NSArray - CFArrayRef ， NSDictionary - CFDictionaryRef
    
    //（基于）Core Foundation中手动创建的数据类型都需要手动释放
    CFArrayRef array = CFArrayCreate(NULL, NULL, 10, NULL);
    CFRelease(array);
  /**
   凡是函数名中带有create\copy\new\retain等字眼，都应该在不需要使用这个数据时release
   GCD的数据类型在ARC环境下不需要再做release
   CF的数据类型在ARC\MRC下都需要做release
   */
    CGPathRef path = CGPathCreateMutable();
    
    CGPathRetain(path);
    CGPathRelease(path);
    
    CFRelease(path);
}
@end
