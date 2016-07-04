//
//  NSObject+Calculate.m
//  masonry分析
//
//  Created by tarena on 16/7/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "NSObject+Calculate.h"

@implementation NSObject (Calculate)
+(int)mc_makeCalculates:(void (^)(MASCalculatetMaker *))block
{
    MASCalculatetMaker *maker = [[MASCalculatetMaker alloc] init];
    block(maker);
    return maker.result;
}
@end
