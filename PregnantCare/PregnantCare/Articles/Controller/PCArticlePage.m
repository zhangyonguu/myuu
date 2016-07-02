//
//  PCArticlePage.m
//  PregnantCare
//
//  Created by tarena on 16/6/14.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PCArticlePage.h"
#import "MJRefresh.h"
#import "PCRequestTool.h"
#import "PCArticle.h"
#import "PCArticleTableViewCell.h"
#import "PCReadingArticle.h"

#import "DDXML.h"

typedef enum {
    HEADER, FOOTER
}DataType;

@interface PCArticlePage ()
@property (nonatomic, strong) NSMutableArray *articlesArray;
@property (nonatomic,assign,getter=isUpdate) BOOL update;
@property (nonatomic, strong) NSString *attrStr;
@end

@implementation PCArticlePage

-(instancetype)initWithAttributes:(NSString *)attrStr
{
    if (self = [super init]) {
        _attrStr  = attrStr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"PCArticleTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadLatestData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    //    [self loadLatestData];
    //      self.update = YES;
    // 通知中心推送广告并自动刷新
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(welcome) name:@"AdvertisementKey" object:nil];
}

-(void)loadLatestData
{
    NSString *url = [NSString stringWithFormat:articleRequestUrl,1,_attrStr];
    [self loadDataForType:HEADER withUrl:url];
}

-(void)loadMoreData
{
    NSString *url = [NSString stringWithFormat:articleRequestUrl,(int)self.articlesArray.count / 10 + 1,_attrStr];
    [self loadDataForType:FOOTER withUrl:url];
}

-(void)loadDataForType:(DataType)type withUrl:(NSString *)url
{
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *categoryUrl =[NSURL URLWithString:[urlPrefix stringByAppendingPathComponent:url]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:categoryUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                      {
                                          if (!error) {
                                              
                                              DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:data options:0 error:nil];
                                              NSArray *children = [doc nodesForXPath:@"//article" error:nil];
                                              NSMutableArray *newRequestArray = [NSMutableArray array];
                                              for (DDXMLElement *element in children) {
                                                  NSArray *attrsArray = [element attributes];
                                                  NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                                                  
                                                  for (DDXMLNode *attr in attrsArray)
                                                  {
                                                      NSString *value = [attr stringValue];
                                                      NSString *key = [attr name];
                                                      dict[key] = value;
                                                  }
                                                  PCArticle *article = [[PCArticle alloc] init];
                                                  [article setValuesForKeysWithDictionary:dict];
                                                  [newRequestArray addObject:article];
                                              }
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  if (type == HEADER) {
                                                      self.articlesArray = [newRequestArray mutableCopy];
                                                      [self.tableView.mj_header endRefreshing];
                                                      [self.tableView reloadData];
                                                  }
                                                  else if(type == FOOTER)
                                                  {
                                                      [self.articlesArray addObjectsFromArray:newRequestArray];
                                                      [self.tableView.mj_footer endRefreshing];
                                                      [self.tableView reloadData];
                                                  }

                                              });
                                              
                                          }
                                      }];
    [dataTask resume];}
#pragma mark - Table view data source

-(void)requestDataWithSufficUrl:(NSString *)suffixStr
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.articlesArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PCArticle *article = self.articlesArray[indexPath.row];
    PCArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.article = article;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PCArticle *article = self.articlesArray[indexPath.row];
    PCReadingArticle *reading = [[PCReadingArticle alloc] initWithArticle:article];
    [self.navigationController pushViewController:reading animated:YES];
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
