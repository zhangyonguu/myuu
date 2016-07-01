//
//  TRCarGroup.h
//  汽车品牌
//
//  Created by tarena on 16/3/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRCarGroup : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *cars;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)carGroupWithDict:(NSDictionary *)dict;

+(NSArray *)carGroups;
@end
