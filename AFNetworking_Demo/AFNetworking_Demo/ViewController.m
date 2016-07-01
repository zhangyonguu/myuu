//
//  ViewController.m
//  AFNetworking_Demo
//
//  Created by tarena on 16/5/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking/AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController
- (IBAction)sendHTTPGetRequest:(id)sender {
    NSString *urlString = @"http://www.raywenderlich.com/demos/weather_sample/weather.php?format=json";
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",[NSThread currentThread]);
        NSLog(@"responseObject---%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error----%@",error.userInfo);
    }];
}

- (IBAction)sendHTTPPostRequest:(id)sender {
    NSString *urlString = @"http://www.raywenderlich.com/demos/weather_sample/weather.php";
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *paramDicM = [NSMutableDictionary dictionary];
    
    paramDicM[@"format"] = @"json";
    
    [mgr POST:urlString parameters:paramDicM progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",[NSThread currentThread]);

        NSLog(@"responseObject----%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error----%@",error.userInfo);
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
