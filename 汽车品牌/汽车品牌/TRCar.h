//
//  TRCar.h
//  汽车品牌
//
//  Created by tarena on 16/3/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRCar : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)carWithDict:(NSDictionary *)dict;

//传入一个包含字典的数组，返回一个TRCar模型的数组
+(NSArray *)carsWithArray:(NSArray *)array;
@end
