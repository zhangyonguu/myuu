//
//  Person.h
//  协议中定义属性
//
//  Created by tarena on 16/6/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PersonDelegate <NSObject>

@property (nonatomic, strong) NSString *name;


@end

@interface Person : NSObject

@end
