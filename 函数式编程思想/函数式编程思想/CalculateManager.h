//
//  CalculateManager.h
//  函数式编程思想
//
//  Created by tarena on 16/7/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculateManager : NSObject
@property (nonatomic, assign) int result;
-(instancetype)calculate:(int(^)(int))calculateBlock;
@end
