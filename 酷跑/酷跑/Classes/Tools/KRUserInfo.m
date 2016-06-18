//
//  KRUserInfo.m
//  酷跑
//
//  Created by tarena on 16/6/7.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "KRUserInfo.h"

@implementation KRUserInfo
singleton_implementation(KRUserInfo)
- (NSString *)jidStr{
    return [NSString stringWithFormat:@"%@@%@",self.userName,KRXMPPDOMAIN];
}
@end








