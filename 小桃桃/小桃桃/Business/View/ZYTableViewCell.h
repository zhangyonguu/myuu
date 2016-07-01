//
//  ZYTableViewCell.h
//  小桃桃
//
//  Created by tarena on 16/5/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYTableViewCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView andNormalImageName:(NSString *)imageName andSelectedImageName:(NSString *)selectedImageName;
@end
