//
//  KRMyMessageViewController.m
//  酷跑
//
//  Created by tarena on 16/6/15.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "KRMyMessageViewController.h"
#import "KRXMPPTool.h"
#import "KRUserInfo.h"
#import "UIImageView+roundImage.h"
#import "KRMyMessageCell.h"
#import "KRChatViewController.h"
@interface KRMyMessageViewController ()
/**  用来存放每个好友最近消息的数组 */
@property (nonatomic,strong) NSArray *mostRecentMsgs;
@end

@implementation KRMyMessageViewController
- (IBAction)backBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
/** 写一个方法 使用coredata来读取 最后的消息 
    并显示 */
- (void)loadMostRecentMsg {
    // 获取上下文
    NSManagedObjectContext *context = [[KRXMPPTool sharedKRXMPPTool].xmppMsgArchStore mainThreadManagedObjectContext];
    // 关联实体
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"XMPPMessageArchiving_Contact_CoreDataObject"];
    // 设置谓词(过滤)
    NSPredicate *pre  = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@",[KRUserInfo sharedKRUserInfo].jidStr];
    request.predicate = pre;
    // 设置排序
    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"mostRecentMessageTimestamp" ascending:NO];
    request.sortDescriptors = @[sortDesc];
    // 获取数据
    NSError *error = nil;
    self.mostRecentMsgs = [context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadMostRecentMsg];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.mostRecentMsgs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KRMyMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myMsgCell" forIndexPath:indexPath];
    // 获取最后的消息对应的模型对象
 XMPPMessageArchiving_Contact_CoreDataObject *contactObj = self.mostRecentMsgs[indexPath.row];
     // 好友对应的头像
    NSData *photo = [[KRXMPPTool sharedKRXMPPTool].xmppvCardAvatar photoDataForJID:contactObj.bareJid];
    if (photo) {
        cell.friendHeadImageView.image = [UIImage imageWithData:photo];
    }else{
        cell.friendHeadImageView.image = [UIImage imageNamed:@"KR"];
    }
    [cell.friendHeadImageView setRoundLayer];
    cell.friendNameLabel.text = [contactObj.bareJidStr substringToIndex:[contactObj.bareJidStr rangeOfString:@"@"].location];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"MM-dd hh:mm:ss";
    cell.msgTimeLabel.text = [dateFormatter stringFromDate:contactObj.mostRecentMessageTimestamp];
    if ([contactObj.mostRecentMessageBody hasPrefix:@"image:"]) {
        cell.msgContentLabel.text = @"图片";
    }else{
        cell.msgContentLabel.text = [contactObj.mostRecentMessageBody substringFromIndex:5];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 XMPPMessageArchiving_Contact_CoreDataObject *contact =  self.mostRecentMsgs[indexPath.row];
    [self performSegueWithIdentifier:@"chatSegue2" sender:contact.bareJid];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    id  desctVc = segue.destinationViewController;
    if ([desctVc isKindOfClass:[KRChatViewController class]]) {
        KRChatViewController *chatVc = desctVc;
        chatVc.fJid = sender;
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
