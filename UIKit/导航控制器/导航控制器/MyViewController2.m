//
//  MyViewController2.m
//  导航控制器
//
//  Created by tarena on 16/4/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyViewController2.h"
#import "MyViewController3.h"

@interface MyViewController2 ()

@end

@implementation MyViewController2
- (IBAction)backToFirst:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)jumpToThird:(id)sender {
    MyViewController3 *vc3 = [[MyViewController3 alloc] init];
    [self.navigationController pushViewController:vc3 animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"第二个控制器";
    //设置下一个控制器的返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    //设置导航栏左边的按钮
    //如果设置leftBarButtonItem，上个控制器设置的无效
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    //设置导航栏右边的按钮
    UIBarButtonItem *searchBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:nil action:nil];
  //  self.navigationItem.rightBarButtonItem = rightBtn;
    UIBarButtonItem *refreshBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:nil action:nil];
    
    self.navigationItem.rightBarButtonItems = @[searchBtn,refreshBtn];
    
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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
