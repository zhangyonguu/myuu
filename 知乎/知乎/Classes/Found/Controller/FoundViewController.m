//
//  FoundViewController.m
//  知乎
//
//  Created by tarena on 16/5/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "FoundViewController.h"

@interface FoundViewController ()

@end

@implementation FoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *array = @[@"推荐", @"圆桌", @"热门", @"收藏"];
    for (int i = 0; i < 4; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.backgroundColor = [UIColor whiteColor];
        CGFloat height = 16;
        CGFloat width = 40;
        CGFloat space = 50;
        CGFloat leadingEdge = (self.view.frame.size.width - width * 4 - space * 3) * 0.5;
        CGFloat x = leadingEdge + i * (width + space);
        CGFloat y = (self.navigationController.navigationBar.frame.size.height - height) * 0.5;
        button.frame = CGRectMake(x, y, width, height);
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.navigationController.navigationBar addSubview:button];
    }
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
