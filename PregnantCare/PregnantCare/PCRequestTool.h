//
//  PCRequestTool.h
//  PregnantCare
//
//  Created by tarena on 16/6/3.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCRequestTool : NSObject
-(NSMutableArray *)requestDataWithURLComponentString:(NSString *)suffixStr andClass:(Class)dataClass;
@end
