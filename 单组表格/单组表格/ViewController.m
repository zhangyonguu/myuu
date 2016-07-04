//
//  ViewController.m
//  单组表格
//
//  Created by tarena on 16/3/26.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "TRHero.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSArray *heros;
@end

@implementation ViewController
-(NSArray *)heros
{
    if (_heros == nil) {
        _heros = [TRHero heros];
    }
    return _heros;
}
-(UITableView *)tableView
{
    if (_tableView == nil) {
        //style是readonly，创建时必须指定style
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
   self.tableView.rowHeight = 180;
    
    //分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor colorWithRed:255.0 green:0 blue:255.0 alpha:1.0];
    
    //headView,放在tableView最顶部视图，通常用来放图片轮播器
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 130)];
    head.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    self.tableView.tableHeaderView = head;
    
    //footerView,通常做上拉刷新
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0,0,320, 44)];
    footer.backgroundColor = [UIColor redColor];
    self.tableView.tableFooterView = footer;
    

}





#pragma mark -数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"每个分组的数据总数:%lu",self.heros.count);
    return self.heros.count;
}
/** UITableViewCellStyleDefault,	默认类型 标题 + 可选图像
    UITableViewCellStyleValue1,		 标题 + 图像 + 明细（明细在标题右）
    UITableViewCellStyleValue2,     不显示图像，标题 + 明细
    UITableViewCellStyleSubtitle     图像 + 标题 + 明细（明细在标题下）
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"表格行明细:%lu",indexPath.row);
    //只分配一次，节省分配的开销
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        NSLog(@"实例化单元格");
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
      //设置共有属性
        UISwitch *switcher = [[UISwitch alloc] init];
        [switcher addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = switcher;
        
        //背景颜色会影响到未选中的表格中的标签背景
       // cell.backgroundColor = [UIColor blueColor];
        
//        UIView *bgView = [[UIView alloc] init];
//        bgView.backgroundColor = [UIColor yellowColor];
//        cell.backgroundView = bgView;
        
      //  cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_01"]];
        //cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_02"]];
    }
    
    //代码运行至此一定有了cell
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    TRHero *hero = self.heros[indexPath.row];
    cell.textLabel.text = hero.name;
    cell.imageView.image = [UIImage imageNamed:hero.icon];
    cell.detailTextLabel.text = hero.intro;
    
    //设置右边的箭头
    //1>DisclosureIndicator箭头,提醒用户当前行是可以点击的,会跳到新的页面
    //2>Checkmark对号，提示用户改行数据设置完毕，使用较少
    //3>DetailButton 按钮，通常点击按钮可做独立的操作,点击按钮不会选中行
    //DetailDisclosureButton 按钮+箭头 各自操作
  //  cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    //指定右侧自定义视图
    /**自行添加监听方法，通常用在自定义cell，不要写在视图控制器中！！*/
   
    return cell;
}

-(void)switchChanged:(UISwitch *)sender
{
    NSLog(@"%s  %@",__func__, sender);
}
#pragma mark -代理方法

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"行高:%lu",indexPath.row);
//    // return 44;//代理方法的优先级比属性rowHeight高，应用场景：各行高度不一致
//    return (indexPath.row % 2 ? 60 : 40);
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s    %@",__func__,indexPath);
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s    %@",__func__,indexPath);
}

//accessoryType
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
   NSLog(@"%s    %@",__func__,indexPath);
}

@end
