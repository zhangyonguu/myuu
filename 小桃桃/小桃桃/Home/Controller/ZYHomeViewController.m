//
//  ZYHomeViewController.m
//  小桃桃
//
//  Created by tarena on 16/5/26.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZYHomeViewController.h"
#import "ZYMapViewController.h"
#import "ZYMetaDataTool.h"
#import "ZYCollectionViewCell.h"
#import "ZYMenuData.h"
#import "TRCityGroupTableViewController.h"
#import "ZYBaseNavController.h"
#import "ZYLocationManager.h"
@interface ZYHomeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSString *categoryName;
@property (nonatomic, strong) NSArray *menuDataArray;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIBarButtonItem *cityItem;
@property (nonatomic, copy) NSString *cityName;
@end
#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
static const CGFloat itemWidth = 60;
static const CGFloat interItemSpace = 10;
static const CGFloat topBottomInset = 15;
@implementation ZYHomeViewController

-(NSArray *)menuDataArray
{
    if (_menuDataArray == nil) {
        self.menuDataArray = [ZYMetaDataTool getAllMenuDatas];
    }
    return _menuDataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getUserCityName];
    [self setupItems];
    [self setupCollectionView];
}

-(void)viewWillAppear:(BOOL)animated
{
    NSString *cityName = [ZYMetaDataTool getSelectedCityName];
    self.cityItem.title = cityName;
    self.cityName = cityName;
    [self loadNewDeals];
}


-(void)getUserCityName
{
    ZYLocationManager *mgr = [[ZYLocationManager alloc] init];
    [mgr updateCityWithCompletionHandler:^(NSString *cityName, NSError *error) {
        if (!error) {
            self.cityName = cityName;
            [ZYMetaDataTool setSelectedCityName:cityName];
            [self loadNewDeals];
        }
        else
        {
            NSLog(@"定位失败:%@",error.userInfo);
        }
    }];
}


-(void)setupCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //坑：默认流水布局对应的item的大小为50X50; 需要重新把item的大小赋值为期望的大小
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, itemWidth * 2 + 2 * topBottomInset + interItemSpace) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZYCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"item"];
    
    //pageControl设置
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.collectionView.bounds.size.height, kSCREEN_WIDTH, 30)];
    _pageControl.numberOfPages = 2;
    _pageControl.pageIndicatorTintColor = [UIColor blackColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, self.collectionView.bounds.size.height + 30)];
    view.backgroundColor = [UIColor redColor];
    
    [view addSubview:self.collectionView];
    [view addSubview:self.pageControl];
    self.tableView.tableHeaderView = view;
}
-(void)setupItems
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_map"] style:UIBarButtonItemStyleDone target:self action:@selector(clickMapItem)];
    self.navigationItem.rightBarButtonItem = item;
    
    self.cityItem = [[UIBarButtonItem alloc] initWithTitle:@"位置" style:UIBarButtonItemStyleDone target:self action:@selector(clickCityItem)];
    self.navigationItem.leftBarButtonItem = self.cityItem;
}

-(void)clickCityItem
{
    TRCityGroupTableViewController *cityGroup = [[TRCityGroupTableViewController alloc] init];
    ZYBaseNavController *navi = [[ZYBaseNavController alloc] initWithRootViewController:cityGroup];
    [self presentViewController:navi animated:YES completion:nil];
}

-(void)clickMapItem
{
    ZYMapViewController *mapVC = [[ZYMapViewController alloc] init];
    [self.navigationController pushViewController:mapVC animated:YES];
}

-(void)settingRequestParams:(NSMutableDictionary *)params
{
    params[@"city"] = self.cityName;
    params[@"category"] = self.categoryName?self.categoryName:@"美食";
}

#pragma mark - scrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int currentPage = scrollView.contentOffset.x / scrollView.frame.size.width + 0.5;
    self.pageControl.currentPage = currentPage;
}

#pragma mark -collectionView

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.menuDataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZYCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    
    ZYMenuData *menuData = self.menuDataArray[indexPath.item];
    cell.cellLabel.text = menuData.title;
    cell.cellImageView.image = [UIImage imageNamed:menuData.image];
    cell.backgroundColor = [UIColor grayColor];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZYMenuData *menuData = self.menuDataArray[indexPath.item];
    
    self.categoryName = menuData.title;
    
    [self loadNewDeals];
}


#pragma mark -FlowLayout Delegate

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return interItemSpace;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return kSCREEN_WIDTH/4 - itemWidth;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat halfLineSpaceing = kSCREEN_WIDTH/8 - itemWidth/2;
    return UIEdgeInsetsMake(topBottomInset, halfLineSpaceing, topBottomInset, halfLineSpaceing);
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
