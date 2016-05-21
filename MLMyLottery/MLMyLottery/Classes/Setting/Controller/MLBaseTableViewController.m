//
//  MLBaseTableViewController.m
//  MLMyLottery
//
//  Created by tarena on 16/4/22.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MLBaseTableViewController.h"
#import "MLPushTableViewController.h"
#import "MLSettingItem.h"
#import "MLSettingArrowItem.h"
#import "MLSettingGroup.h"
#import "MLSettingCell.h"
@interface MLBaseTableViewController ()

@end

@implementation MLBaseTableViewController

-(NSMutableArray *)dataList
{
    if (_dataList == nil) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;

}
-(instancetype)init
{//将样式封装，外界init时并不知道里面的样式
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //tableViewController的view属性和tableView属性指向同一处
    //NSLog(@"%p___%p",self.tableView ,self.view);
}

#pragma mark - Table view data source

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    MLSettingGroup *group = self.dataList[section];
    return group.header;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    MLSettingGroup *group = self.dataList[section];
    return group.footer;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    MLSettingGroup *group = self.dataList[section];
    return  group.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MLSettingCell *cell = [MLSettingCell cellWithTableView:tableView];
    MLSettingGroup *group = self.dataList[indexPath.section];
    MLSettingItem *item = group.items[indexPath.row];
    cell.item = item;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MLSettingGroup *group = self.dataList[indexPath.section];
    MLSettingItem *item = group.items[indexPath.row];
    if (item.option) {
        item.option();
        return;
    }
    if ([item isKindOfClass:[MLSettingArrowItem class]]) {
        MLSettingArrowItem *arrowItem = (MLSettingArrowItem *)item;
        if (arrowItem.destVCClass) {
            UIViewController *vc = [[arrowItem.destVCClass alloc] init];
            vc.navigationItem.title = arrowItem.title;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
@end
