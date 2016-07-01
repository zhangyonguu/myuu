//
//  main.m
//  block实现
//
//  Created by tarena on 16/4/26.
//  Copyright © 2016年 tarena. All rights reserved.
//


#include <stdio.h>
#import "Person.h"


int globalStaticVar = 70;
int main(int argc, const char * argv[]) {
    {
       __block int a = 10;
        Person *person = [[Person alloc] init];
 person.name = @"zy";
        {
        void (^printBlock)() = ^()
        {
//            person = [[Person alloc] init];
            globalStaticVar++;
            printf("%d\n",a);
            printf("%d\n", globalStaticVar);
            NSLog(@"%@",person.name);
        };
        
        a = 20;
        globalStaticVar = 50;
        printBlock();
        }
    }

    return 0;
}
//注意查看cpp文件
//struct __block_impl {
//    void *isa;
//    int Flags;
//    int Reserved;
//    void *FuncPtr;
//};