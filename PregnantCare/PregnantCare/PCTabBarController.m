//
//  PCTabBarController.m
//  PregnantCare
//
//  Created by tarena on 16/6/3.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PCTabBarController.h"
#import "PCRequestTool.h"
#import "PCCategory.h"
#import "PCArticle.h"
#import "PCAppBanner.h"

@interface PCTabBarController ()

@end

@implementation PCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
//    PCRequestTool *categoryTool = [[PCRequestTool alloc] init];
//   NSMutableArray *categories = [categoryTool requestDataWithURLComponentString:@"/flashinterface/GetCategoryByTopicID.ashx?topicid=151" andClass:[PCCategory class]];
//    
//    PCRequestTool *bannerTool = [[PCRequestTool alloc] init];
//    NSMutableArray *banners = [bannerTool requestDataWithURLComponentString:@"/flashinterface/GetAppBanner.ashx?topicid=151&typeid=1" andClass:[PCAppBanner class]];
//    
//
//    NSMutableArray *articleArrays = [NSMutableArray array];
//    for (PCCategory *category in categories) {
//        if ([category.typeid isEqualToString:@"7"]) {
//            PCRequestTool *tool = [[PCRequestTool alloc] init];
//            NSString *suffixURL = [NSString stringWithFormat:@"/openinterface/gethelperbypage.ashx?page=%d&pagesize=10&classes=%@&deviceTypeId=1&typeid=7",1,category.title];
//           suffixURL = [suffixURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
//            NSMutableArray *articles = [tool requestDataWithURLComponentString:suffixURL andClass:[PCArticle class]];
//            [articleArrays addObject:articles];
//        }                     
//    }
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
