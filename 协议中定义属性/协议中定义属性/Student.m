//
//  Student.m
//  协议中定义属性
//
//  Created by tarena on 16/6/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "Student.h"
@implementation Student
//协议中实现属性需要自己添加ivar,setter,getter
-(NSString *)name
{
    return _name;
}

-(void)setName:(NSString *)name
{
    _name = name;
}
@end
