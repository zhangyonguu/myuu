//
//  MLSettingItem.h
//  MLMyLottery
//
//  Created by tarena on 16/4/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
//typedef enum : NSUInteger
//{
//    MLSettingItemTypeArrow,
//    MLSettingItemTypeSwitch,
//}MLSettingItemType;

typedef void(^MLSettingItemOption)();

@interface MLSettingItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *subTitle;

//block保存一段功能
@property (nonatomic, strong) MLSettingItemOption option;

//@property (nonatomic, assign) MLSettingItemType type;

+(instancetype)itemWithIcon:(NSString *)icon andTitle:(NSString *)title;

@end