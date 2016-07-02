//
//  PCAskDiagViewController.m
//  PregnantCare
//
//  Created by tarena on 16/6/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PCAskDiagViewController.h"

@interface PCAskDiagViewController ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation PCAskDiagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://dr.caredsp.com/api/choose?b5YNHT8mhJ5z8MPRITgHB5GNJISPfhhUqMNhriAONRDlVEtVRO0AxEEXBCJ0gK%2Fd6%2B9iikRgj1JZ%2Bwd8c6vanw%3D%3D"]]];
    [self.view addSubview:self.webView];
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

@end
