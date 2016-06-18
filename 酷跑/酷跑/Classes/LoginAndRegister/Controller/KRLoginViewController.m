//
//  KRLoginViewController.m
//  酷跑
//
//  Created by tarena on 16/6/7.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "KRLoginViewController.h"
#import "KRUserInfo.h"
#import "KRXMPPTool.h"
#import "MBProgressHUD+KR.h"
@interface KRLoginViewController ()<KRXMPPLoginDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordField;
- (IBAction)loginBtnClick:(id)sender;

@end

@implementation KRLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *leftN = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon"]];
    leftN.frame = CGRectMake(0, 0, 55, 20);
    leftN.contentMode = UIViewContentModeCenter;
    self.userNameField.leftViewMode =  UITextFieldViewModeAlways;
    self.userNameField.leftView = leftN;
    UIImageView *leftP = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lock"]];
    leftP.frame = CGRectMake(0, 0, 55, 20);
    leftP.contentMode = UIViewContentModeCenter;
    self.userPasswordField.leftViewMode =  UITextFieldViewModeAlways;
    self.userPasswordField.leftView = leftP;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginBtnClick:(id)sender {
    // 点击按钮时 如果没有输入用户名 或者密码 提示用户输入
    if (self.userNameField.text.length == 0 ||self.userPasswordField.text.length ==0) {
        [MBProgressHUD showError:@"用户名密码不能为空"];
        return;
    }
    [KRUserInfo sharedKRUserInfo].userName = self.userNameField.text;
    [KRUserInfo sharedKRUserInfo].userPassword = self.userPasswordField.text;
    // 设置为登录状态
    [KRUserInfo sharedKRUserInfo].login = YES;
    // 设置代理
    [KRXMPPTool sharedKRXMPPTool].loginDelegate = self;
    // 调用xmppframework 的api 完成登录
    // 最好是和服务器的交互封装成工具类
    [[KRXMPPTool sharedKRXMPPTool] userLogin];
    
}
- (void)loginSuccess {
    NSLog(@"控制器中获取到登录成功");
    [MBProgressHUD showSuccess:@"登录成功"];
    // 切换界面
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [UIApplication sharedApplication].keyWindow.rootViewController = storyboard.instantiateInitialViewController;
}
- (void)loginFailed {
    NSLog(@"控制器中获取到登录失败");
    [MBProgressHUD showError:@"登录失败"];
}
- (void)loginNetError{
    NSLog(@"控制器中获取到登录网络错误");
}
@end








