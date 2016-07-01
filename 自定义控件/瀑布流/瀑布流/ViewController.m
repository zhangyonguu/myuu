//
//  ViewController.m
//  瀑布流
//
//  Created by tarena on 16/5/3.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "WaterFallLayout.h"
#import "MyCollectionViewCell.h"
#import "MJExtension.h"
#import "HMShop.h"
#import "MJRefresh.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, WaterFallLayoutDelegate>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray <HMShop *>*shops;

@end

@implementation ViewController

static NSString *const ID = @"shop";

-(NSMutableArray *)shops
{
    if (_shops == nil) {
        self.shops = [[NSMutableArray alloc] init];
    }
    return _shops;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"plist"];
    NSArray *shopArray = [HMShop objectArrayWithFile:path];
    [self.shops addObjectsFromArray:shopArray];
    
    CGFloat w = self.view.frame.size.width;
    CGFloat h = self.view.frame.size.height;
    CGRect rect = CGRectMake(0, 0, w, h);
    
    WaterFallLayout *layout = [[WaterFallLayout alloc] init];
    layout.delegate = self;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    self.collectionView = collectionView;
    [self.collectionView addFooterWithTarget:self action:@selector(loadMore)];
    [self.view addSubview:collectionView];

}

-(void)loadMore
{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *path = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"plist"];
            NSArray *shopArray = [HMShop objectArrayWithFile:path];
            [self.shops addObjectsFromArray:shopArray];
            [self.collectionView reloadData];
            [self.collectionView footerEndRefreshing];
    });
}
#pragma mark -WaterFallLayoutDelegate
-(CGFloat)waterFallLayout:(WaterFallLayout *)waterFallLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath
{
    HMShop *shop = self.shops[indexPath.item];
    return shop.h/shop.w * width;
}


#pragma mark -UICollectionViewDataSource
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 1;
//}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shops.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.shop = self.shops[indexPath.item];
    return cell;
}
@end
