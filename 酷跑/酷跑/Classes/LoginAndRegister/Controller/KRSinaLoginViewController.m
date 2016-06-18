//
//  KRSinaLoginViewController.m
//  酷跑
//
//  Created by tarena on 16/6/8.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "KRSinaLoginViewController.h"
#import "AFNetworking.h"
#import "KRUserInfo.h"
#import "KRXMPPTool.h"
#import "NSString+md5.h"
#define  APPKEY       @"2075708624"
#define  REDIRECT_URI @"http://www.tedu.cn"
#define  APPSECRET    @"36a3d3dec55af644cd94a316fdd8bfd8"
@interface KRSinaLoginViewController ()<UIWebViewDelegate,KRXMPPLoginDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation KRSinaLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 根据新浪官方要求 加载
    NSString *url = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",APPKEY,REDIRECT_URI];
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *url = request.URL.absoluteString;
    NSLog(@"%@",url);
    NSRange  range = [url rangeOfString:@"/?code="];
    NSString  *code = nil;
    if (range.length > 0) {
        code = [url substringFromIndex:range.location + range.length];
        NSLog(@"code = %@",code);
        // 再发送一次请求 获取access_token
        [self accessTokenWithCode:code];
        return  NO;
    }
    return  YES;
}
// 获取access_token 的方法
- (void) accessTokenWithCode:(NSString*) code {
    // 使用AFN 发送web请求 获取access_token
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = @"https://api.weibo.com/oauth2/access_token";
    // 按照微博官方要求 准备请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary  dictionary];
    parameters[@"client_id"] = APPKEY;
    parameters[@"client_secret"] = APPSECRET;
    parameters[@"grant_type"] = @"authorization_code";
    parameters[@"code"] = code;
    parameters[@"redirect_uri"] = REDIRECT_URI;
    // 发送请求 获取返回数据
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        // 把uid 作为用户名 access_token 处理之后作为密码
        NSString *uid = responseObject[@"uid"];
        // access_token 获取到之后 可以读 发微博等一系列的功能 
        NSString *access_token = responseObject[@"access_token"];
        [KRUserInfo sharedKRUserInfo].login = false;
        [KRUserInfo sharedKRUserInfo].userRegisterName = uid;
        [KRUserInfo sharedKRUserInfo].userRegisterPassword = access_token;
        // 调用xmpp 工具类完成注册
        __weak typeof (self) weakVc = self;
        [[KRXMPPTool sharedKRXMPPTool] userRegister:^(KRXMPPResultType type) {
            [weakVc handleXmppRegisterResult:type];
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
/** 把uid 作为用户名 access_token 处理之后作为密码 在openfire服务器上完成注册 注册成功之后再在web服务上也注册一下 注册的同时 自动完成openfire的登录  如果openfire服务器注册不成功呢? 自动登录 */
- (void) handleXmppRegisterResult:(KRXMPPResultType) type{
    switch (type) {
        case KRXMPPResultTypeRegisterSuccess:
            // 发起web注册
            [self  registerForWebSever];
        case KRXMPPResultTypeRegisterFailed:
            // xmpp 注册失败了 也要自动登录一次
            // 完成openfire服务器的登录
            [KRUserInfo sharedKRUserInfo].userName = [KRUserInfo sharedKRUserInfo].userRegisterName;
            [KRUserInfo sharedKRUserInfo].userPassword = [KRUserInfo sharedKRUserInfo].userRegisterPassword;
            [KRUserInfo sharedKRUserInfo].login = YES;
            // 调用xmpp 工具类的登录方法
            [KRXMPPTool sharedKRXMPPTool].loginDelegate = self;
            [[KRXMPPTool sharedKRXMPPTool] userLogin];
            break;
        case KRXMPPResultTypeRegisterNetError:
            
            break;
        default:
            break;
    }
}
/** 完成web注册的方法 */
- (void) registerForWebSever{
    NSString *url = @"http://localhost:8080/allRunServer/register.jsp";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"username"] = [KRUserInfo sharedKRUserInfo].userRegisterName;
    parameters[@"md5password"] = [[KRUserInfo sharedKRUserInfo].userRegisterPassword  md5StrXor];
    parameters[@"nikename"] = [KRUserInfo sharedKRUserInfo].userRegisterName;
    parameters[@"gender"] = @(1);
    // 头像参数  错误的写法
    // parameters[@"pic"] = ;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 在这里写上传的文件操作
        UIImage *image = [UIImage imageNamed:@"微信"];
        NSData *data = UIImagePNGRepresentation(image);
        /* 第一个参数是上传的文件二进制数据
         第二个参数 服务器要求的文件参数的名字
         第三个参数 服务器上存储文件的名字
         第四个参数 说明数据的类型
         */
        [formData appendPartWithFileData:data name:@"pic" fileName:@"headImage.png" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loginSuccess{
    // 界面跳转
    [KRUserInfo sharedKRUserInfo].sinaLogin = YES;
    UIStoryboard *soryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [UIApplication sharedApplication].keyWindow.rootViewController = soryboard.instantiateInitialViewController;
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)loginFailed{
    NSLog(@"自动登录失败");
}
- (void)loginNetError{
    NSLog(@"自动登录网络错误");
}
@end








