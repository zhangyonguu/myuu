//
//  ViewController.m
//  表格的修改
//
//  Created by tarena on 16/3/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController
-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

-(NSMutableArray *)dataList
{
    if (_dataList == nil) {
        _dataList = [NSMutableArray arrayWithObjects:@"wade", @"curry", @"kobe", @"iverson",@"crawford",@"wade", @"curry", @"kobe", @"iverson",@"crawford",@"wade", @"curry", @"kobe", @"iverson",@"crawford", nil];
    }
    return _dataList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
    //一旦editing == YES就默认开启删除模式
    self.tableView.editing = YES;
    // Do any additional setup after loading the view, typically from a nib.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = self.dataList[indexPath.row];
    
    return cell;
}

//只要实现了此方法，就能支持手势拖拽删除了，删除方法需要自己实现
/** UITableViewCellEditingStyleNone,
 UITableViewCellEditingStyleDelete,    删除
 UITableViewCellEditingStyleInsert     添加
 */
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSLog(@"deleting");
        //MVC => 数据保存在模型中
        //1.删除self.dataList中的indexPath对应的数据
        [self.dataList removeObjectAtIndex:indexPath.row];
        NSLog(@"%@",self.dataList);
        //2.refresh tableView  重新加载所有数据
//        [self.tableView reloadData];
        //让表格控件动画删除指定的行（还是先要删除dataList中的数据）
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    }
    else if(editingStyle == UITableViewCellEditingStyleInsert)
    {
        NSLog(@"要添加数据");
        //1.向数组添加数据
        [self.dataList insertObject:@"插入数据" atIndex:indexPath.row + 1];
        //2.刷新表格
      //  [self.tableView reloadData];
        NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
        [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationMiddle];
    }
   
    
}
//只要实现此方法，即可显示拖动控件
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    //NSLog(@"%@",self.dataList);
    //界面数据UITableView已经完成了
    //调整数据即可
//    [self.dataList exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];//简单交换是不对的
    //1.将源从数字取出
    id source = self.dataList[sourceIndexPath.row];
   // [self.dataList removeObject:source];//不能用这种方法，因为会将后面的相同内容也一并删除
    [self.dataList removeObjectAtIndex:sourceIndexPath.row];
    NSLog(@"%lu---%lu",sourceIndexPath.row,destinationIndexPath.row);
    NSLog(@"%@",self.dataList);
    [self.dataList insertObject:source atIndex:destinationIndexPath.row];
     NSLog(@"%@",self.dataList);
}
#pragma mark -代理方法
//返回编辑样式，如果没有实现此方法，默认都是删除
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(indexPath.row % 2)
//    {
//        return UITableViewCellEditingStyleDelete;
//    }else{
//    return UITableViewCellEditingStyleInsert;
//    }
    return UITableViewCellEditingStyleInsert;
}


@end
