//
//  Student.h
//  获取类的信息
//
//  Created by tarena on 16/6/23.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int age;
+(void)show;
-(void)play;
@end
