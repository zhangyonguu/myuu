//
//  TRStatus.h
//  新浪微博
//
//  Created by tarena on 16/3/30.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRStatus : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *picture;
@property (nonatomic, assign) BOOL vip;


-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)statusWithDict:(NSDictionary *)dict;
//+(NSArray *)statuses;
@end
