//
//  ViewController.m
//  通过手势移除控制器
//
//  Created by tarena on 16/4/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//
//    NSLog(@"%@-----%@",self.view, self.navigationController.view);
//}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%s",__func__);
    NSLog(@"%@",self.view.subviews);
}

@end
