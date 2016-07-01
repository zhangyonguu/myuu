//
//  ViewController.m
//  自定义UIPresentationController
//
//  Created by tarena on 16/4/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "MyTransition.h"
#import "Singleton.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    SecondViewController *second = [[SecondViewController alloc] init];
    //一定要设置展示样式为custom
    second.modalPresentationStyle = UIModalPresentationCustom;
//    second.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    //设置代理可以用来决定控制展示的控制器
    second.transitioningDelegate = [MyTransition sharedTransition];

    [self presentViewController:second animated:YES completion:nil];

}


@end

