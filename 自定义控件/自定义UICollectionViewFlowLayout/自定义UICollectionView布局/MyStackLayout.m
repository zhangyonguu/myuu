//
//  MyStackLayout.m
//  自定义UICollectionView布局
//
//  Created by tarena on 16/5/3.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyStackLayout.h"
#define MyRandom0_1 (arc4random_uniform(100)/100.0)

@implementation MyStackLayout

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

-(CGSize)collectionViewContentSize
{
    return CGSizeMake(500, 400);
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *angles = @[@0, @(-0.1), @(-0.2), @(0.1), @(0.2)];

    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:indexPath.item   inSection:indexPath.section]];
    attrs.size = CGSizeMake(100, 100);
    attrs.center = CGPointMake(self.collectionView.frame.size.width * 0.5, self.collectionView.frame.size.height * 0.5);
    //        attrs.transform3D = CATransform3DMakeRotation(M_PI_2, 1, 1, 1);
    
    if (indexPath.item >= 5) {
        attrs.hidden = YES;
    } else{
        attrs.transform = CGAffineTransformMakeRotation([angles[indexPath.item] floatValue]);
        //zIndex越大越在上面
        attrs.zIndex = [self.collectionView numberOfItemsInSection:0] - indexPath.item;
    }
    return attrs;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //继承自UICollectionViewLayout不会自动计算好layoutAttributes，而继承自流水布局会自动计算默认的流水布局的layoutAttributes
    NSMutableArray *arrayM = [NSMutableArray array];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        [arrayM addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
         }
    return arrayM;
}
@end
