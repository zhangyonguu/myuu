//
//  MLHtmlViewController.m
//  MLMyLottery
//
//  Created by tarena on 16/4/23.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MLHtmlViewController.h"
#import "MLHelp.h"

@interface MLHtmlViewController ()<UIWebViewDelegate>

@end

@implementation MLHtmlViewController

-(void)loadView
{
    //loadView在显示前设置self.view
    self.view = [[UIWebView alloc] init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = item;

    UIWebView *webView = (UIWebView *)self.view;
    NSURL *url = [[NSBundle mainBundle] URLForResource:_help.html withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    webView.delegate = self;
    [webView loadRequest:request];
    
    // Do any additional setup after loading the view.
}

-(void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//html加载完后，代理执行此方法
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *js = [NSString stringWithFormat:@"window.location.href = '#%@'",_help.ID];
    //解析js脚本
    [webView stringByEvaluatingJavaScriptFromString:js];
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
