//
//  KRXMPPTool.h
//  酷跑
//
//  Created by tarena on 16/6/7.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPFramework.h"
#import "Singleton.h"

/** 定义一个登录协议 */
@protocol KRXMPPLoginDelegate <NSObject>
- (void) loginSuccess;
- (void) loginFailed;
- (void) loginNetError;
@end
/** 定义一个注册协议  把注册协议注释掉 换成使用block方式来传递注册状态
@protocol KRXMPPRegisterDelegate <NSObject>
- (void) registerSuccess;
- (void) registerFailed;
- (void) registerNetError;
@end
 */
// 定义一个枚举 代表注册的状态
typedef enum {
    KRXMPPResultTypeRegisterSuccess,
    KRXMPPResultTypeRegisterFailed,
    KRXMPPResultTypeRegisterNetError
}KRXMPPResultType;
// 设计一个block 带一个KRXMPPResultType参数
typedef void  (^KRXMPPResultBlock) (KRXMPPResultType type);
@interface KRXMPPTool : NSObject
singleton_interface(KRXMPPTool)
/** 和xmpp服务器交互的核心类 */
@property (nonatomic,strong) XMPPStream *xmppStream;
/** 增加电子名片模块 和 电子名片模块对应的存储 */
@property (nonatomic,strong) XMPPvCardTempModule *xmppvCard;
@property (nonatomic,strong)
    XMPPvCardCoreDataStorage * xmppvCardStore;
/** 增加头像模块 */
@property (nonatomic,strong) XMPPvCardAvatarModule *xmppvCardAvatar;
/** 增加好友列表模块(花名册模块) 和对应的存储 */
@property (nonatomic,strong)
    XMPPRoster  *xmppRoster;
@property (nonatomic,strong)
    XMPPRosterCoreDataStorage *xmppRosterStore;
/** 增加消息模块 和 消息模块对应的存储 */
@property (nonatomic,strong)
    XMPPMessageArchiving *xmppMsgArch;
@property (nonatomic,strong)
    XMPPMessageArchivingCoreDataStorage *xmppMsgArchStore;
/** 登录的代理属性 */
@property (nonatomic,weak) id<KRXMPPLoginDelegate> loginDelegate;
/** 注册的代理属性 */
//@property (nonatomic,weak) id<KRXMPPRegisterDelegate> registerDelegate;
/** 完成登录的公开方法 */
- (void)userLogin;
/** 完成注册的公开方法 规定谁要获取注册状态 谁就传入一个block类型的参数 */
- (void)userRegister:(KRXMPPResultBlock) block;
@end








