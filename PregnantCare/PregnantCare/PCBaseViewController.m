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

@interface PCBaseViewController ()
@property (nonatomic, strong) UIView *contentsView;

@property (nonatomic, strong) NSArray<PCCategory *> *categoriesArray;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) int scrollViewContentWidth;
@end

@implementation PCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PCRequestTool *categoryTool = [[PCRequestTool alloc] init];
    NSMutableArray *categories = [categoryTool requestDataWithURLComponentString:@"/flashinterface/GetCategoryByTopicID.ashx?topicid=151" andClass:[PCCategory class]];
    self.categoriesArray = [categories copy];
    
    self.scrollViewContentWidth = 0;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchArticleOrVideo)];
    self.navigationItem.leftBarButtonItem = item;
    
    CGFloat height = self.navigationController.navigationBar.height;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, height + 20, self.view.width - 32, 25)];

    [self addButtons];
    
    _scrollView.contentSize = CGSizeMake(self.scrollViewContentWidth + 15, 25);
    _scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.backgroundColor = [UIColor lightGrayColor];

    [self.view addSubview:self.scrollView];

    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)addButtons
{
    for (PCCategory *category in self.categoriesArray) {

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

        [button setTitle:[category.title substringFromIndex:7] forState:UIControlStateNormal];
        button.tintColor = styleColor;

        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:20]};
        CGSize size = [button.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 25) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        CGFloat x = self.scrollViewContentWidth + 15;
        self.scrollViewContentWidth = x + size.width;
        button.frame = CGRectMake(x, 0, size.width, size.height);
        [self.scrollView addSubview:button];
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
