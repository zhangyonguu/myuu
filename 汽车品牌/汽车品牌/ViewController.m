
//
//  ViewController.m
//  汽车品牌
//
//  Created by tarena on 16/3/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "TRCarGroup.h"
#import "TRCar.h"

@interface ViewController ()<UITableViewDataSource>
@property (nonatomic, strong)NSArray *carGroups;
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation ViewController

-(NSArray *)carGroups
{
    if (_carGroups  == nil) {
        _carGroups = [TRCarGroup carGroups];
    }
    return _carGroups;
}

-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
  //  NSLog(@"%@",self.carGroups);
    [self tableView];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark -数据源方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.carGroups.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TRCarGroup *group = self.carGroups[section];
    return group.cars.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    TRCarGroup *group = self.carGroups[indexPath.section];
    TRCar *car = group.cars[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:car.icon];
    cell.textLabel.text = car.name;
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    TRCarGroup *group = self.carGroups[section];
    return group.title;
}

//右侧索引列表
-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    //索引数组中的“内容”,跟分组无关，索引数组中的下表，对应的是分组的下标
    //return @[@"wahaha",@"hello"];
//    NSMutableArray *arrayM = [NSMutableArray array];
//    for (TRCarGroup *group in self.carGroups) {
//        [arrayM addObject:group.title];
//    }
//    return arrayM;
    //KVC是cocoa的大招，用来间接获取或者修改对象属性的方式
    
    //使用KVC在获取数值时，如果指定对象不包含keyPath的键名，会自动进入对象的内部查找
    //如果取值的对象是一个数组，同样返回一个数组
    NSArray *array = [self.carGroups valueForKeyPath:@"cars.name"];
    return [self.carGroups valueForKeyPath:@"title"];
}

@end
