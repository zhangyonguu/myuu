//
//  ViewController.m
//  JS
//
//  Created by tarena on 16/6/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSObjcDelegate <JSExport>

-(void)callCamera;
-(void)share:(NSString *)shareString;
@end

@interface ViewController () <UIWebViewDelegate, JSObjcDelegate>
@property (nonatomic, strong) JSContext *jsContext;
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"];
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark -webviewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    _jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    _jsContext[@"Toyun"] = self;
    _jsContext.exceptionHandler = ^(JSContext *con, JSValue *exception){
        con.exception = exception;
        NSLog(@"异常%@",exception);
    };
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.absoluteString;
    if ([url rangeOfString:@"toyun://"].location != NSNotFound) {
        NSLog(@"callCamera");
        return NO;
    }
    return YES;
}

#pragma mark -JSObjcDelegate
//回调在子线程进行
-(void)callCamera
{
    //如果此方法内到其他线程执行去了，再次回调js方法时，要回到该子线程
    NSLog(@"%@",[NSThread currentThread]);
    NSLog(@"callCamera");
    JSValue *picCallback = self.jsContext[@"picCallback"];
    [picCallback callWithArguments:@[@"photos"]];
}

-(void)share:(NSString *)shareString
{
    NSLog(@"%@",[NSThread currentThread]);
    NSLog(@"share:%@", shareString);
    JSValue *shareCallback = self.jsContext[@"shareCallback"];
    [shareCallback callWithArguments:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
