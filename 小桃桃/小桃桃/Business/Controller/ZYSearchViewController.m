//
//  ZYSearchViewController.m
//  小桃桃
//
//  Created by tarena on 16/5/26.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZYSearchViewController.h"
#import "ZYMetaDataTool.h"
@interface ZYSearchViewController ()<UISearchBarDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, copy) NSString *cityName;
@end

@implementation ZYSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //UISearchBar添加一个假的item(占位)
    self.cityName = [ZYMetaDataTool getSelectedCityName];
    UIBarButtonItem *fakeItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.rightBarButtonItem = fakeItem;
    
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"请输入商户名，地址或者商品名";
    self.navigationItem.titleView = _searchBar;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self loadNewDeals];
    [searchBar resignFirstResponder];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_searchBar resignFirstResponder];
}

-(void)settingRequestParams:(NSMutableDictionary *)params
{
    UISearchBar *searchBar = (UISearchBar *)self.navigationItem.titleView;
    params[@"city"] = self.cityName;
    if (searchBar.text.length) {
        params[@"keyword"] = searchBar.text;
    }
    else
    {
        params[@"keyword"] = @"ktv";
    }
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
