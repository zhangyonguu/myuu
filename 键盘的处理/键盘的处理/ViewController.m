//
//  ViewController.m
//  键盘的处理
//
//  Created by tarena on 16/4/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "KeyboardTool.h"

@interface ViewController ()<KeyboardToolDelegate>
{
    NSArray *_fields;
}
@property (weak, nonatomic) IBOutlet UITextField *birthdayField;
@property (weak, nonatomic) IBOutlet UIView *inputContainer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCustomKeyboard];
    
    [self setupKeyboardTool];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    NSLog(@"%@",_fields);
}

-(void)setupCustomKeyboard
{
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    self.birthdayField.inputView = datePicker;
}

-(void)setupKeyboardTool
{
    //创建工具
    KeyboardTool *tool = [KeyboardTool keyboardTool];
    //获取输入框窗口所有子控件
    NSArray *views = self.inputContainer.subviews;
    tool.delegate = self;
    NSMutableArray *fieldsM = [NSMutableArray array];
    for (UIView *view in views) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *tf = (UITextField *)view;
            tf.inputAccessoryView = tool;
            [fieldsM addObject:tf];
        }
    }
    _fields = fieldsM;
}

//获取当前textFIeld索引
-(NSInteger)getCurrentResponderIndex
{
    for (UITextField *tf in _fields) {
        if (tf.isFirstResponder) {
           return [_fields indexOfObject:tf];
        }
    }
    return -1;//没有找到响应者
}

-(void)kbFrameChange:(NSNotification *)notifi
{
    //NSLog(@"%@",notifi);
    //获取键盘改变后的y值
   CGRect kbEndFrame = [notifi.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat kbEndY = kbEndFrame.origin.y;
    
    //获取当前响应者
    NSInteger currentIndex = [self getCurrentResponderIndex];
    UITextField *currentTF = _fields[currentIndex];
    CGFloat currentTfMaxY = CGRectGetMaxY(currentTF.frame) + self.inputContainer.frame.origin.y;
    NSLog(@"%g %g",kbEndY, currentTfMaxY);
    
    //改变控制器view的transform
    if (currentTfMaxY > kbEndY) {
        [UIView animateWithDuration:0.25 animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(0, kbEndY - currentTfMaxY-20);
        }];
    }
    else
    {
        [UIView animateWithDuration:0.25 animations:^{
            self.view.transform = CGAffineTransformIdentity;
        }];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.25 animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark 键盘工具条代理
-(void)keyboardTool:(KeyboardTool *)keyboardTool didClickItemType:(KeyboardItemType)itemType
{
    //获取响应者
    NSInteger currentIndex = [self getCurrentResponderIndex];
    if (itemType == KeyboardItemTypePrevious) {
        NSLog(@"previous");
        
        [self showPreviousField:currentIndex];
    }
    else if(itemType == KeyboardItemTypeNext)
    {
        NSLog(@"next");
        [self showNextField:currentIndex];
    }
    else
    {
        NSLog(@"done");
        [self touchesBegan:[[NSSet alloc] init] withEvent:nil];
    }
}

-(void)showPreviousField:(NSInteger)currentIndex
{
    
    NSInteger previousIndex = currentIndex - 1;
    if (previousIndex >= 0) {
        //辞去第一响应者，触发一次通知
        UITextField *currentTF = _fields[currentIndex];
        [currentTF resignFirstResponder];
        //成为第一响应者，触发一次通知
        UITextField *previousTF = _fields[previousIndex];
        [previousTF becomeFirstResponder];
    }
}

-(void)showNextField:(NSInteger)currentIndex
{
    NSInteger nextIndex = currentIndex + 1;
    if (nextIndex < _fields.count) {
        UITextField *currentTF = _fields[currentIndex];
        [currentTF resignFirstResponder];
        
        UITextField *nextTF = _fields[nextIndex];
        [nextTF becomeFirstResponder];
    }

}
@end
