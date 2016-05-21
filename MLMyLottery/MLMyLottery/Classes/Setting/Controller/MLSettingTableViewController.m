//
//  MLSettingTableViewController.m
//  MLMyLottery
//
//  Created by tarena on 16/4/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MLSettingTableViewController.h"
#import "MLSettingItem.h"
#import "MLSettingGroup.h"
#import "MLSettingCell.h"
#import "MLSettingArrowItem.h"
#import "MLSettingSwitchItem.h"
#import "MBProgressHUD+MJ.h"
#import "MLProductCollectionViewController.h"
#import "MLPushTableViewController.h"
#import "MLHelpTableViewController.h"
#import "MLShareTableViewController.h"
#import "MLAboutTableViewController.h"

@interface MLSettingTableViewController ()

@end

@implementation MLSettingTableViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    [self addGroup0];
    [self addGroup1];
}

-(void)addGroup0
{
    MLSettingItem *pushAndNotice = [MLSettingArrowItem itemWithIcon:@"MorePush" andTitle:@"推送和提醒" andDestVCClass:[MLPushTableViewController class]];
    MLSettingItem *shakeOnce = [MLSettingSwitchItem itemWithIcon:@"handShake" andTitle:@"摇一摇机选"];
    MLSettingItem *soundEffect = [MLSettingSwitchItem itemWithIcon:@"sound_Effect" andTitle:@"声音效果"];
    MLSettingGroup *group0 = [[MLSettingGroup alloc] init];
    group0.items = @[pushAndNotice, shakeOnce, soundEffect];
    [self.dataList addObject:group0];
}

-(void)addGroup1
{
    MLSettingItem *newVersion = [MLSettingArrowItem itemWithIcon:@"MoreUpdate" andTitle:@"检测新版本"];
    newVersion.option = ^{
        //1.显示蒙板
        [MBProgressHUD showMessage:@"正在检查ing......"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //2.隐藏蒙板
            [MBProgressHUD hideHUD];
            //3.提示用户----功能封装在模型中
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"有新版本" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:nil];
            UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:actionYes];
            [alert addAction:actionNo];
            [self presentViewController:alert animated:YES completion:nil];
        });
    };
    
    MLSettingItem *help = [MLSettingArrowItem itemWithIcon:@"MoreHelp" andTitle:@"帮助" andDestVCClass:[MLHelpTableViewController class]];
    
    MLSettingItem *share = [MLSettingArrowItem itemWithIcon:@"MoreShare" andTitle:@"分享" andDestVCClass:[MLShareTableViewController class]];
    
    MLSettingItem *message = [MLSettingArrowItem itemWithIcon:@"MoreMessage" andTitle:@"查看消息"];
    
    MLSettingItem *push = [MLSettingArrowItem itemWithIcon:@"MoreNetease" andTitle:@"产品推荐" andDestVCClass:[MLProductCollectionViewController class]];
    
    MLSettingItem *about = [MLSettingArrowItem itemWithIcon:@"MoreAbout" andTitle:@"关于" andDestVCClass:[MLAboutTableViewController class]];
    MLSettingGroup *group1 = [[MLSettingGroup alloc] init];
    group1.items = @[newVersion, help, share, message, push, about];
    
    [self.dataList addObject:group1];

}
@end
