//
//  KRRegisterViewController.m
//  酷跑
//
//  Created by tarena on 16/6/8.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "KRRegisterViewController.h"
#import "KRUserInfo.h"
#import "KRXMPPTool.h"
#import "AFNetworking.h"
#import "NSString+md5.h"
#import "MBProgressHUD+KR.h"
@interface KRRegisterViewController ()/*<KRXMPPRegisterDelegate>*/
- (IBAction)backBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *userRegisterNameField;
@property (weak, nonatomic) IBOutlet UITextField *userRegisterPasswordField;
- (IBAction)registerBtnClick:(id)sender;

@end

@implementation KRRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *leftN = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon"]];
    leftN.frame = CGRectMake(0, 0, 55, 20);
    leftN.contentMode = UIViewContentModeCenter;
    self.userRegisterNameField.leftViewMode =  UITextFieldViewModeAlways;
    self.userRegisterNameField.leftView = leftN;
    UIImageView *leftP = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lock"]];
    leftP.frame = CGRectMake(0, 0, 55, 20);
    leftP.contentMode = UIViewContentModeCenter;
    self.userRegisterPasswordField.leftViewMode =  UITextFieldViewModeAlways;
    self.userRegisterPasswordField
    .leftView = leftP;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)registerBtnClick:(id)sender {
    // 当注册的用户名 或者密码没有输入时 提示用户不能为空
    if([self.userRegisterNameField.text isEqualToString:@""] || [self.userRegisterPasswordField.text isEqualToString:@""]){
        [MBProgressHUD showError:@"用户名密码不能为空"];
        return;
    }
    [KRUserInfo sharedKRUserInfo].userRegisterName = self.userRegisterNameField.text;
    [KRUserInfo sharedKRUserInfo].userRegisterPassword = self.userRegisterPasswordField.text;
    [KRUserInfo sharedKRUserInfo].login = NO;
    // 设置代理
    //[KRXMPPTool sharedKRXMPPTool].registerDelegate = self;
    // 调用工具类的注册方法
//    [[KRXMPPTool sharedKRXMPPTool] userRegister];
//    __weak KRRegisterViewController* weakVc = self;
    __weak typeof(self) weakVc = self;
    [MBProgressHUD showMessage:@"正在注册..."];
    [[KRXMPPTool sharedKRXMPPTool]userRegister:^(KRXMPPResultType type) {
        // 处理注册结果 type
        [weakVc handleRegisterResultType:type];
        [MBProgressHUD hideHUD];
    }];
}
// 处理注册结果的方法
- (void) handleRegisterResultType:(KRXMPPResultType) type{
    switch (type) {
        case KRXMPPResultTypeRegisterSuccess:
            NSLog(@"注册成功");
            // 发送web请求 完成web注册
            [self registerForWebSever];
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case KRXMPPResultTypeRegisterFailed:
            NSLog(@"注册失败");
            break;
        case KRXMPPResultTypeRegisterNetError:
            NSLog(@"注册时网络错误");
            break;
        default:
            break;
    }
}
/* - (void)registerSuccess{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)registerFailed{
    NSLog(@"注册控制器中获取到注册失败");
}
- (void)registerNetError{
    NSLog(@"注册控制器中获取到网络错误");
} */
- (void)dealloc
{
    NSLog(@"dealloc:%@",self);
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
@end









