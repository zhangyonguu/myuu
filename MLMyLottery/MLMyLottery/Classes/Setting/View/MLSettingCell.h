//
//  MLSettingCell.h
//  MLMyLottery
//
//  Created by tarena on 16/4/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MLSettingItem;

@interface MLSettingCell : UITableViewCell
@property (nonatomic, strong) MLSettingItem *item;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
