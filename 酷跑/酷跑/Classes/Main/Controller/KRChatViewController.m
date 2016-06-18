//
//  KRChatViewController.m
//  酷跑
//
//  Created by tarena on 16/6/13.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "KRChatViewController.h"
#import "KRXMPPTool.h"
#import "KRUserInfo.h"
#import "KROtherMsgCell.h"
#import "KRMeMsgCell.h"
@interface KRChatViewController ()<NSFetchedResultsControllerDelegate,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
/** 显示聊天信息的 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 输入文本信息 */
@property (weak, nonatomic) IBOutlet UITextField *textMsgField;
/** 发送图片信息的按钮被点击 */
- (IBAction)imageBtnClick:(id)sender;
/** 输入信息的view 距离底部的高度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightForBottom;
/** 发送文本消息 */
- (IBAction)sendTextMsg:(id)sender;
/** 结果集控制器 */
@property (nonatomic, strong) NSFetchedResultsController *fetchController;
@end

@implementation KRChatViewController
/** 如何读取聊天消息 使用coredata 一共五步 */
- (void)loadMsg{
    // 获取上下文
    NSManagedObjectContext *context = [KRXMPPTool sharedKRXMPPTool].xmppMsgArchStore.mainThreadManagedObjectContext;
    // 关联实体
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"XMPPMessageArchiving_Message_CoreDataObject"];
   // 设置谓词(过滤)
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@ and bareJidStr = %@",[KRUserInfo sharedKRUserInfo].jidStr,[self.fJid bare]];
    request.predicate = pre;
    // 设置排序
    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
    request.sortDescriptors = @[sortDesc];
    // 获取数据
    self.fetchController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    self.fetchController.delegate = self;
    NSError *error = nil;
    [self.fetchController performFetch:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
     NSLog(@"fJid=%@",self.fJid);
    // 设置代理 和 数据源
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    [self loadMsg];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(openKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(closeKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)openKeyBoard:(NSNotification*) notification{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval durations = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions options = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    self.heightForBottom.constant = keyboardFrame.size.height;
    [UIView animateWithDuration:durations delay:0 options:options animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}
- (void)closeKeyBoard:(NSNotification*) notification{
    NSTimeInterval durations = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions options = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    self.heightForBottom.constant = 0;
    [UIView animateWithDuration:durations delay:0 options:options animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
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

- (IBAction)imageBtnClick:(id)sender {
    UIImagePickerController *pickerControl = [UIImagePickerController new];
    pickerControl.delegate = self;
    pickerControl.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:pickerControl animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    NSLog(@"image size = %ld",UIImagePNGRepresentation(image).length);
    UIImage *newImage = [self thumbnaiWithImage:image size:CGSizeMake(100, 100)];
    NSLog(@"newImage size = %ld",UIImagePNGRepresentation(newImage).length);
    // 缩略图  高清  超清 XML
    NSData *sendData =   UIImageJPEGRepresentation(newImage, 0.1);
    NSLog(@"sendData size = %ld",sendData.length);
    [self sendImageMsg:sendData];
    [self dismissViewControllerAnimated:YES completion:nil];
}
/** 发送图片消息的方法 */
- (void) sendImageMsg:(NSData*) sendData
{
    // 把二进制数据变成base64对应的字符串
    NSString *base64Str = [sendData base64EncodedStringWithOptions:0];
    XMPPMessage *msg = [XMPPMessage messageWithType:@"chat" to:self.fJid];
    [msg addBody:[NSString stringWithFormat:@"image:%@",base64Str]];
    [[KRXMPPTool sharedKRXMPPTool].xmppStream sendElement:msg];
}
/** 压缩图片 */
- (UIImage*) thumbnaiWithImage:(UIImage*)image size:(CGSize) size {
    UIImage  *newImage = nil;
    if (image != nil) {
        UIGraphicsBeginImageContext(size);
        [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newImage;
}

// 发送文本消息
- (IBAction)sendTextMsg:(id)sender {
    // 构建一个消息对象
    XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:self.fJid];
    // 赋值聊天内容
    [message addBody:[@"text:" stringByAppendingString:self.textMsgField.text]];
    // 发送消息
    [[KRXMPPTool sharedKRXMPPTool].xmppStream sendElement:message];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.fetchController.fetchedObjects.count;
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 取到这一行对应的消息模型对象
    XMPPMessageArchiving_Message_CoreDataObject  *msgObj = self.fetchController.fetchedObjects[indexPath.row];
    
    if (msgObj.isOutgoing) {
        // 获取cell
        KRMeMsgCell *meCell = [self.tableView dequeueReusableCellWithIdentifier:@"meMsgCell" forIndexPath:indexPath];
        if ([KRXMPPTool sharedKRXMPPTool].xmppvCard.myvCardTemp.photo) {
            meCell.headImageView.image = [UIImage imageWithData:[KRXMPPTool sharedKRXMPPTool].xmppvCard.myvCardTemp.photo];
        }else{
            meCell.headImageView.image = [UIImage imageNamed:@"微信"];
        }
        [meCell.headImageView  setRoundLayer];
        meCell.userNameLabel.text = [KRUserInfo sharedKRUserInfo].userName;
        meCell.msgTimeLabel.text = @"2016-06-14";
//        if ([[otherCell.msgContentLabel.subviews lastObject] isKindOfClass:[UIImageView class]]) {
//            [[otherCell.msgContentLabel.subviews lastObject]removeFromSuperview];
//        }
        [[meCell.msgContentLabel viewWithTag:9527]removeFromSuperview];
        if ([msgObj.body hasPrefix:@"image:"]) {
            // 获取base64字符串
            NSString *base64Str = [msgObj.body substringFromIndex:6];
            // 把base64字符串 变成二进制
            NSData *imageData = [[NSData alloc]initWithBase64EncodedString:base64Str options:0];
            // 使用UILabel的富文本的方式
            NSTextAttachment *attachement = [NSTextAttachment new];
            attachement.bounds = CGRectMake(0, 0, 105, 110);
            NSAttributedString *attriStr = [NSAttributedString attributedStringWithAttachment:attachement];
            meCell.msgContentLabel.attributedText = attriStr;
            // 构建一个UIImageView
            UIImageView  *imageView = [[UIImageView alloc]initWithImage:[UIImage imageWithData:imageData]];
            imageView.tag = 9527;
            [meCell.msgContentLabel addSubview:imageView];
            
        }else if ([msgObj.body hasPrefix:@"text:"]){
            meCell.msgContentLabel.text = [msgObj.body substringFromIndex:5];
        }else{
            meCell.msgContentLabel.text = msgObj.body;
        }
        return  meCell;
    }else{
        // 获取cell
        KROtherMsgCell *otherCell = [self.tableView dequeueReusableCellWithIdentifier:@"otherMsgCell" forIndexPath:indexPath];
        NSData *photo = [[KRXMPPTool sharedKRXMPPTool].xmppvCardAvatar photoDataForJID:self.fJid];
        if (photo) {
            otherCell.headImageView.image = [UIImage imageWithData:photo];
        }else{
            otherCell.headImageView.image = [UIImage imageNamed:@"KR"];
        }
        [otherCell.headImageView  setRoundLayer];
        otherCell.friendNameLabel.text = msgObj.bareJidStr;
        otherCell.msgTimeLabel.text = @"2016-06-14";
        //        if ([[otherCell.msgContentLabel.subviews lastObject] isKindOfClass:[UIImageView class]]) {
        //            [[otherCell.msgContentLabel.subviews lastObject]removeFromSuperview];
        //        }
        [[otherCell.msgContentLabel viewWithTag:9527]removeFromSuperview];
        if ([msgObj.body hasPrefix:@"image:"]) {
            // 获取base64字符串
            NSString *base64Str = [msgObj.body substringFromIndex:6];
            // 把base64字符串 变成二进制
            NSData *imageData = [[NSData alloc]initWithBase64EncodedString:base64Str options:0];
            // 使用UILabel的富文本的方式
            NSTextAttachment *attachement = [NSTextAttachment new];
            attachement.bounds = CGRectMake(0, 0, 105, 110);
            NSAttributedString *attriStr = [NSAttributedString attributedStringWithAttachment:attachement];
            otherCell.msgContentLabel.attributedText = attriStr;
            // 构建一个UIImageView
            UIImageView  *imageView = [[UIImageView alloc]initWithImage:[UIImage imageWithData:imageData]];
            imageView.tag = 9527;
            [otherCell.msgContentLabel addSubview:imageView];
            
        }else if ([msgObj.body hasPrefix:@"text:"]){
            otherCell.msgContentLabel.text = [msgObj.body substringFromIndex:5];
        }else{
            otherCell.msgContentLabel.text = msgObj.body;
        }
        return  otherCell;
    }
}
/** 数据发生改变 刷新 */
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView reloadData];
}
@end








