//
//  ZYMetaDataTool.h
//  小桃桃
//
//  Created by tarena on 16/5/26.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYDeal.h"
#import "ZYCategory.h"
@interface ZYMetaDataTool : NSObject
+(NSArray *)parseDealsResult:(id)result;
+(NSArray *)getAllSorts;
+(NSArray *)getAllCities;
+(NSArray *)getRegionsOfCity:(NSString *)cityName;
+(NSArray *)getAllCategories;
+(NSArray *)getAllMenuDatas;

+(NSArray *)getAllBusiness:(ZYDeal *)deal;
+(ZYCategory *)getCategoryWithDeal:(ZYDeal *)deal;

+(void)setSelectedCityName:(NSString *)cityName;

+(NSString *)getSelectedCityName;
+(NSArray *)getAllCityGroups;
@end
