//
//  AppDelegate.m
//  本地通知
//
//  Created by tarena on 16/5/7.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//程序终止时，通知也会发送过来，点击通知后，会调用此方法，而不会去调用didReceiveLocalNotification了
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    dispatch_once_t predicate = 0;
    dispatch_once(&predicate, ^{
        NSLog(@"-------");
        if ([UIDevice currentDevice].systemVersion.floatValue > 8.0) {
            
            UIApplication *app = [UIApplication sharedApplication];
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge categories:nil];
            [app registerUserNotificationSettings:settings];
        }
    });
    
//    static int count = 0;
//    count++;
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 200, 200)];
//    label.numberOfLines = 0;
//    label.textColor = [UIColor redColor];
//    label.backgroundColor = [UIColor lightGrayColor];
//    label.font = [UIFont systemFontOfSize:30];
//    label.text = [NSString stringWithFormat:@"%d",count];
//    [self.window.rootViewController.view addSubview:label];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


//当程序在前台时，会自动调用，在后台时，只有点击了通知才会调用，不会去调用didFinishLaunchingWithOptions

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"%s",__func__);
//    static int count = 0;
//    count++;
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 300, 200, 200)];
//    label.numberOfLines = 0;
//    label.textColor = [UIColor redColor];
//    label.backgroundColor = [UIColor greenColor];
//    label.font = [UIFont systemFontOfSize:30];
//    label.text = [NSString stringWithFormat:@"%d",count];
//    [self.window.rootViewController.view addSubview:label];
}
@end
