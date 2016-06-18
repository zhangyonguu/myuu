//
//  KRFriendListViewController.m
//  酷跑
//
//  Created by tarena on 16/6/13.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "KRFriendListViewController.h"
#import "KRXMPPTool.h"
#import "KRUserInfo.h"
#import "KRFriendCell.h"
#import "KRChatViewController.h"
@interface KRFriendListViewController ()<NSFetchedResultsControllerDelegate>
// 存放好友列表的数据
@property (nonatomic,strong) NSArray *friends;
// 使用结果集控制器来管理数据
@property (nonatomic,strong) NSFetchedResultsController *fetchController;
@end

@implementation KRFriendListViewController
- (IBAction)backBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
/** 加载好友的数据 */
- (void)loadFriends {
   // 获取上下文
    NSManagedObjectContext *context = [[KRXMPPTool sharedKRXMPPTool].xmppRosterStore mainThreadManagedObjectContext];
   // 关联实体
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"XMPPUserCoreDataStorageObject"];
   // 设置谓词(设置过滤)
    NSString *jidStr = [NSString stringWithFormat:@"%@@%@",[KRUserInfo sharedKRUserInfo].userName,KRXMPPDOMAIN];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@",jidStr];
    request.predicate = pre;
   // 设置排序
    NSSortDescriptor *sortDes = [NSSortDescriptor sortDescriptorWithKey:@"displayName" ascending:YES];
    request.sortDescriptors = @[sortDes];
   // 获取数据
    NSError *error = nil;
    self.friends = [context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
}
/** 加载好友的数据第二种方式 */
- (void)loadFriends2 {
    // 获取上下文
    NSManagedObjectContext *context = [[KRXMPPTool sharedKRXMPPTool].xmppRosterStore mainThreadManagedObjectContext];
    // 关联实体
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"XMPPUserCoreDataStorageObject"];
    // 设置谓词(设置过滤)
    NSString *jidStr = [NSString stringWithFormat:@"%@@%@",[KRUserInfo sharedKRUserInfo].userName,KRXMPPDOMAIN];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@",jidStr];
    request.predicate = pre;
    // 设置排序
    NSSortDescriptor *sortDes = [NSSortDescriptor sortDescriptorWithKey:@"displayName" ascending:YES];
    request.sortDescriptors = @[sortDes];
    // 获取数据
    NSError *error = nil;
    self.fetchController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    // 设置代理
    self.fetchController.delegate = self;
    [self.fetchController performFetch:&error];
    if (error) {
        NSLog(@"%@",error);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // [self loadFriends];
    // 新的加载好友的方式
    [self loadFriends2];
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
    // return  self.friends.count;
    return  self.fetchController.fetchedObjects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KRFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friendCell" forIndexPath:indexPath];
    // Configure the cell...
    // 取出模型对象
//    XMPPUserCoreDataStorageObject *friend = self.friends[indexPath.row];
    XMPPUserCoreDataStorageObject *friend = self.fetchController.fetchedObjects[indexPath.row];
    // 使用头像模块 获取头像
    NSData *headImageData = [[KRXMPPTool sharedKRXMPPTool].xmppvCardAvatar photoDataForJID:friend.jid];
    if (headImageData) {
        cell.headImageView.image = [UIImage imageWithData:headImageData];
    }else{
        cell.headImageView.image = [UIImage imageNamed:@"KR"];
    }
    cell.friendNameLabel.text = friend.displayName;
    switch (friend.sectionNum.intValue) {
        case 0:
            cell.friendStatusLabel.text = @"在线";
            break;
        case 1:
            cell.friendStatusLabel.text = @"离开";
            break;
        case 2:
            cell.friendStatusLabel.text = @"离线";
            break;
        default:
            break;
    }
    return cell;
}
/** 向左滑动删除好友 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 取出这一行对应的模型对象
        XMPPUserCoreDataStorageObject *friend = self.fetchController.fetchedObjects[indexPath.row];
        [[KRXMPPTool sharedKRXMPPTool].xmppRoster removeUser:friend.jid];
    }
}

#pragma mark NSFetchedResultsControllerDelegate
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView  reloadData];
}
/** 
    选中一行 跳转到聊天界面  跳转时传入对应好友的jid
*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 取出这一行对应的好友模型对象
    XMPPUserCoreDataStorageObject *friend = self.fetchController.fetchedObjects[indexPath.row];
    [self performSegueWithIdentifier:@"chatSegue" sender:friend.jid];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    id destVc = segue.destinationViewController;
    if ([destVc isKindOfClass:[KRChatViewController class]]) {
        KRChatViewController *chatVc = destVc;
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
