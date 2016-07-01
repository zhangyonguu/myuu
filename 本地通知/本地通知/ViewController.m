//
//  ViewController.m
//  本地通知
//
//  Created by tarena on 16/5/7.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__func__);
    UIApplication *app = [UIApplication sharedApplication];
    
    UILocalNotification *ln = [[UILocalNotification alloc] init];
    ln.fireDate = [NSDate dateWithTimeIntervalSinceNow:5.0];
    ln.alertBody = @"这是通知内容";
    ln.timeZone = [NSTimeZone defaultTimeZone];
//    ln.repeatInterval = NSCalendarUnitSecond;
    ln.alertAction = @"这是锁屏界面的信息";
    ln.alertLaunchImage = @"Default";
    ln.soundName = @"buyao.wav";
    ln.applicationIconBadgeNumber = 2;
    NSLog(@"%p",ln);
    [app scheduleLocalNotification:ln];
    NSLog(@"%@",app.scheduledLocalNotifications);
    
}
@end
