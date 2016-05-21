//
//  MLHelpTableViewController.m
//  MLMyLottery
//
//  Created by tarena on 16/4/23.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MLHelpTableViewController.h"
#import "MLSettingItem.h"
#import "MLSettingArrowItem.h"
#import "MLSettingGroup.h"
#import "MLSettingCell.h"
#import "MLHelp.h"
#import "MLHtmlViewController.h"
#import "MLNavigationController.h"
@interface MLHelpTableViewController ()
@property (nonatomic, strong) NSMutableArray *helps;

@end    

@implementation MLHelpTableViewController

-(NSMutableArray *)helps
{
    if (_helps == nil) {
        _helps = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"help" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dict in array) {
            MLHelp *help = [MLHelp helpWithDict:dict];
            [_helps addObject:help];
        }
    }
    return _helps;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGroup0];
}

-(void)addGroup0
{
    MLSettingGroup *group0 = [[MLSettingGroup alloc] init];
    NSMutableArray *items = [NSMutableArray array];
    for (MLHelp *help in self.helps) {
        MLSettingArrowItem *item = [MLSettingArrowItem itemWithIcon:nil andTitle:help.title andDestVCClass:nil];
        [items addObject:item];
    }
    group0.items = items;
    [self.dataList addObject:group0];
    
}

//重写base类的此方法，更改点击时响应事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MLHelp *help = self.helps[indexPath.row];
    MLHtmlViewController *html = [[MLHtmlViewController alloc] init];
    html.help = help;
    html.navigationItem.title = help.title;
    //modal出来的最好包装在一个导航控制器里面，这样就有title
    MLNavigationController *navi = [[MLNavigationController alloc] initWithRootViewController:html];
    [self presentViewController:navi animated:YES completion:nil];
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
