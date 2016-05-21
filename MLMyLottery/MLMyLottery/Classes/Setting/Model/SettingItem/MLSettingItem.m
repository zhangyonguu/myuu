//
//  MLSettingItem.m
//  MLMyLottery
//
//  Created by tarena on 16/4/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MLSettingItem.h"

@implementation MLSettingItem

+(instancetype)itemWithIcon:(NSString *)icon andTitle:(NSString *)title
{
    MLSettingItem *item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    return item;

}
@end
