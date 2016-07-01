//
//  ZYDeal.h
//  小桃桃
//
//  Created by tarena on 16/5/26.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYDeal : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSNumber *list_price;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, strong) NSNumber *current_price;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSNumber *purchase_count;
@property (nonatomic, copy) NSString *image_url;
@property (nonatomic, copy) NSString *s_image_url;
@property (nonatomic, copy) NSString *deal_h5_url;
@property (nonatomic, strong) NSArray *businesses;
@end
