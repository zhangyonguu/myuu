//
//  MLProduct.m
//  MLMyLottery
//
//  Created by tarena on 16/4/22.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MLProduct.h"

@implementation MLProduct

+(instancetype)productWithDict:(NSDictionary *)dict
{
    MLProduct *product = [[MLProduct alloc] init];
   // [product setValuesForKeysWithDictionary:dict];
    product.title = dict[@"title"];
    product.icon = dict[@"icon"];
    product.url = dict[@"url"];
    product.ID = dict[@"id"];
    product.customUrl = dict[@"customUrl"];
    return product;
}
@end
