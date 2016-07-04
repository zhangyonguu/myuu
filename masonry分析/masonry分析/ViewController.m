//
//  ViewController.m
//  masonry分析
//
//  Created by tarena on 16/7/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "NSObject+Calculate.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    //设置约束一定要先把view添加上去
    [self.view addSubview:redView];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@10);
        make.right.bottom.equalTo(@-50);
    }];
    
    int result = [NSObject mc_makeCalculates:^(MASCalculatetMaker *maker) {
        maker.add(5).add(10);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
