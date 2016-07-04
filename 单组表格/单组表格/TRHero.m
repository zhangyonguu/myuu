//
//  TRHero.m
//  单组表格
//
//  Created by tarena on 16/3/26.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRHero.h"

@implementation TRHero
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)heroWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

+(NSArray *)heros
{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"heros.plist" ofType:nil]];
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self  heroWithDict:dict]];
    }
    return arrayM;
}


@end
