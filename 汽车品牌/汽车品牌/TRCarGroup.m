//
//  TRCarGroup.m
//  汽车品牌
//
//  Created by tarena on 16/3/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRCarGroup.h"
#import "TRCar.h"

@implementation TRCarGroup
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValue:dict[@"title"] forKey:@"title"];
       // [self setValue:dict[@"cars"] forKey:@"cars"];
        //[self setValuesForKeysWithDictionary:dict];
        self.cars = [TRCar carsWithArray:dict[@"cars"]];
    }
    return self;
}

+(instancetype)carGroupWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

+(NSArray *)carGroups
{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cars_total.plist" ofType:nil]];
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self  carGroupWithDict:dict]];
    }
    return arrayM;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p> {title: %@, cars: %@}",self.class,self,self.title,self.cars];
}

@end
