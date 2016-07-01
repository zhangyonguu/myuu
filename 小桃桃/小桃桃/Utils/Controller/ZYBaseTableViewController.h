//
//  ZYBaseTableViewController.h
//  小桃桃
//
//  Created by tarena on 16/5/26.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYBaseTableViewController : UIViewController
@property (nonatomic, strong) UITableView *tableView;
-(void)settingRequestParams:(NSMutableDictionary *)params;
-(void)loadNewDeals;
@end
