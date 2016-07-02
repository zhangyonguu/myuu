//
//  PCDiseaseViewController.m
//  PregnantCare
//
//  Created by tarena on 16/6/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PCDiseaseViewController.h"
#import "PCDiseaseHeaderView.h"
#import "PCDisease.h"
#import "PCDiseasesTableViewController.h"
#import "PCArticlePage.h"
#import "PCAskDiagViewController.h"
@interface PCDiseaseViewController ()
@property (nonatomic, strong) NSString *diseaseCategory;
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) PCDiseaseHeaderView *headerView;
@end

@implementation PCDiseaseViewController

-(instancetype)initWithDiseaseName:(NSString *)diseaseName
{
    if (self = [super init]) {
        _diseaseCategory = diseaseName;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.navigationItem.title = self.diseaseCategory;
    self.view.backgroundColor = [UIColor whiteColor];
    self.headerView = [[NSBundle mainBundle] loadNibNamed:@"PCDiseaseHeaderView" owner:nil options:nil].lastObject;
    self.headerView.frame = CGRectMake(0, 64, self.view.width, 30);
    [self.view addSubview:self.headerView];
    // Do any additional setup after loading the view from its nib.
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 44, self.view.width, 44)];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 5, footer.width - 40, footer.height - 15)];
    button.backgroundColor = styleColor;
    [button setTitle:@"一键在线问诊" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(askDisease:) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:button];
    [self.view addSubview:footer];
    
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), self.view.width, CGRectGetMinY(footer.frame) - CGRectGetMaxY(self.headerView.frame))];
    self.contentScrollView.contentSize = CGSizeMake(_contentScrollView.width * 3, _contentScrollView.height);
    
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.bounces = NO;

    [self addSubControllers];
    [self.view addSubview:_contentScrollView];
}

-(void)addSubControllers
{
    
    PCDiseasesTableViewController *diseasePage = [[PCDiseasesTableViewController alloc] initWithUrlStr:[[urlPrefix stringByAppendingString:[NSString stringWithFormat:@"/healthinterface/getrelatelist.ashx?category=%@",self.diseaseCategory]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]] andCellType:kTableCellTypeDisease];
    /**注意：如果不加入子控制器，此控制器对象将被销毁*/
    [self addChildViewController:diseasePage];
    diseasePage.view.frame = _contentScrollView.bounds;
    [_contentScrollView addSubview:diseasePage.view];
    
    PCDiseasesTableViewController *questionPage = [[PCDiseasesTableViewController alloc] initWithUrlStr:[[urlPrefix stringByAppendingString:[NSString stringWithFormat:@"/healthinterface/getasklist.ashx?category=%@",self.diseaseCategory]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]] andCellType:kTableCellTypeQuestion];
    questionPage.view.frame = (CGRect){{_contentScrollView.width,0},_contentScrollView.size};
    [self addChildViewController:questionPage];
    [_contentScrollView addSubview:questionPage.view];
    
    PCArticlePage *articlePage = [[PCArticlePage alloc] initWithAttributes:[NSString stringWithFormat:@"title=%@&deviceTypeId=1&topicid=251",_diseaseCategory]];
    articlePage.view.frame = (CGRect){{_contentScrollView.width * 2,0},_contentScrollView.size};
    [self addChildViewController:articlePage];
    [_contentScrollView addSubview:articlePage.view];
}

-(void)askDisease:(UIButton *)sender
{
    PCAskDiagViewController *ask = [[PCAskDiagViewController alloc] init];
    ask.navigationItem.title = @"在线问诊";
    [self.navigationController pushViewController:ask animated:YES];
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
