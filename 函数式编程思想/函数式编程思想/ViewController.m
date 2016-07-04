//
//  ViewController.m
//  函数式编程思想
//
//  Created by tarena on 16/7/1.
//  Copyright © 2016年 tarena. All rights reserved.


#import "ViewController.h"
#import "CalculateManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CalculateManager *mgr = [[CalculateManager alloc]init];
    [[mgr calculate:^int(int result) {
        result += 5;
        result += 10;
        return result;
    }] result];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
