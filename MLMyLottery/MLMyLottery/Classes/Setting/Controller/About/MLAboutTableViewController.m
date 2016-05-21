//
//  MLAboutTableViewController.m
//  MLMyLottery
//
//  Created by tarena on 16/4/23.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MLAboutTableViewController.h"
#import "MLSettingItem.h"
#import "MLSettingArrowItem.h"
#import "MLSettingGroup.h"
#import "MLSettingCell.h"

@interface MLAboutTableViewController ()

@end

@implementation MLAboutTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addGroup0];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addGroup0
{
    MLSettingItem *support = [MLSettingArrowItem itemWithIcon:nil andTitle:@"评分支持"];
    MLSettingItem *phone = [MLSettingArrowItem itemWithIcon:nil andTitle:@"客服电话"];
    phone.subTitle = @"10086";

   
    MLSettingGroup *group0 = [[MLSettingGroup alloc] init];
    group0.items = @[support, phone];
    [self.dataList addObject:group0];
    
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
