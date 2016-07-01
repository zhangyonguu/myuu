//
//  ViewController.m
//  MKMapCamera
//
//  Created by tarena on 16/5/24.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *mgr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mgr = [[CLLocationManager alloc] init];
    [self.mgr requestWhenInUseAuthorization];
    self.mapView.mapType = MKMapTypeStandard;
    
    self.mapView.zoomEnabled = YES;
    self.mapView.scrollEnabled = YES;
    
    self.mapView.rotateEnabled = NO;
    
    self.mapView.showsUserLocation = YES;
    [self locateToLatitude:23.333 longitude:113.33];
    CLLocationCoordinate2D to = {23.333, 113.33};
    CLLocationCoordinate2D from = {0, 0};
    
    MKMapCamera *camera = [MKMapCamera cameraLookingAtCenterCoordinate:to fromEyeCoordinate:from eyeAltitude:1000];
    
    self.mapView.camera = camera;
}

-(void)locateToLatitude:(CGFloat)latitude longitude:(CGFloat)longitude
{
    CLLocationCoordinate2D center = {latitude, longitude};
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    MKCoordinateRegion region = {center, span};
    [self.mapView setRegion:region];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
