//
//  MLSaveDataTool.h
//  MLMyLottery
//
//  Created by tarena on 16/4/22.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLSaveDataTool : NSObject
//将存储数据的业务提取出来，以后修改的时候就只需要修改此模块
+ (nullable id)objectForKey:(nonnull NSString *)defaultName;

+ (void)setObject:(nullable id)value forKey:(nonnull NSString *)defaultName;
@end
