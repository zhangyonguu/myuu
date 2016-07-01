//
//  ZYCategoryViewController.m
//  小桃桃
//
//  Created by tarena on 16/5/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZYCategoryViewController.h"
#import "ZYMetaDataView.h"
#import "ZYMetaDataTool.h"
#import "ZYCategory.h"
#import "ZYTableViewCell.h"

@interface ZYCategoryViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *categoryArray;
@property (nonatomic, strong) ZYMetaDataView *metaDataView;

@end

@implementation ZYCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _categoryArray = [ZYMetaDataTool getAllCategories];
    [self addMetaDataView];
}

-(void)addMetaDataView
{
    self.metaDataView = [[NSBundle mainBundle] loadNibNamed:@"ZYMetaDataView" owner:nil options:nil].lastObject;
    _metaDataView.frame = self.view.bounds;
    NSLog(@"%@",NSStringFromCGRect(self.view.bounds));
    _metaDataView.mainTableView.dataSource = self;
    _metaDataView.mainTableView.delegate = self;
    _metaDataView.subTableView.delegate = self;
    _metaDataView.subTableView.dataSource = self;
    [self.view addSubview:_metaDataView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -delegate, dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _metaDataView.mainTableView) {
        return _categoryArray.count;
    }
    else
    {
        ZYCategory *category = _categoryArray[[_metaDataView.mainTableView indexPathForSelectedRow].row];
        return category.subcategories.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _metaDataView.mainTableView) {
        ZYTableViewCell *cell = [ZYTableViewCell cellWithTableView:tableView andNormalImageName:@"bg_dropdown_leftpart" andSelectedImageName:@"bg_dropdown_left_selected"];
        ZYCategory *category = _categoryArray[indexPath.row];
        cell.textLabel.text = category.name;
        cell.imageView.image = [UIImage imageNamed:category.small_icon];
        if (category.subcategories.count != 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }
    else
    {
        ZYTableViewCell *cell = [ZYTableViewCell cellWithTableView:tableView andNormalImageName:@"bg_dropdown_leftpart" andSelectedImageName:@"bg_dropdown_left_selected"];
        ZYCategory *category = _categoryArray[[_metaDataView.mainTableView indexPathForSelectedRow].row];
        cell.textLabel.text = category.subcategories[indexPath.row];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _metaDataView.mainTableView) {
        ZYTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        ZYCategory *category = _categoryArray[indexPath.row];

        cell.imageView.image = [UIImage imageNamed:category.small_highlighted_icon];
        [_metaDataView.subTableView reloadData];
    }
    else
    {
#warning ToDo
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _metaDataView.mainTableView) {
        ZYTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        ZYCategory *category = _categoryArray[indexPath.row];
        
        cell.imageView.image = [UIImage imageNamed:category.small_icon];
    }
    else
    {
#warning ToDo
    }

}

@end
