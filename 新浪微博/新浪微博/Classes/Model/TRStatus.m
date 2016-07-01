//
//  TRStatus.m
//  新浪微博
//
//  Created by tarena on 16/3/30.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRStatus.h"

@implementation TRStatus
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)statusWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

//+(NSArray *)statuses
//{
//    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"statuses.plist" ofType:nil]];
//    NSMutableArray *arrayM = [NSMutableArray array];
//    for (NSDictionary *dict in array) {
//        [arrayM addObject:[self  statusWithDict:dict]];
//    }
//    return arrayM;
//}

@end
