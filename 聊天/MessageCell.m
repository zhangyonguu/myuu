//
//  MessageCell.m
//  Demo3_Message
//
//  Created by tarena on 16/5/7.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MessageCell.h"

@interface MessageCell()
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@end

@implementation MessageCell

-(void)setMessage:(Message *)message {
    _message = message;
    //设置聊天内容
    self.messageLabel.text = message.content;
    //设置头像
    self.headerImageView.image = [UIImage imageNamed:message.imageName];
}


@end











