//
//  PCNaviViewController.m
//  PregnantCare
//
//  Created by tarena on 16/6/14.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PCNaviViewController.h"

@interface PCNaviViewController ()

@end

@implementation PCNaviViewController

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationBar *naviBar = [UINavigationBar appearance];
    naviBar.backgroundColor = styleColor;
    // Do any additional setup after loading the view.
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
