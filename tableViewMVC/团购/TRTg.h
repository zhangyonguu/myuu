//
//  TRTg.h
//  团购
//
//  Created by tarena on 16/3/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRTg : NSObject
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *icon;
@property (nonatomic, copy)NSString *price;
@property (nonatomic, copy)NSString *buyCount;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)tgWithDict:(NSDictionary *)dict;
+(NSMutableArray *)tgs;
@end
