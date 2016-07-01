//
//  TRCar.m
//  汽车品牌
//
//  Created by tarena on 16/3/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRCar.h"

@implementation TRCar
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)carWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

+(NSArray *)carsWithArray:(NSArray *)array
{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self  carWithDict:dict]];
    }
    return arrayM;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p> {name: %@, icon: %@}",self.class,self,self.name,self.icon];
}

@end
