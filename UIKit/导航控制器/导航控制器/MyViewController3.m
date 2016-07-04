//
//  MyViewController3.m
//  导航控制器
//
//  Created by tarena on 16/4/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyViewController3.h"

@interface MyViewController3 ()

@end

@implementation MyViewController3
- (IBAction)backToFirst:(id)sender {
    //UIViewController *vc = self.navigationController.viewControllers[0];
   // UIViewController *vc = self.navigationController.childViewControllers[0];
  //  [self.navigationController popToViewController:vc animated:YES];
   [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    self.navigationItem.titleView = button;
    
    //设置返回按钮
    UIButton *redBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    redBtn.bounds = CGRectMake(0, 0, 46, 31);
    [redBtn setBackgroundImage:[UIImage imageNamed:@"btn_back_normal"] forState:UIControlStateNormal];
    [redBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *redBackBtnItem = [[UIBarButtonItem alloc] initWithCustomView:redBtn];
    
    self.navigationItem.leftBarButtonItem = redBackBtnItem;
}

//返回上一个VC
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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
