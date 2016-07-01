//
//  ViewController.m
//  自定义UICollectionView布局
//
//  Created by tarena on 16/4/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "MyImageCell.h"
#import "MyCircleLayout.h"


@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation ViewController

static NSString *const ID = @"image";

-(NSMutableArray *)images
{
    if (_images == nil) {
        self.images = [[NSMutableArray alloc] init];
        for (int i = 1; i <= 20; i++) {
            [self.images addObject:[NSString stringWithFormat:@"%d", i]];
        }
    }
    return _images;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    CGFloat w = self.view.frame.size.width;
    CGRect rect = CGRectMake(0, 100, w, 200);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:[[MyCircleLayout alloc] init]];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:@"MyImageCell" bundle:nil] forCellWithReuseIdentifier:@"image"];
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
}

#pragma mark -<UICollectionViewDataSource>

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.imageName = self.images[indexPath.item];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //删除模型数据
    [self.images removeObjectAtIndex:indexPath.item];
    //刷新UI
    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.collectionView.collectionViewLayout isKindOfClass:[MyCircleLayout class]]) {
        [self.collectionView setCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init] animated:YES];
    }
    else
    {
        [self.collectionView setCollectionViewLayout:[[MyCircleLayout alloc] init] animated:YES];
    }
}
@end
