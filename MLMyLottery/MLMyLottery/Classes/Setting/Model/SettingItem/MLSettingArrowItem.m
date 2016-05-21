//
//  MLSettingArrowItem.m
//  MLMyLottery
//
//  Created by tarena on 16/4/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MLSettingArrowItem.h"

@implementation MLSettingArrowItem
+(instancetype)itemWithIcon:(NSString *)icon andTitle:(NSString *)title andDestVCClass:(Class)destVCClass
{
   MLSettingArrowItem *item = [super itemWithIcon:icon andTitle:title];
    item.destVCClass = destVCClass;
    return item;
}

@end
