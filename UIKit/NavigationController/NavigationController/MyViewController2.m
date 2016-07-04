//
//  MyViewController2.m
//  NavigationController
//
//  Created by tarena on 16/4/15.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyViewController2.h"

@interface MyViewController2 ()
@property (nonatomic, strong) UITextField *textField;
@end

@implementation MyViewController2

-(UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
    }
    return _label;
}

-(UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
    }
    return _textField;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.label.frame = CGRectMake(200, 200, 200, 50);
    self.label.font = [UIFont systemFontOfSize:20];
   // _label.text = self.content;
    _label.backgroundColor = [UIColor redColor];
    [self.view addSubview:_label];

    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(200, 400, 50, 50);
    button.backgroundColor = [UIColor blackColor];
    [button addTarget:self action:@selector(jumpBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.textField.frame = CGRectMake(200, 300, 200, 50);
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
   // self.textField.text = self.content;
    [self.view addSubview:self.textField];
    [self.textField addTarget:self action:@selector(changeLabel:) forControlEvents:UIControlEventEditingChanged];
}

//label与textFIeld同时改变，用EditingChanged
-(void)changeLabel:(UITextField *)sender
{
    self.label.text = sender.text;
}

-(void)jumpBack:(UIButton *)sender
{
  //  self.vc.content = self.textField.text;
    //[self.vc viewDidLoad];
    [self.vc setValue:self.textField.text forKeyPath:@"textField"];
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //pop函数返回值是UIViewController
   // [self.navigationController popViewControllerAnimated:YES];
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
