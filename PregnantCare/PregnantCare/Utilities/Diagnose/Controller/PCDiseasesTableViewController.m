//
//  PCDiseasesTableViewController.m
//  PregnantCare
//
//  Created by tarena on 16/6/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PCDiseasesTableViewController.h"
#import "PCDisease.h"
#import "PCQuestion.h"
#import "PCDiseaseCell.h"
@interface PCDiseasesTableViewController ()
@property (nonatomic, copy) NSString *urlStr;
@property (nonatomic, strong) NSMutableArray *objectArray;
@property (nonatomic, assign) cellType type;
@end

@implementation PCDiseasesTableViewController

-(NSMutableArray *)objectArray
{
    if (_objectArray == nil) {
        self.objectArray = [[NSMutableArray alloc] init];
    }
    return _objectArray;
}

-(instancetype)initWithUrlStr:(NSString *)urlStr andCellType:(cellType)type
{
    if (self = [super init]) {
        _urlStr = urlStr;
        _type = type;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PCDiseaseCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error)
        {
            NSError *jsonError = nil;
            NSDictionary *dictFromJson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
            if (!jsonError) {
                 NSArray *dataArray = !_type ? dictFromJson[@"data"] : dictFromJson[@"data"][@"items"];
                for (NSDictionary *dict in dataArray)
                {
                    switch (self.type) {
                        case kTableCellTypeDisease:
                        {
                            PCDisease *diag =  [[PCDisease alloc] init];
                            [diag setValuesForKeysWithDictionary:dict];
                            [self.objectArray addObject:diag];
                        }
                            break;
                        case kTableCellTypeQuestion:
                        {
                            PCQuestion *question = [[PCQuestion alloc] init];
                            [question setValuesForKeysWithDictionary:dict];
                            [self.objectArray addObject:question];
                        }
                            break;
                        default:
                            break;
                    }
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }
        }
    }];
    [dataTask resume];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objectArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PCDiseaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell.numberButton setTitle:[NSString stringWithFormat:@"%ld",indexPath.row] forState:UIControlStateNormal];
    cell.upLabel.text = !self.type ? [self.objectArray[indexPath.row] showName] : [self.objectArray[indexPath.row] title];
    cell.bottomLabel.text = !self.type ? [(PCDisease *)self.objectArray[indexPath.row] definition] : [(PCQuestion *)self.objectArray[indexPath.row] answer];
    cell.unfoldImage.image = [UIImage imageNamed:@"arrow_down"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

//-(void)dealloc
//{
//    NSLog(@"dealloc");
//}

@end
