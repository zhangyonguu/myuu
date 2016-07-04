//
//  ViewController.m
//  xib的加载
//
//  Created by tarena on 16/4/7.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "TRToolbar.h"

//UITapGestureRecognizer->UIGestureRecognizer->NSObject
//手势识别器不是View
@interface ViewController ()




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TRToolbar *tool = [TRToolbar toolbar];
    NSLog(@"%@",tool);
    
    [self.view addSubview:tool];
    
   // [tool addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTool)]];
   
}

//-(void)tapTool
//{
//    NSLog(@"点击了工具条");
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)tapGreenView:(UITapGestureRecognizer *)sender {
    NSLog(@"点击了绿色");
}
@end
