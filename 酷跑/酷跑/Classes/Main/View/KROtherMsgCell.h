//
//  KROtherMsgCell.h
//  酷跑
//
//  Created by tarena on 16/6/14.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KROtherMsgCell : UITableViewCell
/** 好友的头像 */
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
/** 好友的名字 */
@property (weak, nonatomic) IBOutlet UILabel *friendNameLabel;
/** 消息时间 */
@property (weak, nonatomic) IBOutlet UILabel *msgTimeLabel;
/** 内容 */
@property (weak, nonatomic) IBOutlet UILabel *msgContentLabel;

@end








