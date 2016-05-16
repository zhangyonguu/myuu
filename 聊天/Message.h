//
//  Message.h
//  Demo3_Message
//
//  Created by tarena on 16/5/7.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *imageName;
@property(nonatomic,assign, getter=isFromMe)BOOL fromMe;
@end











