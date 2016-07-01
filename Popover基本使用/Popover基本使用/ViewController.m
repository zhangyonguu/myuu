//
//  ViewController.m
//  Popover基本使用
//
//  Created by tarena on 16/5/7.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "MyMenuControllerTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)popMenu:(UIBarButtonItem *)sender {
    /**
     1.创建
     2.内容
     3.frame
     4.where
     */
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:[[UINavigationController alloc] initWithRootViewController:[[MyMenuControllerTableViewController alloc] init]]
];
    
    popover.popoverContentSize = CGSizeMake(320, 44 * 3);
    
    [popover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
