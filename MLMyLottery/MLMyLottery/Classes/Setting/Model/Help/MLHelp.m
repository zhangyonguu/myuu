//
//  MLHelp.m
//  MLMyLottery
//
//  Created by tarena on 16/4/23.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MLHelp.h"

@implementation MLHelp
+(instancetype)helpWithDict:(NSDictionary *)dict
{
    MLHelp *help = [[MLHelp alloc] init];
    // [help setValuesForKeysWithDictionary:dict];
    help.title = dict[@"title"];
    help.html = dict[@"html"];
    help.ID = dict[@"id"];

    return help;
}
@end
