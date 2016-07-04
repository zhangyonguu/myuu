//
//  TRTgCell.h
//  团购
//
//  Created by tarena on 16/3/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TRTg;

@interface TRTgCell : UITableViewCell
@property (nonatomic, strong) TRTg *tg;

/**提供一个类方法，快速创建cell*/
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
