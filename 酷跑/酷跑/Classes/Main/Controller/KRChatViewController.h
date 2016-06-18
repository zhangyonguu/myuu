//
//  KRChatViewController.h
//  酷跑
//
//  Created by tarena on 16/6/13.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPPJID.h"
@interface KRChatViewController : UIViewController
/** 用来接收和谁聊天 使用jid区分 */
@property (nonatomic, strong) XMPPJID *fJid;
@end















