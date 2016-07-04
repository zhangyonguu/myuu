//
//  ViewController.m
//  xib的加载2
//
//  Created by tarena on 16/4/7.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "TRHomeViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    TRHomeViewController *homeVc = [[TRHomeViewController alloc] init];
    //[[TRHomeViewController alloc] init]时控制器默认会自动找对应的xib来创建view，首先找去掉Controller这个单词的同名xib，然后找完全同名的xib,最后找不到就会去创一个空的view。
    //--注意--自己定义某个View的xib是不要与控制器同名，或者只是少个Controller
    //修改了xib名字必须2步操作（因为有缓存）：1.删除软件，2.clean
    homeVc.view.backgroundColor = [UIColor redColor];
    homeVc.title = @"首页";
    UIColor *color1 = [UIColor redColor];
    UIColor *color2 = [UIColor redColor];
    NSLog(@"%p---%p",color1,color2);
    [self.navigationController pushViewController:homeVc animated:YES];
}
@end
