//
//  ViewController.m
//  iBeacon
//
//  Created by tarena on 16/6/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
@import CoreBluetooth;
@import CoreLocation;

/**标示当前设备*/
static NSString *kUUID = @"00000000-0000-0000-0000-000000000000";
/**标示当前的应用*/
static NSString *appID = @"ID";

@interface ViewController ()<CLLocationManagerDelegate, CBPeripheralManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, strong) CLBeaconRegion *beaconRegion;
@property (nonatomic, strong) CBPeripheralManager *peripheralManager;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ViewController

-(CLBeaconRegion *)beaconRegion
{
    if (_beaconRegion == nil) {
        NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:kUUID];
        self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:appID];
    }
    return _beaconRegion;
}
-(CLLocationManager *)locationManager
{
    if (_locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [_locationManager requestAlwaysAuthorization];
        }
    }
    return _locationManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)listen:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        [self.locationManager stopMonitoringForRegion:self.beaconRegion];
    }
    else
    {
        [self.locationManager startMonitoringForRegion:self.beaconRegion];
    }
}
- (IBAction)broadcast:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        [self.peripheralManager stopAdvertising];
    }
    else
    {
        self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
    }
}
- (IBAction)locate:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
    }
    else
    {
        [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
    }
}

#pragma mark -locationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"enter %@",region);
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    NSLog(@"exit %@",region);

}

-(void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    switch (state) {
        case CLRegionStateInside:
            self.textView.text = @"CLRegionStateInside";
            break;
        case CLRegionStateOutside:
            self.textView.text = @"CLRegionStateOutside";
            break;
        default:
            break;
    }
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray<CLBeacon *> *)beacons inRegion:(CLBeaconRegion *)region
{
    NSLog(@"beacons --- %@", beacons);
}

#pragma mark -peripheralManagerDelegate
-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        [self.peripheralManager startAdvertising:[self.beaconRegion peripheralDataWithMeasuredPower:nil]];
        NSLog(@"startBroadcasting");
    }
}
@end
