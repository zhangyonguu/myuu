//
//  KRMeMsgCell.h
//  酷跑
//
//  Created by tarena on 16/6/15.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KRMeMsgCell : UITableViewCell
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
/** 用户的名字 */
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
/** 消息时间 */
@property (weak, nonatomic) IBOutlet UILabel *msgTimeLabel;
/** 内容 */
@property (weak, nonatomic) IBOutlet UILabel *msgContentLabel;
@end
