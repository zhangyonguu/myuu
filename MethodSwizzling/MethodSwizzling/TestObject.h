//
//  TestObject.h
//  MethodSwizzling
//
//  Created by tarena on 16/5/19.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestObject : NSObject

@property (nonatomic, strong) NSString *name;

-(void)MissMethod;
@end
