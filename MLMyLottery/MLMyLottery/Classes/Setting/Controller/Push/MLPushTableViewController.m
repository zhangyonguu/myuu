//
//  MLPushTableViewController.m
//  MLMyLottery
//
//  Created by tarena on 16/4/22.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MLPushTableViewController.h"
#import "MLSettingItem.h"
#import "MLSettingArrowItem.h"
#import "MLSettingGroup.h"
#import "MLSettingCell.h"
#import "MLScoreTableViewController.h"
@interface MLPushTableViewController ()

@end

@implementation MLPushTableViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    [self addGroup0];
    
}

-(void)addGroup0
{
    MLSettingItem *push = [MLSettingArrowItem itemWithIcon:nil andTitle:@"开奖号码推送"];
    MLSettingItem *animate = [MLSettingArrowItem itemWithIcon:nil andTitle:@"中奖动画"];
    MLSettingItem *alive = [MLSettingArrowItem itemWithIcon:nil andTitle:@"比分直播" andDestVCClass:[MLScoreTableViewController class]];
    MLSettingItem *timer = [MLSettingArrowItem itemWithIcon:nil andTitle:@"购彩定时提醒"];
    MLSettingGroup *group0 = [[MLSettingGroup alloc] init];
    group0.items = @[push, animate, alive, timer];
    [self.dataList addObject:group0];

}
@end
