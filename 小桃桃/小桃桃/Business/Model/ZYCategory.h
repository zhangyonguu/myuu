//
//  ZYCategory.h
//  小桃桃
//
//  Created by tarena on 16/5/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYCategory : NSObject
@property (nonatomic, copy) NSString *highlighted_icon;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *small_highlighted_icon;
@property (nonatomic, copy) NSString *small_icon;
@property (nonatomic, copy) NSString *map_icon;
@property (nonatomic, strong) NSArray *subcategories;
@end
