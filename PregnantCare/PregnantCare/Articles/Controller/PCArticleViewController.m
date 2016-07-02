//
//  PCArticleViewController.m
//  PregnantCare
//
//  Created by tarena on 16/6/6.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PCArticleViewController.h"
#import "PCRequestTool.h"
#import "PCCategory.h"
#import "UIView+Extension.h"
#import "PCArticle.h"
#import "PCArticleTableViewCell.h"
#import "MJRefresh.h"
#import "PCArticlePage.h"
@interface PCArticleViewController ()

@end

@implementation PCArticleViewController


-(void)loadView
{//获取当前控制器对应的分类
    [super loadView];
    PCRequestTool *categoryTool = [[PCRequestTool alloc] init];
    NSMutableArray *categories = [categoryTool requestDataWithURLComponentString:@"/flashinterface/GetCategoryByTopicID.ashx?topicid=151" andClass:[PCCategory class]];
    NSMutableArray *arrayM = [NSMutableArray array];
    for (PCCategory *category in categories)
    {
        if ([category.typeid isEqualToString:@"7"])
        {
            [arrayM addObject:category];
        }
    }
    self.categoriesArray = [arrayM copy];
}



- (void)viewDidLoad {
    [super viewDidLoad];

    [self addArticlePages];
    
    UIViewController *vc = [self.childViewControllers firstObject];
    vc.view.frame = self.contentScrollView.bounds;
    [self.contentScrollView addSubview:vc
     .view];
    
}
/**
1.程序启动后，每个tableView都会拉数据
 */
-(void)addArticlePages
{
    for (PCCategory *category in self.categoriesArray) {
        int index = (int)[self.categoriesArray indexOfObject:category];
        PCArticlePage *page = [[PCArticlePage alloc] initWithAttributes:[NSString stringWithFormat:@"classes=%@&deviceTypeId=1&typeid=7",category.title]];
        [self addChildViewController:page];
        CGFloat contentX = self.view.width * index;
        page.view.frame = CGRectMake(contentX, 0, page.view.width, page.view.height);
        [self.contentScrollView addSubview:page.view];
    }
}

@end
