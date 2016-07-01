//
//  MyCircleLayout.m
//  自定义UICollectionView布局
//
//  Created by tarena on 16/5/3.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyCircleLayout.h"

@implementation MyCircleLayout

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:indexPath.item   inSection:indexPath.section]];
    attrs.size = CGSizeMake(40, 40);
    CGFloat circleRadius = 70;
    CGPoint circleCenter = CGPointMake(self.collectionView.frame.size.width  * 0.5, self.collectionView.frame.size.height * 0.5);
    CGFloat angleDelta = M_PI * 2/[self.collectionView numberOfItemsInSection:0];
    CGFloat angle = angleDelta * indexPath.item;
    attrs.center = CGPointMake(circleCenter.x + cosf(angle) * circleRadius, circleCenter.y - sinf(angle) * circleRadius);
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
