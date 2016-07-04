//
//  MASCalculatetMaker.h
//  masonry分析
//
//  Created by tarena on 16/7/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MASCalculatetMaker : NSObject

@property (nonatomic, assign) int result;

//-(instancetype)add:(int)value;
-(MASCalculatetMaker * (^)(int value))add;
@end
