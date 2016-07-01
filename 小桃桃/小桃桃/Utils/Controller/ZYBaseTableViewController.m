//
//  ZYBaseTableViewController.m
//  小桃桃
//
//  Created by tarena on 16/5/26.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZYBaseTableViewController.h"
#import "DPAPI.h"
#import "ZYMetaDataTool.h"
#import "ZYDeal.h"
#import "MJRefresh.h"
#import "ZYDealTableViewCell.h"
#import "ZYDetailViewController.h"
#import "ZYBaseNavController.h"
#import "MBProgressHUD.h"
@interface ZYBaseTableViewController ()<UITableViewDataSource, UITableViewDelegate, DPRequestDelegate>
@property (nonatomic, strong) NSMutableArray *dealsArrayM;

@property (nonatomic, assign) int currentPage;

@property (nonatomic, strong) DPRequest *latestRequest;

@end

@implementation ZYBaseTableViewController
-(NSMutableArray *)dealsArrayM
{
    if (_dealsArrayM == nil) {
        self.dealsArrayM = [[NSMutableArray alloc] init];
    }
    return _dealsArrayM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
    UINib *nib = [UINib nibWithNibName:@"ZYDealTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"reuse"];
    [self addRefreshControl];
//    [self sendRequestToServer];

}

//-(void)settingRequestParams:(NSMutableDictionary *)params
//{
//    
//}

-(void)addRefreshControl
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDeals)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDeals)];
}

-(void)loadNewDeals
{
    self.currentPage = 1;
    [self sendRequestToServer];
}

-(void)loadMoreDeals
{
    self.currentPage++;
    [self sendRequestToServer];
}

- (void)setUpTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];

    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    self.tableView.rowHeight = 100;

    [self.view addSubview:self.tableView];
}


#pragma mark -- 和网络相关的方法
- (void)sendRequestToServer {
    DPAPI *api = [DPAPI new];
    //2.创建可变字典，设置发送请求的参数
    /*首页控制器参数: city+category
     商家控制器参数：city+category+region+sort
     搜索控制器参数：city+keyword
     */
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionary];
    [self settingRequestParams:mutableDic];
    mutableDic[@"page"] = @(self.currentPage);
    //3.发送请求
   self.latestRequest = [api requestWithURL:@"v1/deal/find_deals" params:mutableDic delegate:self];
}
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result {
    if (request != self.latestRequest) {
        return;//如果不是最新的request直接返回
    }
    NSArray *array = [ZYMetaDataTool parseDealsResult:result];
    if (self.currentPage == 1) {
        [self.dealsArrayM removeAllObjects];
    }
    [self.dealsArrayM addObjectsFromArray:array];
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
- (void)request:(DPRequest *)request didFailWithError:(NSError *)error {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"网络繁忙，请稍后再试";
    [hud hide:YES afterDelay:3];
    [hud removeFromSuperview];
    hud.margin = 50;
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UITableView相关方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dealsArrayM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZYDealTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse" forIndexPath:indexPath];
     ZYDeal *deal = self.dealsArrayM[indexPath.row];
    cell.deal = deal;
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYDeal *deal = self.dealsArrayM[indexPath.row];
    ZYDetailViewController *detail = [[ZYDetailViewController alloc] initWithDealUrl:deal.deal_h5_url];
    ZYBaseNavController *navi = [[ZYBaseNavController alloc] initWithRootViewController:detail];
    [self presentViewController:navi animated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
