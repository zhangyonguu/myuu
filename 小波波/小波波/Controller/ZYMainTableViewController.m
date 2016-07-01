//
//  ZYMainTableViewController.m
//  小波波
//
//  Created by tarena on 16/6/2.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZYMainTableViewController.h"
#import "ZYMusicTool.h"
#import "ZYMusic.h"
#import "ZYPlayingViewController.h"

@interface ZYMainTableViewController ()
@property (nonatomic, strong) NSArray *musicArray;
@property (nonatomic, strong) ZYPlayingViewController *playingViewController;

@end

@implementation ZYMainTableViewController

-(ZYPlayingViewController *)playingViewController
{
    if (_playingViewController == nil) {
        self.playingViewController = [[ZYPlayingViewController alloc] init];
    }
    return _playingViewController;
}

-(NSArray *)musicArray
{
    if (_musicArray == nil) {
        self.musicArray = [ZYMusicTool getMusicArray];
    }
    return _musicArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 70;
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
    return self.musicArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    ZYMusic *music = _musicArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:music.singerIcon];
    cell.textLabel.text = music.name;
    cell.detailTextLabel.text = music.singer;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZYMusic *music = self.musicArray[indexPath.row];
    [ZYMusicTool setPlayingMusic:music];
    [self.playingViewController showPlayingView];
}
@end
