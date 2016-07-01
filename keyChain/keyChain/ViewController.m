//
//  ViewController.m
//  keyChain
//
//  Created by tarena on 16/6/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "KCKeyChain.h"

@interface ViewController ()

@end

@implementation ViewController
NSString * const KEY_USERNAME_PASSWORD = @"com.company.app.usernamepassword";
NSString * const KEY_USERNAME = @"com.company.app.username";
NSString * const KEY_PASSWORD = @"com.company.app.password";

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [KCKeyChain save:KEY_USERNAME_PASSWORD data:@"123456"];
//    [KCKeyChain delete:KEY_USERNAME_PASSWORD];
    NSString *password = [KCKeyChain load:KEY_USERNAME_PASSWORD];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
