//
//  PCBaseViewController.m
//  PregnantCare
//
//  Created by tarena on 16/6/3.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PCBaseViewController.h"
#import "UIView+Extension.h"
#import "PCCategory.h"
#import "PCRequestTool.h"
#import "PCArticle.h"

@interface PCBaseViewController ()


@property (nonatomic, assign) int scrollViewContentWidth;
@end

@implementation PCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addScrollView];
}


-(void)addScrollView
{
    self.scrollViewContentWidth = 0;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchArticleOrVideo)];
    self.navigationItem.leftBarButtonItem = item;
    
    CGFloat height = self.navigationController.navigationBar.height;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, height + 20, self.view.width - 32, 32)];

    [self addButtons];
    _scrollView.contentSize = CGSizeMake(self.scrollViewContentWidth + 15, 32);
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:self.scrollView];
    
    _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), self.view.width, self.tabBarController.tabBar.y - CGRectGetMaxY(self.scrollView.frame))];
    _contentScrollView.contentSize = CGSizeMake(self.view.width * self.categoriesArray.count, self.tabBarController.tabBar.y - CGRectGetMaxY(self.scrollView.frame));
    _contentScrollView.backgroundColor = [UIColor lightGrayColor];
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_contentScrollView];
}


-(void)addButtons
{
    for (PCCategory *category in self.categoriesArray) {

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:[category.title substringFromIndex:7] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tintColor = styleColor;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];

        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:20]};
        CGSize size = [button.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        CGFloat x = self.scrollViewContentWidth + 15;
        self.scrollViewContentWidth = x + size.width;
        button.frame = CGRectMake(x, 0, size.width, size.height);
        [self.scrollView addSubview:button];
    }
}


-(void)buttonClicked:(UIButton *)sender
{
    for (PCCategory *category in self.categoriesArray) {
        if ([[category.title substringFromIndex:7] isEqualToString:sender.titleLabel.text]) {
            self.currentCategory = category;
        }
    }
}


-(void)searchArticleOrVideo
{
#warning Todo
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
