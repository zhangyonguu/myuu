//
//  MLProduct.h
//  MLMyLottery
//
//  Created by tarena on 16/4/22.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLProduct : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *customUrl;

+(instancetype)productWithDict:(NSDictionary *)dict;
@end
