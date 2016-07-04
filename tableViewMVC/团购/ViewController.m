//
//  ViewController.m
//  团购
//
//  Created by tarena on 16/3/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "TRTg.h"
#import "TRTgCell.h"
#import "TRTgFooterView.h"

@interface ViewController ()<TRTgFooterViewDelegate>
@property (nonatomic, strong) NSMutableArray *tgs;

@end

@implementation ViewController
-(NSMutableArray *)tgs
{
    if (_tgs == nil) {
        _tgs = [TRTg tgs];
    }
    return _tgs;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%g, %g",self.view.bounds.size.height,self.view.bounds.size.width);
    
    self.tableView.rowHeight = 100;
    //让tableView让开视图
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    //footerView,footerView的宽度和表格整体宽度一致，只需指定高度即可
    
   // self.tableView.tableFooterView = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
//    view.backgroundColor = [UIColor redColor];
//    self.tableView.tableFooterView = view;
    TRTgFooterView *footer = [TRTgFooterView footerView];
    NSLog(@"%g-----------%g-------------",footer.frame.size.height,footer.frame.size.width);
    footer.delegate = self;
    //tableFooterView强引用了footer,所以tableFooterView要做footer的delegate，必须是弱引用
    self.tableView.tableFooterView = footer;
    
    self.tableView.tableHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"TRTgHeadView" owner:nil options:nil] lastObject];

}
#pragma mark - footerView的代理方法

#if 1
-(void)tgFooterViewDidDownloadButtonClicked:(TRTgFooterView *)footerView
{
    NSLog(@"努力加载数据中.......");
    //向数组添加元素，模拟网络加载完成后的效果
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    NSDictionary *dict = @{@"title":@"哈哈薯片",@"icon":@"ad_00",@"price":@"10.2",@"buyCount":@"20"};
    TRTg *tg = [TRTg tgWithDict:dict];
    
    [self.tgs addObject:tg];
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.tgs.count - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationMiddle];
        [footerView endRefresh];
     });
}

#endif
//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//}
#pragma mark - 数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tgs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    //1.可重用标识符
//    NSString *ID = @"cell";
//    //2.查询缓存池
//    TRTgCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    //3.如果没有查询到，创建
//    if (cell == nil) {
//        NSLog(@"加载xib");
//        //从xib加载自定义视图
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"TRTgCell" owner:nil options:nil] lastObject];
//    }
    //1.创建cell
    TRTgCell *cell = [TRTgCell cellWithTableView:tableView];
    //2.通过数据模型，设置cell内容,可以让视图控制器不需要了解cell内部的实现细节
    cell.tg = self.tgs[indexPath.row];
//    cell.textLabel.text = tg.title;
//    cell.imageView.image = [UIImage imageNamed:tg.icon];
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"¥%@      已有%@人购买",tg.price, tg.buyCount];

    
    return cell;
}
@end
