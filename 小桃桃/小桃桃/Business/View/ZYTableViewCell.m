//
//  ZYTableViewCell.m
//  小桃桃
//
//  Created by tarena on 16/5/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZYTableViewCell.h"

@implementation ZYTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellWithTableView:(UITableView *)tableView andNormalImageName:(NSString *)imageName andSelectedImageName:(NSString *)selectedImageName
{
    static NSString *ID = @"cell";
    ZYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:selectedImageName]];
    cell.textLabel.font = [UIFont systemFontOfSize:13];

    return cell;
}


@end
