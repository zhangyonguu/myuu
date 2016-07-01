//
//  ZYRegionViewController.m
//  小桃桃
//
//  Created by tarena on 16/5/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZYRegionViewController.h"
#import "ZYMetaDataTool.h"
#import "ZYMetaDataView.h"
#import "ZYRegion.h"
#import "ZYTableViewCell.h"

@interface ZYRegionViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *regionArray;
@property (nonatomic, strong) ZYMetaDataView *metaDataView;

@end

@implementation ZYRegionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _regionArray = [ZYMetaDataTool getRegionsOfCity:[ZYMetaDataTool getSelectedCityName]];
    [self addMetaDataView];
}

-(void)viewWillAppear:(BOOL)animated
{
    _regionArray = [ZYMetaDataTool getRegionsOfCity:[ZYMetaDataTool getSelectedCityName]];
    [self.metaDataView.mainTableView reloadData];
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
        return _regionArray.count;
    }
    else
    {
        ZYRegion *region = _regionArray[[_metaDataView.mainTableView indexPathForSelectedRow].row];
        return region.subregions.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _metaDataView.mainTableView) {
        ZYTableViewCell *cell = [ZYTableViewCell cellWithTableView:tableView andNormalImageName:@"bg_dropdown_leftpart" andSelectedImageName:@"bg_dropdown_left_selected"];
        ZYRegion *region = _regionArray[indexPath.row];
        cell.textLabel.text = region.name;
        return cell;
    }
    else
    {
        ZYTableViewCell *cell = [ZYTableViewCell cellWithTableView:tableView andNormalImageName:@"bg_dropdown_leftpart" andSelectedImageName:@"bg_dropdown_left_selected"];
        ZYRegion *region = _regionArray[[_metaDataView.mainTableView indexPathForSelectedRow].row];
        cell.textLabel.text = region.subregions[indexPath.row];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _metaDataView.mainTableView) {
        [_metaDataView.subTableView reloadData];
        //no subregions param:region
        ZYRegion * region = _regionArray[[_metaDataView.mainTableView indexPathForSelectedRow].row];
        if (region.subregions.count == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RegionDidChange" object:self userInfo:@{@"region" : region}];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
    else
    {//has subregions param:region + subregion
        NSUInteger leftRow = [_metaDataView.mainTableView indexPathForSelectedRow].row;
        NSUInteger rightRow = [_metaDataView.subTableView indexPathForSelectedRow].row;
        ZYRegion *region = _regionArray[leftRow];
        NSString *subregion = region.subregions[rightRow];
         [[NSNotificationCenter defaultCenter] postNotificationName:@"RegionDidChange" object:self userInfo:@{@"region" : region, @"subregion": subregion}];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
@end
