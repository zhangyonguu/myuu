//
//  MyViewController1.m
//  导航控制器
//
//  Created by tarena on 16/4/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyViewController1.h"
#import "MyViewController2.h"

@interface MyViewController1 ()

@end

@implementation MyViewController1
- (IBAction)jumpToSecond:(id)sender {
    MyViewController2 *vc2 = [[MyViewController2 alloc] init];
    [self.navigationController pushViewController:vc2 animated:YES];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"第一个控制器";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:nil action:nil];
    
    self.navigationItem.leftBarButtonItem = leftBtn;
    // Do any additional setup after loading the view from its nib.
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
