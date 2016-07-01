//
//  KCKeyChain.h
//  keyChain
//
//  Created by tarena on 16/6/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface KCKeyChain : NSObject

+(void)save:(NSString *)service data:(id)data;
+(id)load:(NSString *)service;
+(void)delete:(NSString *)service;
@end
