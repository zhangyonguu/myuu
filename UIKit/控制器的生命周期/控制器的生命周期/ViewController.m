//
//  ViewController.m
//  控制器的生命周期
//
//  Created by tarena on 16/4/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"one-----viewDidLoad");
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"one-----viewWillAppear");
}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"one-----viewDidAppear");
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"one-----viewWillDisappear");
}

-(void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"one-----viewDidDisappear");
}

-(void)didReceiveMemoryWarning
{
    NSLog(@"one-------%s",__func__);
    [super didReceiveMemoryWarning];
}

@end
