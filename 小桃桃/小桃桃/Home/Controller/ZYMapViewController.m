//
//  ZYMapViewController.m
//  小桃桃
//
//  Created by tarena on 16/5/30.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZYMapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "DPAPI.h"
#import "ZYDeal.h"
#import "ZYMetaDataTool.h"
#import "ZYBusiness.h"
#import "ZYAnnotation.h"
@interface ZYMapViewController ()<MKMapViewDelegate, DPRequestDelegate>
@property (nonatomic, strong) CLLocationManager *mgr;
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, copy) NSString *cityName;

@end

@implementation ZYMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mgr = [[CLLocationManager alloc] init];
    self.geocoder = [[CLGeocoder alloc] init];
    [self.mgr requestWhenInUseAuthorization];
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    self.mapView.delegate = self;
    
    [self.view addSubview:self.mapView];
    // Do any additional setup after loading the view.
}

#pragma mark -delegate

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [self.geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!error) {
            CLPlacemark *placemark = [placemarks lastObject];
            //系统要是简体中文
            self.cityName = placemark.addressDictionary[@"City"];
            self.cityName = [self.cityName substringToIndex:self.cityName.length - 1];
            [self mapView:mapView regionDidChangeAnimated:YES];
        }
        else
        {
            NSLog(@"反地理编码失败");
        }
    }];
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    if (!self.cityName) {
        return;
    }
    DPAPI *api = [[DPAPI alloc] init];
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[@"city"] = self.cityName;
    dictM[@"latitude"] = @(mapView.region.center.latitude);
    dictM[@"longitude"] = @(mapView.region.center.longitude);
    dictM[@"radius"] = @500;
    [api requestWithURL:@"v1/deal/find_deals" params:dictM delegate:self];
}


#pragma mark -DPAPI delegate

-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{

    NSArray *annotations = [NSArray arrayWithArray:self.mapView.annotations];
    [self.mapView removeAnnotations:annotations];
    
    NSArray *dealsArray = [ZYMetaDataTool parseDealsResult:result];
    //添加自定义大头针
    for (ZYDeal *deal in dealsArray) {
        NSArray *businessArray = [ZYMetaDataTool getAllBusiness:deal    ];
        ZYCategory *category = [ZYMetaDataTool getCategoryWithDeal:deal];
        for (ZYBusiness *business in businessArray) {
            ZYAnnotation *anno = [[ZYAnnotation alloc] init];
            anno.coordinate = CLLocationCoordinate2DMake(business.latitude, business.longitude);
            anno.title = business.name;
            anno.subtitle = deal.desc;
            if (category) {
                anno.image = [UIImage imageNamed:category.map_icon];
            }
            else
            {
                anno.image = [UIImage imageNamed:@"ic_category_default"];
            }
            [self.mapView addAnnotation:anno];
        }
    }
}

-(void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
#warning Todo
    NSLog(@"fail");
}


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString *ID = @"ID";
    MKAnnotationView *annoView = [mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (!annoView) {
        annoView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
        annoView.canShowCallout = YES;
        
        ZYAnnotation *anno = (ZYAnnotation *)annotation;
        annoView.image = anno.image;
    }
    else
    {
        annoView.annotation = annotation;
    }
    
    return annoView;
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
