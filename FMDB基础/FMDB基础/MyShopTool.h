//
//  MyShopTool.h
//  FMDB基础
//
//  Created by tarena on 16/5/12.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyShop.h"
@interface MyShopTool : NSObject
//封装存储细节
+(NSArray *)shops;
+(void)addShop:(MyShop *)shop;
@end
