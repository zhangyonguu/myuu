//
//  PoiViewController.m
//  移植POI
//
//  Created by tarena on 16/5/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PoiViewController.h"
#import <BaiduMapAPI_Search/BMKPoiSearch.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <MapKit/MapKit.h>
@interface PoiViewController ()<BMKPoiSearchDelegate>
@property (nonatomic, strong) BMKPoiSearch *poisearch;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *mgr;

@end

@implementation PoiViewController

-(BMKPoiSearch *)poisearch
{
    if (_poisearch == nil) {
        _poisearch = [BMKPoiSearch new];
    }
    return _poisearch;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.poisearch.delegate = self;
    self.mgr = [[CLLocationManager alloc] init];
    [self.mgr requestWhenInUseAuthorization];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)clicked:(id)sender
{

    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = 0;
    citySearchOption.pageCapacity = 10;
    citySearchOption.city= @"深圳";
    citySearchOption.keyword = @"酒店";
    BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
    if(flag)
    {
        NSLog(@"城市内检索发送成功");
    }
    else
    {
        NSLog(@"城市内检索发送失败");
    }
}


#pragma mark -delegate

-(void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    
    if (errorCode == BMK_SEARCH_NO_ERROR) {
        NSMutableArray *annotations = [NSMutableArray array];
        for (int i = 0; i < poiResult.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [poiResult.poiInfoList objectAtIndex:i];
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            [annotations addObject:item];
        }
        [_mapView addAnnotations:annotations];
        [_mapView showAnnotations:annotations animated:YES];
    } else if (errorCode == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }

}

@end
