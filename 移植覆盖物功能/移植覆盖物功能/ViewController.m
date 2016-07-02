//
//  ViewController.m
//  移植覆盖物功能
//
//  Created by tarena on 16/5/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>
#import "MyAnimatedAnnotationView.h"

@interface ViewController ()<BMKMapViewDelegate>
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;

@property (nonatomic, strong)  BMKPointAnnotation *pointAnnotation;
@property (nonatomic, strong) BMKPointAnnotation *animatedAnnotation;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BMKCoordinateSpan span = {5, 5};
    CLLocationCoordinate2D coor = {39,119};
    BMKCoordinateRegion region = {coor, span};
    [self.mapView setRegion:region animated:YES];
        // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)addAnnotation:(id)sender {
    self.mapView.delegate = self;
    
    [self addPointAnnotation];
    [self addAnimatedAnnotation];
}

-(void)addPointAnnotation
{
    if (_pointAnnotation == nil) {
        _pointAnnotation = [[BMKPointAnnotation alloc] init];
        _pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.9, 119.4);
        _pointAnnotation.title = @"test";
        _pointAnnotation.subtitle = @"static";
    }
    [self.mapView addAnnotation:_pointAnnotation];
}

-(void)addAnimatedAnnotation
{
    if (_animatedAnnotation == nil) {
        _animatedAnnotation = [[BMKPointAnnotation alloc] init];
        _animatedAnnotation.coordinate = CLLocationCoordinate2DMake(40.1, 120.8);
        _animatedAnnotation.title = @"animated";
    }
    [self.mapView addAnnotation:_animatedAnnotation];
}

#pragma mark -delegate

-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    if (annotation == _pointAnnotation) {
        NSString *pointID = @"point";
        BMKPinAnnotationView *annoView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointID];
        if (!annoView) {
            annoView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointID];
            annoView.canShowCallout = YES;
            annoView.draggable = YES;
            annoView.pinColor = BMKPinAnnotationColorGreen;
            annoView.animatesDrop = YES;
        }
        return annoView;
    }
    NSString *ID = @"animated";
    MyAnimatedAnnotationView *MyAnnoView = nil;
    if(MyAnnoView == nil)
    {
        MyAnnoView = [[MyAnimatedAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
    }
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 1; i < 4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"poi_%d",i]];
        [images addObject:image];
    }
    MyAnnoView.annotationImages = images;
    return MyAnnoView;
}

@end
