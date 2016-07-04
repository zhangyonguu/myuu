//
//  ViewController.m
//  MKMapView
//
//  Created by tarena on 16/5/23.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"

#import <MapKit/MapKit.h>

@interface ViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *mgr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mgr = [[CLLocationManager alloc] init];
    
    [self.mgr requestWhenInUseAuthorization];
    
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    self.mapView.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"%g,%g",userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{//region设备上显示的那部分
    NSLog(@"用户挪动地图停止");
}
@end
