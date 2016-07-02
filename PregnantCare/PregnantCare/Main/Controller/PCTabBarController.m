
//
//  PCTabBarController.m
//  PregnantCare
//
//  Created by tarena on 16/6/3.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PCTabBarController.h"
#import "PCRequestTool.h"
#import "PCArticle.h"
#import "PCAppBanner.h"

@interface PCTabBarController ()

@end

@implementation PCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UITabBar appearance].backgroundColor = styleColor;

//
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = styleColor;
//    view.frame = appearance.bounds;
//    [appearance insertSubview:view atIndex:0];

//appBanner url: @"/flashinterface/GetAppBanner.ashx?topicid=151&typeid=1"
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
