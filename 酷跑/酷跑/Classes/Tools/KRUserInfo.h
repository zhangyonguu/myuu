//
//  KRUserInfo.h
//  酷跑
//
//  Created by tarena on 16/6/7.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@interface KRUserInfo : NSObject
singleton_interface(KRUserInfo)
/** 用户名 */
@property (nonatomic,copy) NSString *userName;
/** 密码 */
@property (nonatomic,copy) NSString *userPassword;
/** 注册的名字 */
@property (nonatomic,copy) NSString *userRegisterName;
/** 注册的密码 */
@property (nonatomic,copy) NSString *userRegisterPassword;
/** 区分到底是登录状态 还是注册状态 */
@property (nonatomic,assign,getter=isLogin) BOOL login;
/** 用来获取当前用户的jidStr */
@property (nonatomic,copy,readonly)
    NSString *jidStr;
/** 用来标示是否是新浪第三方登录 */
@property (nonatomic,assign,getter=isSinaLogin) BOOL sinaLogin;
@end









