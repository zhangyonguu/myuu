//
//  ViewController.m
//  route
//
//  Created by tarena on 16/5/24.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
@interface ViewController ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation ViewController
- (IBAction)addOverlay:(id)sender {
    NSString *from = @"北京";
    NSString *to = @"深圳";

    [self.geocoder geocodeAddressString:from completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //CLGeocoder编码是异步的，第一次编码完成后，会回到主线程，才能再执行下一次编码（再次调用子线程）
        CLPlacemark *placemark = [placemarks lastObject];
        MKPointAnnotation *anno = [[MKPointAnnotation alloc] init];
        anno.coordinate = placemark.location.coordinate;
        anno.title = @"source";
        [self.mapView addAnnotation:anno];
        
        [self.geocoder geocodeAddressString:to completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            CLPlacemark *endplacemark = [placemarks lastObject];
            MKPointAnnotation *anno = [[MKPointAnnotation alloc] init];
            anno.coordinate = endplacemark.location.coordinate;
            anno.title = @"dest";
            [self.mapView addAnnotation:anno];
            [self startRoute:placemark withPlacemark:endplacemark];
        }];

    }];

}

-(void)startRoute:(CLPlacemark *)startPlacemark withPlacemark:(CLPlacemark *)endPlacemark
{
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    MKMapItem * sourceItem = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithPlacemark:startPlacemark]];
    MKMapItem * destItem = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithPlacemark:endPlacemark]];
    
    request.source = sourceItem;
    request.destination = destItem;
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            for (MKRoute *route in response.routes) {
                NSLog(@"%g---%g",route.expectedTravelTime,route.distance);
                
                for (MKRouteStep *step in route.steps) {
                    NSLog(@"-----%@----%g",step.instructions, step.distance);
                    [self.mapView addOverlay:step.polyline];

                }
            }
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.geocoder  = [[CLGeocoder alloc] init];
    self.mapView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -delegate

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineRenderer *render = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    
    render.lineWidth = 5.0;
    render.strokeColor = [UIColor blueColor];
    return render;
}

@end
