//
//  TRHero.h
//  单组表格
//
//  Created by tarena on 16/3/26.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRHero : UIButton
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *intro;
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)heroWithDict:(NSDictionary *)dict;
+(NSArray *)heros;
@end
