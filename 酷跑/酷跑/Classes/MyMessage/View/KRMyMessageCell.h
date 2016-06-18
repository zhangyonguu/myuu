//
//  KRMyMessageCell.h
//  酷跑
//
//  Created by tarena on 16/6/15.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KRMyMessageCell : UITableViewCell
/** 好友的头像 */
@property (weak, nonatomic) IBOutlet UIImageView *friendHeadImageView;
/** 好友的名字 */
@property (weak, nonatomic) IBOutlet UILabel *friendNameLabel;
/** 消息的时间 */
@property (weak, nonatomic) IBOutlet UILabel *msgTimeLabel;
/** 消息的内容  如果是图片显示图片两个字 
    文本消息只显示一行 */
@property (weak, nonatomic) IBOutlet UILabel *msgContentLabel;

@end










