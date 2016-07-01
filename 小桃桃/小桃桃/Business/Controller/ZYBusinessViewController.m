//
//  ZYBusinessViewController.m
//  小桃桃
//
//  Created by tarena on 16/5/26.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZYBusinessViewController.h"
#import "ZYBusinessHeaderView.h"
#import "UIView+Extension.h"
#import "ZYSortViewController.h"
#import "ZYRegionViewController.h"
#import "ZYCategoryViewController.h"
#import "ZYSort.h"
#import "ZYRegion.h"
#import "ZYSearchViewController.h"
#import "ZYMetaDataTool.h"
@interface ZYBusinessViewController ()<UIPopoverPresentationControllerDelegate>

@property (nonatomic, strong) ZYBusinessHeaderView *headerView;
@property (nonatomic, strong) ZYSortViewController *sortViewController;
@property (nonatomic, strong) ZYRegionViewController *regionViewController;
@property (nonatomic, strong) ZYCategoryViewController *categoryViewController;
@property (nonatomic, strong) NSNumber *selectedSort;

@property (nonatomic, copy) NSString *regionName;
@property (nonatomic, copy) NSString *subregionName;

@end

@implementation ZYBusinessViewController
//在整个程序生命周期里只有一个此对象
-(ZYSortViewController *)sortViewController
{
    if (_sortViewController == nil) {
        self.sortViewController = [[ZYSortViewController alloc] init];
    }
    return _sortViewController;
}

-(ZYRegionViewController *)regionViewController
{
    if (_regionViewController == nil) {
        self.regionViewController = [[ZYRegionViewController alloc] init];
    }
    return _regionViewController;
}

-(ZYCategoryViewController *)categoryViewController
{
    if (_categoryViewController == nil) {
        self.categoryViewController = [[ZYCategoryViewController alloc] init];
    }
    return _categoryViewController;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.y = 50;
    [self setupHeaderView];
    [self addTargetsForButtons];
    
    [self setupTwoItems];
    
    [self listenNotifications];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self loadNewDeals];
}

-(void)setupTwoItems
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_search"] style:UIBarButtonItemStyleDone target:self action:@selector(searchItemClicked:)];
    
    self.navigationItem.rightBarButtonItem = item;
}

-(void)searchItemClicked:(UIBarButtonItem *)item
{
    ZYSearchViewController *searchVC = [[ZYSearchViewController alloc] init];

    [self.navigationController pushViewController:searchVC animated:YES];
}

-(void)listenNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sortDidChange:) name:@"SortDidChange" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(regionDidChange:) name:@"RegionDidChange" object:nil];
}

-(void)regionDidChange:(NSNotification *)noti
{
    ZYRegion *region = noti.userInfo[@"region"];
    NSString *subregion = noti.userInfo[@"subregion"];
    if ([region.name isEqualToString:@"全部"]) {
        self.regionName = nil;
    }
    else
    {
    self.regionName = region.name;
        if ([subregion isEqualToString:@"全部"]) {
            self.subregionName = nil;
        }
        else
        {
            self.subregionName = subregion;
        }
    }
    [self loadNewDeals];
}

-(void)sortDidChange:(NSNotification *)noti
{
    ZYSort *sort = noti.userInfo[@"sort"];
    self.selectedSort = sort.value;
    [self loadNewDeals];
}

-(void)addTargetsForButtons
{
    [self.headerView.sortButton addTarget:self action:@selector(clickedSortButton) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView.categoryButton addTarget:self action:@selector(clickedCategoryButton) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView.regionButton addTarget:self action:@selector(clickedRegionButton) forControlEvents:UIControlEventTouchUpInside];
}

-(void)clickedSortButton
{
    self.sortViewController.modalPresentationStyle = UIModalPresentationPopover;
    self.sortViewController.popoverPresentationController.sourceView = self.headerView.sortButton;
//    self.sortViewController.popoverPresentationController.sourceRect = CGRectMake(self.headerView.sortButton.width * 0.5, self.headerView.sortButton.height, 0, 0);
    //设置sourceRect两种方式，1.设置x,y(x,y) 2.设置w,h（w*0.5,h）
    self.sortViewController.popoverPresentationController.sourceRect = self.headerView.sortButton.bounds;
    self.sortViewController.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    self.sortViewController.popoverPresentationController.delegate = self;
    [self presentViewController:self.sortViewController animated:YES completion:nil];
}

-(void)clickedCategoryButton
{
    self.categoryViewController.modalPresentationStyle = UIModalPresentationPopover;
    self.categoryViewController.popoverPresentationController.sourceView = self.headerView.categoryButton;
    
    self.categoryViewController.popoverPresentationController.sourceRect = self.headerView.categoryButton.bounds;
    
    self.categoryViewController.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    self.categoryViewController.popoverPresentationController.delegate = self;
    [self presentViewController:self.categoryViewController animated:YES completion:nil];
}

-(void)clickedRegionButton
{
    self.regionViewController.modalPresentationStyle = UIModalPresentationPopover;
    self.regionViewController.popoverPresentationController.sourceView = self.headerView.regionButton;

    self.regionViewController.popoverPresentationController.sourceRect = self.headerView.regionButton.bounds;
    
    self.regionViewController.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    self.regionViewController.popoverPresentationController.delegate = self;
    [self presentViewController:self.regionViewController animated:YES completion:nil];

}

-(void)setupHeaderView
{
    self.headerView = [[NSBundle mainBundle] loadNibNamed:@"ZYBusinessHeaderView" owner:nil options:nil].firstObject;
    _headerView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 50);
    [self.view addSubview:_headerView];
    
}

-(void)settingRequestParams:(NSMutableDictionary *)params
{
    params[@"city"] = [ZYMetaDataTool getSelectedCityName];
    params[@"category"] = @"美食";
//    params[@"region"] = @"龙岗区";
    if (self.regionName) {
        if (self.subregionName) {
            params[@"region"] = self.subregionName;
        }
        else
        {
            params[@"region"] = self.regionName;
        }
    }
    if (_selectedSort) {
        params[@"sort"] = self.selectedSort;
    }}
#pragma mark -UIPopoverPresentationControllerDelegate
-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}
@end
