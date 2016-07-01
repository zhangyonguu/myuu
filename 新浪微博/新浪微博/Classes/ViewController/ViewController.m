//
//  ViewController.m
//  新浪微博
//
//  Created by tarena on 16/3/30.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "TRStatus.h"
#import "TRStatusCell.h"
#import "TRStatusFrame.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray *statusFrames;
@end

@implementation ViewController
static NSString *ID = @"cell";
-(NSArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [TRStatusFrame statusFrames];
    }
   
    return _statusFrames;
}

#pragma mark - 数据源方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%s",__func__);
    return self.statusFrames.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSLog(@"%s-----%ld",__func__,indexPath.row);
//    TRStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    
//    if (cell == nil) {
//        cell = [[TRStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//        
//    }
    TRStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    TRStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    
    cell.statusFrame = statusFrame;
        
    return cell;
}

#pragma mark - 代理方法
//计算单元格行高,计算行高的方法，会在加载表格数据是，有多少行计算多少次
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     问题：此方法执行时，cell还未被实例化
     但是：行高计算是在实例化cell时，通过设置status属性计算的=>有了status模型就可以知道行高
     */
    NSLog(@"%s-----%ld",__func__,indexPath.row);
    
    TRStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    
    return statusFrame.cellHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[TRStatusCell class] forCellReuseIdentifier:ID];
    
  //  self.tableView.rowHeight = 200;
    // Do any additional setup after loading the view, typically from a nib.
}


@end
