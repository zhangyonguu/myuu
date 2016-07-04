//
//  ViewControllerTwo.m
//  控制器的生命周期
//
//  Created by tarena on 16/4/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewControllerTwo.h"

@interface ViewControllerTwo ()

@end

@implementation ViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"two------viewDidLoad");
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"two------viewWillAppear");
}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"two------viewDidAppear");
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"two------viewWillDisappear");
}

-(void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"two------viewDidDisappear");
}

//view被卸载时会清空数据，viewWillUnload，viewDidUnload已被禁用
-(void)viewWillUnload
{
    NSLog(@"two-----viewWillUnload");
}

-(void)viewDidUnload
{
    NSLog(@"two-----viewDidUnload");
}

//内存警告从UIApplication开始向下发送
-(void)didReceiveMemoryWarning
{
    NSLog(@"two-----%s",__func__);
    [super didReceiveMemoryWarning];
}

@end
