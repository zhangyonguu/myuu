//
//  ZYDetailViewController.m
//  小桃桃
//
//  Created by tarena on 16/6/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZYDetailViewController.h"
#import "UIView+Extension.h"
#import "MBProgressHUD.h"

@interface ZYDetailViewController ()<UIWebViewDelegate>
@property (nonatomic, copy) NSString *dealUrl;
@end

@implementation ZYDetailViewController

-(instancetype)initWithDealUrl:(NSString *)dealUrl
{
    if (self = [super init]) {
        self.dealUrl = dealUrl;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title  = @"订单详情";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(clickBackItem)];
    self.navigationItem.leftBarButtonItem = backItem;
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -50, self.view.width, self.view.height + 50)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.dealUrl]]];
    
    [self.view addSubview:webView];
}

-(void)clickBackItem
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"加载网页失败:%@",error);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

@end
