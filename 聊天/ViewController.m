//
//  ViewController.m
//  聊天
//
//  Created by tarena on 16/5/9.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "Message.h"
#import "MessageCell.h"
@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputviewBottomConstraint;
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *allMessages;
@property (nonatomic, assign) BOOL isReturn;

@end

@implementation ViewController
static NSString *const ID = @"messageCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
    [self scrollToTableViewLastRow];
}

-(void)openKeyBoard:(NSNotification *)notification
{
    NSInteger option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    self.inputviewBottomConstraint.constant = keyboardFrame.size.height;
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
    [self scrollToTableViewLastRow];
}

-(void)closeKeyBoard:(NSNotification *)notification
{
    if (self.isReturn) {
        return;
    }
    NSInteger option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    self.inputviewBottomConstraint.constant = 0;
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
    [self scrollToTableViewLastRow];
}

-(void)scrollToTableViewLastRow
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.allMessages.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
-(NSMutableArray *)allMessages
{
    if (!_allMessages) {
        Message *message = Message.new;
        message.content = @"hello";
        message.fromMe = YES;
        message.imageName = @"Icon";
    
    _allMessages = @[message, message,message,message,message, message,message,message,message, message,message,message,message, message,message,message].mutableCopy;
    }
    return _allMessages;
}
- (IBAction)sendMessage:(id)sender {
    self.isReturn = YES;
    Message *message = Message.alloc.init;
    message.content = self.inputField.text;
    message.fromMe = YES;
    message.imageName = @"Icon";
    
    [self.allMessages addObject:message];
    [self.tableView reloadData];
    self.inputField.text = @"";
    
}
- (IBAction)editingEnd:(id)sender {
    if (self.isReturn) {
        [self.inputField becomeFirstResponder];
    }
}


#pragma mark -datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allMessages.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Message *message = self.allMessages[indexPath.row];
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.message = message;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.isReturn = NO;
    [self.inputField resignFirstResponder];
}
@end
