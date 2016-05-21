//
//  MLProductCollectionViewController.m
//  MLMyLottery
//
//  Created by tarena on 16/4/22.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MLProductCollectionViewController.h"
#import "MLProduct.h"
#import "MLProductCell.h"

@interface MLProductCollectionViewController ()
@property (nonatomic, strong) NSMutableArray *products;

@end

@implementation MLProductCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

-(NSMutableArray *)products
{
    if (_products == nil) {
        _products = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"products" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
       NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dict in jsonArray) {
            MLProduct *product = [MLProduct productWithDict:dict];
            [_products addObject:product];
        }
    }
    return _products;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //与UITableViewController不同，self.collectionView与self.view不一样，self.view是一个UICollectionViewControllerWrapperView
    //NSLog(@"%@---%@",self.collectionView, self.view);
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    UINib *xib = [UINib nibWithNibName:@"MLProductCell" bundle:nil];
    [self.collectionView registerNib:xib forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
   // [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];

    
    // Do any additional setup after loading the view.
}

-(instancetype)init
{//使用UICollectionView必须有布局，并且cell必须自己注册
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(80, 80);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);

    return [super initWithCollectionViewLayout:layout];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.products.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MLProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    MLProduct *p = self.products[indexPath.row];
    cell.product = p;
    return cell;

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MLProduct *p = self.products[indexPath.row];
    NSLog(@"点击了%@",p.title);
}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
