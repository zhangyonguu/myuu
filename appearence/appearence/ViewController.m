//
//  ViewController.m
//  appearence
//
//  Created by tarena on 16/4/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (IBAction)changeColor:(UITapGestureRecognizer *)sender {
    NSLog(@"tapped");
    UIButton *button = [UIButton appearance];
    NSLog(@"%@",button);
    button.backgroundColor = [UIColor redColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIButton *button = [UIButton appearance];
//    button.backgroundColor = [UIColor lightGrayColor];

    UILabel *label = [UILabel appearance];
    label.backgroundColor = [UIColor greenColor];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
