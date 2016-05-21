//
//  MLSettingCell.m
//  MLMyLottery
//
//  Created by tarena on 16/4/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MLSettingCell.h"
#import "MLSettingItem.h"
#import "MLSettingSwitchItem.h"
#import "MLSettingArrowItem.h"
#import "MLSettingLabelItem.h"


@interface MLSettingCell ()
@property (nonatomic, strong) UISwitch *switcher;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *labelView;

@end
@implementation MLSettingCell

-(UILabel *)labelView
{
    if (_labelView == nil) {
        _labelView = [[UILabel alloc] init];
        _labelView.bounds = CGRectMake(0, 0, 100, 44);
        _labelView.textColor = [UIColor redColor];
        _labelView.textAlignment = NSTextAlignmentRight;
    }
    return _labelView;
}
-(UIImageView *)imgView
{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellArrow"]];
    }
    return _imgView;
}

-(UISwitch *)switcher
{
    if (_switcher == nil) {
        _switcher = [[UISwitch alloc] init];
    }
    return _switcher;

}

-(void)setItem:(MLSettingItem *)item
{
    _item = item;
    [self setupData];
    [self setupAccessoryView];
}

-(void)setupData
{
    if (_item.icon.length) {
        self.imageView.image = [UIImage imageNamed:_item.icon];
    }
    
    self.textLabel.text = _item.title;
    self.detailTextLabel.text = _item.subTitle;
}

-(void)setupAccessoryView
{
    if ([_item isKindOfClass:[MLSettingArrowItem class]]) {
       // self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.accessoryView = self.imgView;
        //循环利用cell时，一定要注意此处值为上次利用时留下来的垃圾值
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    else if ([_item isKindOfClass:[MLSettingSwitchItem class]])
    {
        self.accessoryView = self.switcher;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else if ([_item isKindOfClass:[MLSettingLabelItem class]])
              {
                  self.accessoryView = self.labelView;
                  MLSettingLabelItem *labelItem = (MLSettingLabelItem *)_item;
                  self.labelView.text = labelItem.text;
                  self.selectionStyle = UITableViewCellSelectionStyleDefault;
              }
    else
    {
        self.accessoryView = nil;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    MLSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (nil == cell) {
        cell = [[MLSettingCell alloc] initWithStyle:UITableViewCellStyleValue1  reuseIdentifier:ID];
    }
    return cell;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

}

@end
