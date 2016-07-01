//
//  ZYLocationManager.h
//  CoreLocation定位封装
//
//  Created by tarena on 16/5/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^LocationManagerCompletionHandler)(CLLocation *location, NSError *error);
typedef void(^CityCompletionHandler)(NSString *cityName, NSError *error);
;
@interface ZYLocationManager : NSObject

+(instancetype)sharedLocationManager;

-(void)updateLocationWithCompletionHandler:(LocationManagerCompletionHandler)handler;

-(void)updateCityWithCompletionHandler:(CityCompletionHandler)handler;
@end
