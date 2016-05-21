//
//  MLLoginViewController.m
//  MLMyLottery
//
//  Created by tarena on 16/4/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MLLoginViewController.h"
#import "MLSettingTableViewController.h"
#import "UIImage+Tool.h"

@interface MLLoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation MLLoginViewController
- (IBAction)setting:(id)sender {
    MLSettingTableViewController *settingVC = [[MLSettingTableViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置登录按钮的拉伸好的图片，按钮拉伸要通过代码来实现
    [self.loginButton setBackgroundImage:[UIImage imageWithResizableImageName:@"RedButton"] forState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:[UIImage imageWithResizableImageName:@"RedButtonPressed"] forState:UIControlStateHighlighted];

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
