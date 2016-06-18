//
//  KRMyProfileViewController.m
//  酷跑
//
//  Created by tarena on 16/6/12.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "KRMyProfileViewController.h"
#import "XMPPvCardTemp.h"
#import "KRXMPPTool.h"
#import "KRUserInfo.h"
@interface KRMyProfileViewController ()
- (IBAction)backBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nikeNameLabel;

@end

@implementation KRMyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    // 获取到电子名片模块对应的模型对象
    XMPPvCardTemp *vcardTemp = [KRXMPPTool sharedKRXMPPTool].xmppvCard.myvCardTemp;
    if (vcardTemp.photo) {
        self.headImageView.image = [UIImage imageWithData:vcardTemp.photo];
    }else{
        self.headImageView.image = [UIImage imageNamed:@"微信"];
    }
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = self.headImageView.bounds.size.width * 0.5;
    self.headImageView.layer.borderWidth = 2;
    self.headImageView.layer.borderColor = [UIColor whiteColor].CGColor;

    self.nikeNameLabel.text = vcardTemp.nickname;
    // 用户名 可以从KRUserInfo中获取
    self.userNameLabel.text = [KRUserInfo sharedKRUserInfo].userName;
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
@end






