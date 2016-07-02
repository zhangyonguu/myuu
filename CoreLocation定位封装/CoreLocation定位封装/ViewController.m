//
//  ViewController.m
//  CoreLocation定位封装
//
//  Created by tarena on 16/5/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "ZYLocationManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ZYLocationManager *mgr = [ZYLocationManager sharedLocationManager];
    [mgr updateLocationWithCompletionHandler:^(CLLocation *location, NSError *error) {
        if (!error) {
             NSLog(@"%f; %f", location.coordinate.latitude, location.coordinate.longitude);
        }
        else
        {
            NSLog(@"fail");
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
