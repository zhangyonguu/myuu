//
//  NSObject+Calculate.h
//  masonry分析
//
//  Created by tarena on 16/7/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MASCalculatetMaker.h"
@interface NSObject (Calculate)

+ (int)mc_makeCalculates:(void(^)(MASCalculatetMaker *))block;

@end
