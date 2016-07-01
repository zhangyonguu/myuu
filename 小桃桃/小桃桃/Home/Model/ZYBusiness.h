//
//  ZYBusiness.h
//  小桃桃
//
//  Created by tarena on 16/5/31.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYBusiness : NSObject
@property (nonatomic, strong) NSString *name;
//id特例
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, assign) float latitude;
@property (nonatomic, assign) float longitude;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *h5_url;

@end
