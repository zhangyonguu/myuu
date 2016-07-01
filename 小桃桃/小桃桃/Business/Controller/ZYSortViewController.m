//
//  ZYSortViewController.m
//  小桃桃
//
//  Created by tarena on 16/5/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZYSortViewController.h"
#import "ZYSort.h"
#import "ZYMetaDataTool.h"

@interface ZYSortViewController ()
@property (nonatomic, strong) NSArray *sortsArray;

@end

static const CGFloat buttonWidth = 100;
static const CGFloat buttonHeight = 30;
static const CGFloat buttonPadding = 20;

@implementation ZYSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor lightGrayColor];

    // Do any additional setup after loading the view.
    self.sortsArray = [ZYMetaDataTool getAllSorts];
    for (ZYSort *sort in _sortsArray) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(buttonPadding, buttonPadding + (buttonPadding + buttonHeight) * [_sortsArray indexOfObject:sort], buttonWidth, buttonHeight);
        [button setBackgroundImage:[UIImage imageNamed:@"btn_filter_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_filter_selected"] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitle:sort.label forState:UIControlStateNormal];
        button.tag = 1000 + [_sortsArray indexOfObject:sort];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    self.preferredContentSize = CGSizeMake(2 * buttonPadding + buttonWidth, _sortsArray.count * (buttonPadding + buttonHeight) + buttonPadding);
}

-(void)buttonClicked:(UIButton *)button
{
    ZYSort *sort = self.sortsArray[button.tag - 1000];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SortDidChange" object:self userInfo:[NSDictionary dictionaryWithObject:sort forKey:@"sort"]];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
