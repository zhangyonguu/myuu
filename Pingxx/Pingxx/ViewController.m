//
//  ViewController.m
//  Pingxx
//
//  Created by tarena on 16/6/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#define kUrl            @"http://218.244.151.190/demo/charge" // 你的服务端创建并返回 charge 的 URL 地址，此地址仅供测试用。
#define kUrlScheme      @"pingxx" // 这个是你定义的 URL Scheme，支付宝、微信支付、银联和测试模式需要。

#import "ViewController.h"
#import "Pingpp.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *payMoney;

@end

@implementation ViewController
- (IBAction)pay:(id)sender {
    
    NSString *amountStr = [NSString stringWithFormat:@"%g", self.payMoney.text.floatValue];
    NSURL* url = [NSURL URLWithString:kUrl];
    NSMutableURLRequest * postRequest=[NSMutableURLRequest requestWithURL:url];
    
    NSDictionary* dict = @{
                           @"channel" : @"alipay",
                           @"amount"  : amountStr
                           };
    NSData* data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *bodyData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [postRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    ViewController * __weak weakSelf = self;
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    [NSURLConnection sendAsynchronousRequest:postRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;

            if (httpResponse.statusCode != 200) {
                NSLog(@"statusCode=%ld error = %@", (long)httpResponse.statusCode, connectionError);

                return;
            }
            if (connectionError != nil) {
                NSLog(@"error = %@", connectionError);

                return;
            }
            NSString* charge = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"charge = %@", charge);
            [Pingpp createPayment:charge
                   viewController:weakSelf
                     appURLScheme:kUrlScheme
                   withCompletion:^(NSString *result, PingppError *error) {
                       NSLog(@"completion block: %@", result);
                       if (error == nil) {
                           NSLog(@"PingppError is nil");
                       } else {
                           NSLog(@"PingppError: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
                       }
                   }];
        });
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
