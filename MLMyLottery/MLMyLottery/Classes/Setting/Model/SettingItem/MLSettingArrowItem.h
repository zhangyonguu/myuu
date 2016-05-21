//
//  MLSettingArrowItem.h
//  MLMyLottery
//
//  Created by tarena on 16/4/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MLSettingItem.h"

@interface MLSettingArrowItem : MLSettingItem
@property (nonatomic, assign) Class destVCClass;
+(instancetype)itemWithIcon:(NSString *)icon andTitle:(NSString *)title andDestVCClass:(Class)destVCClass;
@end
