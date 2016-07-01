//
//  ZYMetaDataTool.m
//  小桃桃
//
//  Created by tarena on 16/5/26.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZYMetaDataTool.h"
#import "ZYSort.h"
#import "ZYCity.h"
#import "ZYRegion.h"
#import "ZYDeal.h"
#import "ZYCategory.h"
#import "ZYMenuData.h"
#import "ZYBusiness.h"
#import "TRCityGroup.h"
@implementation ZYMetaDataTool
+(NSArray *)parseDealsResult:(id)result
{
    NSArray *dealsArray = result[@"deals"];
   return [self parseArray:dealsArray withModelClass:[ZYDeal class]];
}

static NSArray *_sortsArray = nil;
+(NSArray *)getAllSorts
{
    if (_sortsArray == nil) {
        _sortsArray = [self getAndParseWithPlistFileName:@"sorts.plist" withModleClass:[ZYSort class]];
    }
    return _sortsArray;
}

static NSArray *_citiesArray = nil;
+(NSArray *)getAllCities
{
    if (_citiesArray == nil) {
        _citiesArray = [self getAndParseWithPlistFileName:@"cities.plist" withModleClass:[ZYCity class]];
    }
    return _citiesArray;
}

+(NSArray *)getRegionsOfCity:(NSString *)cityName
{
   for (ZYCity *city in [self getAllCities]) {
        if ([city.name isEqualToString:cityName]) {
           return [self parseArray:city.regions withModelClass:[ZYRegion class]];
        }
   }
   return nil;
}

+(NSArray *)getAndParseWithPlistFileName:(NSString *)plistFileName withModleClass:(Class)modelClass
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistFileName ofType:nil];
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:plistPath];
    return [self parseArray:plistArray withModelClass:modelClass];
}

+(NSArray *)parseArray:(NSArray *)array withModelClass:(Class)modelClass
{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        id model = [[modelClass alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        [arrayM addObject:model];
    }
    return [arrayM copy];
}

static NSArray *_categoriesArray = nil;
+(NSArray *)getAllCategories
{
    if (_categoriesArray == nil) {
      _categoriesArray = [self getAndParseWithPlistFileName:@"categories.plist" withModleClass:[ZYCategory class]];
    }
    return _categoriesArray;
}

static NSArray *_MenuDatasArray = nil;
+(NSArray *)getAllMenuDatas
{
    if (_MenuDatasArray == nil) {
        _MenuDatasArray = [self getAndParseWithPlistFileName:@"menuData.plist" withModleClass:[ZYMenuData class]];
    }
    return _MenuDatasArray;
}


+(NSArray *)getAllBusiness:(ZYDeal *)deal
{
    return [self parseArray:deal.businesses withModelClass:[ZYBusiness class]];
}

+(ZYCategory *)getCategoryWithDeal:(ZYDeal *)deal
{
    NSArray *categoryArray = deal.categories;
    NSArray *categoryArrayFromPlist = [self getAllCategories];
    for (NSString *categoryStr in categoryArray) {
        for (ZYCategory *category in categoryArrayFromPlist) {
            if ([categoryStr isEqualToString:category.name]) {
                return category;
            }
            else
            {
                if ([category.subcategories containsObject:categoryStr]) {
                    return category;
                }
            }
        }
    }
    return nil;
}

static NSString *_cityName = @"深圳";
+(void)setSelectedCityName:(NSString *)cityName
{
    _cityName = cityName;
}

+(NSString *)getSelectedCityName
{
    return _cityName;
}

static NSArray *_cityGroupsArray = nil;
+(NSArray *)getAllCityGroups
{
    if (_cityGroupsArray == nil) {
        _cityGroupsArray = [self getAndParseWithPlistFileName:@"cityGroups.plist" withModleClass:[TRCityGroup class]];
    }
    return _cityGroupsArray;
}
@end
