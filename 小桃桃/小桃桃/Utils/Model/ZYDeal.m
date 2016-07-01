//
//  ZYDeal.m
//  小桃桃
//
//  Created by tarena on 16/5/26.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZYDeal.h"

@implementation ZYDeal

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key  isEqual: @"description"]) {
        self.desc = value;
    }
}
@end
