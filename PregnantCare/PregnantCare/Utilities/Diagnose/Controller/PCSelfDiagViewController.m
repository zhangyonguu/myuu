//
//  PCSelfDiagViewController.m
//  PregnantCare
//
//  Created by tarena on 16/6/14.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PCSelfDiagViewController.h"
#import "PCDiagnoseCategory.h"
#import "PCSubCategoryView.h"
#import "DiagCategoryCell.h"
#import "PCDiseaseViewController.h"

@interface PCSelfDiagViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *categoriesArray;
@property (nonatomic, strong) PCSubCategoryView *categoryView;

@end

@implementation PCSelfDiagViewController

-(NSMutableArray *)categoriesArray
{
    if (_categoriesArray == nil) {
        self.categoriesArray = [[NSMutableArray alloc] init];
    }
    return _categoriesArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"自我诊断";
    
    self.categoryView = [[NSBundle mainBundle] loadNibNamed:@"PCSubCategoryView" owner:nil options:nil].lastObject;
    
    _categoryView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64);
//    _categoryView.frame = self.view.frame;
    
    _categoryView.mainTableView.rowHeight = 90;
    [_categoryView.mainTableView registerNib:[UINib nibWithNibName:@"DiagCategoryCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [_categoryView.subTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_categoryView.mainTableView setBackgroundColor:[UIColor lightGrayColor]];
    _categoryView.mainTableView.showsVerticalScrollIndicator = NO;
    _categoryView.subTableView.showsVerticalScrollIndicator = NO;
    
    _categoryView.mainTableView.delegate = self;
    _categoryView.subTableView.delegate = self;

    _categoryView.mainTableView.dataSource = self;
    _categoryView.subTableView.dataSource = self;

    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://apps.caredsp.com/healthinterface/getcategory.ashx"]];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error)
        {
            NSError *jsonError = nil;
            NSDictionary *dictFromJson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
            if (!jsonError) {
                NSArray *categories = dictFromJson[@"data"];
                for (NSDictionary *dict in categories)
                {
                  PCDiagnoseCategory *diagCate =  [[PCDiagnoseCategory alloc] init];
                    [diagCate setValuesForKeysWithDictionary:dict];
                    [self.categoriesArray addObject:diagCate];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_categoryView.mainTableView reloadData];
                        [_categoryView.subTableView reloadData];
                    });
                }
            }

         }
    }];
    [dataTask resume];
    
    [self.view addSubview:_categoryView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _categoryView.mainTableView) {
        return self.categoriesArray.count;
    }
    else
    {
        
        NSInteger index = [_categoryView.mainTableView indexPathForSelectedRow].row;
        NSArray *array = nil;
        if (self.categoriesArray.count) {
            PCDiagnoseCategory *category = self.categoriesArray[index];
            array = [category.keywords componentsSeparatedByString:@";"];
            
        }
        return array.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _categoryView.mainTableView) {
        DiagCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

        PCDiagnoseCategory *category = self.categoriesArray[indexPath.row];
        cell.category = category;
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        NSInteger index = [_categoryView.mainTableView indexPathForSelectedRow].row;
        PCDiagnoseCategory *category = self.categoriesArray[index];
        NSArray *array = [category.keywords componentsSeparatedByString:@";"];
        cell.textLabel.text = array[indexPath.row];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _categoryView.mainTableView) {
        [_categoryView.subTableView reloadData];
    }
    else
    {
        NSInteger index = [_categoryView.mainTableView indexPathForSelectedRow].row;
        PCDiagnoseCategory *category = self.categoriesArray[index];
        NSArray *array = [category.keywords componentsSeparatedByString:@";"];
        NSString *diseaseName = array[indexPath.row];
        PCDiseaseViewController *disease = [[PCDiseaseViewController alloc] initWithDiseaseName:diseaseName];
        [self.navigationController pushViewController:disease animated:YES];
    }
}
@end
