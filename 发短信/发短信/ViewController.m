//
//  ViewController.m
//  发短信
//
//  Created by tarena on 16/6/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>
#import "MBProgressHUD.h"
#import <SMS_SDK/SMSSDK.h>
@interface ViewController ()<MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *composeTF;
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation ViewController


-(UIWebView *)webView
{
    if (_webView == nil) {
        self.webView = [[UIWebView alloc] init];
        _webView.frame = CGRectZero;
    }
    return _webView;
}
- (IBAction)getVerificationCode:(id)sender {
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:@"15989514373" zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
        else
        {
            NSLog(@"验证码发送成功");
        }
    }];
}
- (IBAction)verifyVerificationCode:(id)sender {
    [SMSSDK commitVerificationCode:self.composeTF.text phoneNumber:@"15989514373" zone:@"86" result:^(NSError *error) {
        if (error) {
            NSLog(@"验证出错");
        }
        else
        {
            NSLog(@"验证成功");
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    NSURL *url = [NSURL URLWithString:@"sms://15983345325"];
//    [[UIApplication sharedApplication] openURL:url];


}
- (IBAction)phone:(id)sender {
    //tel,telprompt,
    NSURL *url = [NSURL URLWithString:@"telprompt://15989514373"];
//    [[UIApplication sharedApplication] openURL:url];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}
- (IBAction)sms:(id)sender {
    
    [self showMessageView:@[@"15989514373"] body:@"测试一下"];

}
- (IBAction)email:(id)sender {
    
    if ([MFMailComposeViewController canSendMail]) {
        NSLog(@"可以发邮件");
        MFMailComposeViewController *mailCon = [MFMailComposeViewController new];
        [mailCon setSubject:@"我的周报"];
        [mailCon setToRecipients:@[@"zhangy9210@icloud.com"]];
        // 抄送 cc
        // mailCon setCcRecipients
        // 密送 bcc
        //mailCon setBccRecipients:
        [mailCon setMessageBody: @"这是我的周报 <font color = \"blue\" size = 18 > 周报的内容 </font> 请审阅"isHTML:YES];
        NSData *imageData = UIImagePNGRepresentation([UIImage imageNamed:@"58"]);
        [mailCon addAttachmentData:imageData mimeType:@"image/png" fileName:@"abc.png"];
        // 设置发邮件的代理
        [mailCon setMailComposeDelegate:self];
        [self presentViewController:mailCon animated:YES completion:nil];
        mailCon.bottomLayoutGuide
    }else{
        NSLog(@"不能发邮件");
    }

}


-(void)showMessageView:(NSArray *)phones body:(NSString *)body
{
    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *msgController = [[MFMessageComposeViewController alloc] init];
        msgController.recipients = phones;
        msgController.body = body;
        msgController.messageComposeDelegate = self;
        msgController.navigationBar.tintColor = [UIColor redColor];
        [self presentViewController:msgController animated:YES completion:nil];
    }
    else
    {
        NSLog(@"此设备不支持发短信");
    }
}


#pragma mark -delegate

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
