//
//  NSMutableArray+LoggingAddObject.m
//  MethodSwizzling
//
//  Created by tarena on 16/5/19.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "NSMutableArray+LoggingAddObject.h"

@implementation NSMutableArray (LoggingAddObject)

+(void)load
{
    Method addObject = class_getInstanceMethod(self, @selector(addObject:));
    Method logAddObject = class_getInstanceMethod(self, @selector(logAddObject:));
    method_exchangeImplementations(addObject, logAddObject);
}

-(void)logAddObject:(id)object
{
    [self logAddObject:object];
    //为什么下面没有打印？？？
    NSLog(@"Added object %@ to array %@",object, self);
}
@end
