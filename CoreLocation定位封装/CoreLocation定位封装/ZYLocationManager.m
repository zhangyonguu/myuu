//
//  ZYLocationManager.m
//  CoreLocation定位封装
//
//  Created by tarena on 16/5/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZYLocationManager.h"

@interface ZYLocationManager ()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) LocationManagerCompletionHandler completionHandler;

@end

@implementation ZYLocationManager

-(CLLocationManager *)locationManager
{
    if (_locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager requestWhenInUseAuthorization];
    }
    return _locationManager;
}
+(instancetype)sharedLocationManager
{
    static ZYLocationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZYLocationManager alloc] init];
    });
    return manager;
}

-(void)updateLocationWithCompletionHandler:(LocationManagerCompletionHandler)handler
{
    if (![CLLocationManager locationServicesEnabled]) {
        NSError *error = [NSError errorWithDomain:@"cn.tarena.location" code:10 userInfo:[NSDictionary dictionaryWithObject:@"location service disabled" forKey:NSLocalizedDescriptionKey]];
        handler(nil,error);
        return;
    }
    
    [self.locationManager startUpdatingLocation];
    self.completionHandler = handler;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [self.locationManager stopUpdatingLocation];
    
    CLLocation *location = [locations firstObject];
    
    if (self.completionHandler) {
        self.completionHandler(location, nil);
        self.completionHandler = nil;
    }
}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self.locationManager stopUpdatingLocation];
    
    if (self.completionHandler) {
        self.completionHandler(nil, error);
        self.completionHandler = nil;
    }
}
@end
