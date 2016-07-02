//
//  Student.m
//  获取类的信息
//
//  Created by tarena on 16/6/23.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "Student.h"

@interface Student ()
@property (nonatomic, copy) NSString *nickname;
@end

@implementation Student
+(void)show
{
    NSLog(@"class method");
}

-(void)play
{
    NSLog(@"instance method");
}
@end
