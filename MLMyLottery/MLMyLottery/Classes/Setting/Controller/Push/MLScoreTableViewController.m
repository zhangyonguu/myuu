//
//  MLScoreTableViewController.m
//  MLMyLottery
//
//  Created by tarena on 16/4/22.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MLScoreTableViewController.h"
#import "MLSettingSwitchItem.h"
#import "MLSettingGroup.h"
#import "MLSettingLabelItem.h"
#import "MLSaveDataTool.h"

@interface MLScoreTableViewController ()

@property (nonatomic, strong) MLSettingLabelItem *start;

@end

@implementation MLScoreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGroup0];
    [self addGroup1];
    [self addGroup2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addGroup0
{
    MLSettingSwitchItem *noticePlay = [MLSettingSwitchItem itemWithIcon:nil andTitle:@"提醒我关注比赛"];
    MLSettingGroup *group0 = [[MLSettingGroup alloc] init];
    group0.items = @[noticePlay];
    group0.footer = @"当我关注的比赛比分发生变化时，通过小弹窗或推送进行提醒";
    [self.dataList addObject:group0]; 
}

-(void)addGroup1
{
    MLSettingLabelItem *startTime = [MLSettingLabelItem itemWithIcon:nil andTitle:@"开始时间"];
    _start = startTime;
  
    if (!startTime.text.length) {
        
        startTime.text = @"00:00";
    }
    startTime.option = ^{

        UITextField *textField = [[UITextField alloc] init];
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeTime;
        datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"HH:mm";
        NSDate *date = [formatter dateFromString:@"00:00"];
        datePicker.date = date;
        [datePicker addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
        textField.inputView = datePicker;
        [textField becomeFirstResponder];
        [self.view addSubview:textField];
    };
    MLSettingGroup *group1 = [[MLSettingGroup alloc] init];
    group1.items = @[startTime];
    group1.header = @"只在以下时间接受比分直播提醒";
    [self.dataList addObject:group1];
}

-(void)valueChanged:(UIDatePicker *)datePicker
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    _start.text = [formatter stringFromDate:[datePicker date]];
    
    [self.tableView reloadData];
}
-(void)addGroup2
{
    MLSettingLabelItem *endTime = [MLSettingLabelItem itemWithIcon:nil andTitle:@"结束时间"];
    endTime.text = @"24:00";
    MLSettingGroup *group2 = [[MLSettingGroup alloc] init];
    group2.items = @[endTime];
    [self.dataList addObject:group2];

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
