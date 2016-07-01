//
//  NSMutableArray+LoggingAddObject.h
//  MethodSwizzling
//
//  Created by tarena on 16/5/19.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSMutableArray (LoggingAddObject)
-(void)logAddObject:(id)object;
@end
