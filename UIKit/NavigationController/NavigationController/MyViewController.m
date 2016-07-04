//
//  MyViewController.m
//  NavigationController
//
//  Created by tarena on 16/4/15.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyViewController.h"
#import "MyViewController2.h"

@interface MyViewController ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation MyViewController

-(UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
    }
    return _textField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //使用view后才可以点（ios9.2以前）
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.title = @"新闻列表";
    
    self.textField.frame = CGRectMake(200, 200, 100, 30);
    _textField.placeholder = @"请输入名字";
    _textField.borderStyle = UITextBorderStyleRoundedRect;
   // _textField.text = self.content;
    [self.view addSubview:_textField];
    
    //设置一个button
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(200, 400, 50, 50)];
    button.backgroundColor = [UIColor redColor];
    
    [button addTarget:self action:@selector(jump:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

//页面返回时，不会重新再调用viewDidLoad了
-(void)viewWillAppear:(BOOL)animated
{
//    self.textField.text = self.textField.text;
//   [self viewDidLoad];
//    self.textField.text = self.content;??????
}

-(void)jump:(UIButton *)sender
{
    [self.view endEditing:YES];
    
    MyViewController2 *vc2 = [[MyViewController2 alloc] init];
    
    //正向传值传内容，不能直接给控件公开出去（控件私有）
    vc2.label.text = self.textField.text;//不行？？？
    [vc2 setValue:self.textField.text forKeyPath:@"textField.text"];
   // vc2.content = self.textField.text;
    vc2.vc = self;
    
    [self.navigationController pushViewController:vc2 animated:YES];
   // [vc2 viewDidLoad];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    MyViewController2 *vc2 = [[MyViewController2 alloc] init];
//    //push函数返回值为void
//    [self.navigationController pushViewController:vc2 animated:YES];
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
