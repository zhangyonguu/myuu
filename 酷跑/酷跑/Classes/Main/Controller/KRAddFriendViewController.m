//
//  KRAddFriendViewController.m
//  酷跑
//
//  Created by tarena on 16/6/13.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "KRAddFriendViewController.h"
#import "KRUserInfo.h"
#import "KRXMPPTool.h"
#import "MBProgressHUD+KR.h"
@interface KRAddFriendViewController ()
@property (weak, nonatomic) IBOutlet UITextField *friendNameField;
- (IBAction)addFriendBtnClick:(id)sender;

@end

@implementation KRAddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)addFriendBtnClick:(id)sender {
    // 不能添加自己
    if([self.friendNameField.text isEqualToString:[KRUserInfo sharedKRUserInfo].userName]){
        [MBProgressHUD showError:@"不能添加自己"];
        return;
    }
    // 不能添加已经添加过的
    NSString *jidStr = [NSString stringWithFormat:@"%@@%@",self.friendNameField.text,KRXMPPDOMAIN];
    if ([[KRXMPPTool sharedKRXMPPTool].xmppRosterStore userExistsWithJID:[XMPPJID jidWithString:jidStr] xmppStream:[KRXMPPTool sharedKRXMPPTool].xmppStream]) {
        [MBProgressHUD showError:@"已经添加过"];
        return;
    }
    // 添加
    [[KRXMPPTool sharedKRXMPPTool].xmppRoster subscribePresenceToUser:[XMPPJID jidWithString:jidStr]];
    [self.navigationController popViewControllerAnimated:YES];
}
@end







