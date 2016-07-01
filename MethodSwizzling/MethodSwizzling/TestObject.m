//
//  TestObject.m
//  MethodSwizzling
//
//  Created by tarena on 16/5/19.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TestObject.h"
#import <objc/runtime.h>

@implementation TestObject

void dynamicMethodIMP(id self, SEL _cmd)
{
    NSLog(@"dynamicIMP");
}

+(BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(MissMethod)) {
        class_addMethod(self, sel, (IMP)dynamicMethodIMP, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}


-(void)didChangeValueForKey:(NSString *)key
{
    NSLog(@"%@",self.observationInfo);
}
@end
