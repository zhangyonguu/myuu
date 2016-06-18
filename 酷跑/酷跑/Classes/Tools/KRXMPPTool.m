//
//  KRXMPPTool.m
//  酷跑
//
//  Created by tarena on 16/6/7.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "KRXMPPTool.h"
#import "KRUserInfo.h"
@interface  KRXMPPTool()<XMPPStreamDelegate>
{
    KRXMPPResultBlock _resultBlock;
}
/** 0 设置流 (给流对象赋值 和 设置代理 以及后续模块添加 )*/
- (void) setupXmppStream;
/** 1 连接服务器 */
- (void) connectToServer;
/** 2 连接成功与否  通过代理方法*/
/** 3 如果连接成功 就发送密码进行授权 */
- (void) sendPassword;
/** 4 授权成功与否 通过代理方法 */
/** 5 如果连接成功 就发送在线消息 */
- (void) sendOnLine;
@end
@implementation KRXMPPTool
singleton_implementation(KRXMPPTool)
- (void)setupXmppStream {
    self.xmppStream = [XMPPStream new];
    // 设置代理
    [self.xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    // 给电子名片模块赋值 先给对应的存储赋值
    self.xmppvCardStore = [XMPPvCardCoreDataStorage sharedInstance];
    self.xmppvCard = [[XMPPvCardTempModule alloc]initWithvCardStorage:self.xmppvCardStore];
    // 给头像模块赋值
    self.xmppvCardAvatar = [[XMPPvCardAvatarModule alloc]initWithvCardTempModule:self.xmppvCard];
    // 给花名册对应的存储赋值
    self.xmppRosterStore = [XMPPRosterCoreDataStorage sharedInstance];
    // 给花名册模块属性赋值
    self.xmppRoster = [[XMPPRoster alloc]initWithRosterStorage:self.xmppRosterStore];
    // 先给消息模块对应的存储赋值
    self.xmppMsgArchStore = [XMPPMessageArchivingCoreDataStorage sharedInstance];
    // 给消息模块赋值
    self.xmppMsgArch = [[XMPPMessageArchiving alloc]initWithMessageArchivingStorage:self.xmppMsgArchStore];
    // 激活电子名片模块 和 头像模块
    [self.xmppvCard activate:self.xmppStream];
    [self.xmppvCardAvatar activate:self.xmppStream];
    // 激活花名册模块
    [self.xmppRoster activate:self.xmppStream];
    // 激活消息模块
    [self.xmppMsgArch activate:self.xmppStream];
}
- (void)connectToServer {
    // 把之前的连接断开
    [self.xmppStream disconnect];
    if (self.xmppStream == nil) {
        [self setupXmppStream];
    }
    // 设置服务器的名字IP  端口
    self.xmppStream.hostName = KRXMPPHOSTNAME;
    self.xmppStream.hostPort = KRXMPPPORT;
    // 根据当前用户设置jid
    NSString *userName = nil;
    if ([KRUserInfo sharedKRUserInfo].isLogin) {
        userName = [KRUserInfo sharedKRUserInfo].userName;
    }else{
        userName = [KRUserInfo sharedKRUserInfo].userRegisterName;
    }
    
    NSString *jidStr = [NSString stringWithFormat:@"%@@%@",userName,KRXMPPDOMAIN];
    self.xmppStream.myJID = [XMPPJID jidWithString:jidStr];
    // 开始连接
    NSError  *error = nil;
    [self.xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
}
#pragma  mark XMPPStreamDelegate
/** 连接成功 */
- (void)xmppStreamDidConnect:(XMPPStream *)sender{
    // 发送密码
    [self sendPassword];
}
/** 连接失败 就会自动 断开连接(也可能主动断开 那这种情况是没有error的) */
- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error{
    if (error) {
        NSLog(@"%@",error);
        if([KRUserInfo sharedKRUserInfo].isLogin){
            [self.loginDelegate loginNetError];
        }else{
            NSLog(@"注册时网络错误:%@",error);
            //[self.registerDelegate registerNetError];
            _resultBlock(KRXMPPResultTypeRegisterNetError);
        }
    }
}
- (void)sendPassword{
    NSString *password = nil;
    NSError *error = nil;
    if ([KRUserInfo sharedKRUserInfo].isLogin) {
        password = [KRUserInfo sharedKRUserInfo].userPassword;
        // 使用密码进行授权
        [self.xmppStream authenticateWithPassword:password error:&error];
    }else{
        password = [KRUserInfo sharedKRUserInfo].userRegisterPassword;
        // 使用密码进行注册
        [self.xmppStream registerWithPassword:password error:&error];
    }
    if (error) {
        NSLog(@"%@",error);
    }
}
#pragma  mark XMPPStreamDelegate
/** 注册成功 */
- (void)xmppStreamDidRegister:(XMPPStream *)sender{
    NSLog(@"在xmpp 中获取到注册成功");
    //[self.registerDelegate registerSuccess];
    _resultBlock(KRXMPPResultTypeRegisterSuccess);
}
/** 注册失败 */
- (void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error{
    NSLog(@"在xmpp 中获取到注册失败");
    //[self.registerDelegate registerFailed];
    _resultBlock(KRXMPPResultTypeRegisterFailed);
}
/** 授权成功 */
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    // 发在线消息
    [self sendOnLine];
     NSLog(@"xmpp 工具类中检查到登录成功");
    [self.loginDelegate loginSuccess];
}
/** 授权失败 */
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error{
    if (error) {
        NSLog(@"%@",error);
        [self.loginDelegate loginFailed];
    }
}
- (void)sendOnLine{
    [self.xmppStream sendElement:[XMPPPresence new]];
}
/** 用户登录的方法 */
- (void)userLogin{
    [self connectToServer];
}
//- (void)userRegister{
//    [self connectToServer];
//}
- (void)userRegister:(KRXMPPResultBlock)block{
    _resultBlock = block;
    [self connectToServer];
}
@end








