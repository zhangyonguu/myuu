//
//  ViewController.m
//  利用系统自带APP导航
//
//  Created by tarena on 16/5/24.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()
@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.geocoder = [[CLGeocoder alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.geocoder geocodeAddressString:@"北京" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count == 0) {
            return;
        }
        CLPlacemark *startPM = [placemarks firstObject];
        
        [self.geocoder geocodeAddressString:@"深圳" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (placemarks.count == 0) {
                return;
            }
            CLPlacemark *endPM = [placemarks firstObject];
            
            [self startNavigationWithPlaceMark:startPM endPlaceMark:endPM];
        }];
    }];
}

-(void)startNavigationWithPlaceMark:(CLPlacemark *)startPM endPlaceMark:(CLPlacemark *)endPM
{
    MKPlacemark *start = [[MKPlacemark alloc] initWithPlacemark:startPM];
    MKMapItem *startItem = [[MKMapItem alloc] initWithPlacemark:start];
    
    MKPlacemark *end = [[MKPlacemark alloc] initWithPlacemark:endPM];
    MKMapItem *endItem = [[MKMapItem alloc] initWithPlacemark:end];
    
    NSArray *items = @[startItem, endItem];
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[MKLaunchOptionsDirectionsModeKey] = MKLaunchOptionsDirectionsModeDriving;
    
    dictM[MKLaunchOptionsMapTypeKey] = @(MKMapTypeHybrid);
    
    
    //只要调用这个方法就可以打开系统自带的地图APP进行导航了
    [MKMapItem openMapsWithItems:items launchOptions:dictM];
    
    
}

@end
