//
//  PCDiagnoseTableViewController.m
//  PregnantCare
//
//  Created by tarena on 16/6/14.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PCDiagnoseTableViewController.h"
#import "PCSelfDiagViewController.h"
#import "PCAskDiagViewController.h"
@interface PCDiagnoseTableViewController ()

@end

@implementation PCDiagnoseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.rowHeight = 80;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"diagnose" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:!indexPath.row ? @"self_diag" : @"ask_diag"];
    cell.textLabel.text = !indexPath.row ? @"症状自诊" : @"在线问诊";
    cell.detailTextLabel.text = !indexPath.row ? @"分类查找疾病和症状" : @"描述症状，专业医生快速解答";
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath.row) {
        PCSelfDiagViewController *selfDiag = [[PCSelfDiagViewController alloc] init];
        [self.navigationController pushViewController:selfDiag animated:YES];
    }
    else
    {
        PCAskDiagViewController *ask = [[PCAskDiagViewController alloc] init];
        ask.navigationItem.title = @"在线问诊";
        [self.navigationController pushViewController:ask animated:YES];
    }
}




@end
