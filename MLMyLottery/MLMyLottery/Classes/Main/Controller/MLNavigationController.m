//
//  MLNavigationController.m
//  MLMyLottery
//
//  Created by tarena on 16/4/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MLNavigationController.h"

@interface MLNavigationController ()

@end

@implementation MLNavigationController

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
}

+(void)initialize
{//第一次使用本类，或者子类的时候调用，加判断确保只调用一次，
    if (self == [MLNavigationController class]) {
        [self setupNaviBar];
        [self setupBarButton];
        
    }
}

+(void)setupNaviBar
{
    UINavigationBar *bar = [UINavigationBar appearance];
    //NSLog(@"%@",[UIDevice currentDevice].systemVersion);
    [bar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    
    NSDictionary *dict = @{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName : [UIFont systemFontOfSize:18]};
    [bar setTitleTextAttributes:dict];
    [bar setTintColor:[UIColor whiteColor]];
}

+(void)setupBarButton
{
    UIBarButtonItem *barButton = [UIBarButtonItem appearance];
    [barButton setBackgroundImage:[UIImage imageNamed:@"NavButton"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [barButton setBackgroundImage:[UIImage imageNamed:@"NavButtonPressed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    [barButton setBackButtonBackgroundImage:[UIImage imageNamed:@"NavBackButton"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [barButton setBackButtonBackgroundImage:[UIImage imageNamed:@"NavBackButtonPressed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
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
