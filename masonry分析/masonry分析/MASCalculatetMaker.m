//
//  MASCalculatetMaker.m
//  masonry分析
//
//  Created by tarena on 16/7/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MASCalculatetMaker.h"



@implementation MASCalculatetMaker
-(instancetype)add:(int)value
{
    _result += value;
    return self;
}

-(MASCalculatetMaker * (^)(int))add
{
    return ^(int value){
        _result += value;
        return self;
    };
}
@end
