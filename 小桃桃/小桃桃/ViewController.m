//
//  ViewController.m
//  小桃桃
//
//  Created by tarena on 16/5/26.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "DPAPI.h"
#import "ZYMetaDataTool.h"

@interface ViewController ()<DPRequestDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DPAPI *api = [[DPAPI alloc] init];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"city"] = @"深圳";
    params[@"region"] = @"龙岗区";
    params[@"category"] = @"美食";
    params[@"sort"] = @2;
    
    [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    NSArray *array = [ZYMetaDataTool parseDealsResult:result];
    //ToDo
}

-(void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
