//
//  MLShareTableViewController.m
//  MLMyLottery
//
//  Created by tarena on 16/4/23.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MLShareTableViewController.h"
#import "MLSettingItem.h"
#import "MLSettingGroup.h"

#import "MLSettingArrowItem.h"


@interface MLShareTableViewController ()

@end

@implementation MLShareTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGroup0];
    // Do any additional setup after loading the view.
}

-(void)addGroup0
{
    MLSettingItem *sina = [MLSettingArrowItem itemWithIcon:@"WeiboSina" andTitle:@"新浪分享" andDestVCClass:nil];
    MLSettingItem *sms = [MLSettingArrowItem itemWithIcon:@"SmsShare" andTitle:@"短信分享"];
    MLSettingItem *mail = [MLSettingArrowItem itemWithIcon:@"MailShare" andTitle:@"邮件分享"];
    MLSettingGroup *group0 = [[MLSettingGroup alloc] init];
    group0.items = @[sina, sms, mail];
    [self.dataList addObject:group0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
