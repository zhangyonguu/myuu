//
//  MLTabBarViewController.m
//  MLMyLottery
//
//  Created by tarena on 16/4/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MLTabBarViewController.h"
#import "MLTabBar.h"
#import <Availability.h>
#import <AvailabilityInternal.h>
#import <AvailabilityMacros.h>

@interface MLTabBarViewController ()<MLTabBarDelegate>

@end

@implementation MLTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//移除自带的tabBar
  //  [self.tabBar removeFromSuperview];
    
//    NSLog(@"%@",self.tabBar);
    //bounds的origin为{0，0};
//    NSLog(@"%@",NSStringFromCGRect(self.tabBar.bounds));
//    NSLog(@"%@",self.view.subviews);
    //创建tabBar
    MLTabBar *tabBar = [[MLTabBar alloc] init];
//    tabBar.block = ^(int selected){
//        self.selectedIndex = selected;
//    };
    tabBar.delegate = self;
    //tabBar.frame = self.tabBar.frame;
    
    //将tabBar添加到系统自带的tabBar，这样在storyboard上勾选Hide bottom bar on push，push时会自动隐藏系统自带的tabBar
    tabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:tabBar];
    
    NSString *imageName = nil;
    NSString *imageNameSel = nil;
    for (int i = 0; i < self.childViewControllers.count; i++) {
        //根据tabBarController子控制器个数添加tabBar按钮
       imageName = [NSString stringWithFormat:@"TabBar%d",i + 1];
       imageNameSel = [NSString stringWithFormat:@"TabBar%dSel",i + 1];
       [tabBar addTabBarButtonWithName:imageName andSelName:imageNameSel];
    }


       
}

-(void)tabBar:(MLTabBar *)tabBar didSelectedIndex:(int)index
{
    self.selectedIndex = index;
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
