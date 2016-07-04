//
//  CalculateManager.m
//  函数式编程思想
//
//  Created by tarena on 16/7/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "CalculateManager.h"

@implementation CalculateManager
-(instancetype)calculate:(int (^)(int))calculateBlock
{
    _result = calculateBlock(_result);
    return self;
}
@end
