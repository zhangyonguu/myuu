//
//  Student.h
//  customDecode
//
//  Created by tarena on 16/5/11.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject<NSCoding>
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;

@end
