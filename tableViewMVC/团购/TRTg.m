//
//  TRTg.m
//  团购
//
//  Created by tarena on 16/3/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRTg.h"

@implementation TRTg
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)tgWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

+(NSMutableArray *)tgs
{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tgs.plist" ofType:nil]];
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self  tgWithDict:dict]];
    }
    return arrayM;
}

@end
