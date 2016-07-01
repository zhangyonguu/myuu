//
//  MyLineLayout.m
//  自定义UICollectionView布局
//
//  Created by tarena on 16/4/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyLineLayout.h"

static const CGFloat MyItemSide = 100;

@implementation MyLineLayout

-(instancetype)init
{
    if (self = [super init]) {
        //未设置之前一行显示5个cell，设置之后3个，但是，frame是一样的，为何？？
            }
    return self;
}

/**
 只要显示的边界发生改变就重新布局：内部会调用layoutAttributesForElementsInRect方法
 和prepareLayout方法
 */
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

//proposedContentOffset原本应该停下来的位置
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGRect lastRect;
    lastRect.origin = proposedContentOffset;
    lastRect.size = self.collectionView.frame.size;
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    NSArray *array = [self layoutAttributesForElementsInRect:lastRect];
    
    CGFloat adjustOffsetX = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if(ABS(attrs.center.x - centerX) < ABS(MAXFLOAT))
        {
            adjustOffsetX = attrs.center.x - centerX;
        }
    }
    return CGPointMake(proposedContentOffset.x + adjustOffsetX, proposedContentOffset.y);
}
//初始化操作最好在这里实现
-(void)prepareLayout
{
//    NSLog(@"%s",__func__);
    self.itemSize = CGSizeMake(MyItemSide, MyItemSide);
    CGFloat inset = (self.collectionView.frame.size.width - MyItemSide) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = 100;
}

//返回rect内所有cell的UICollectionViewLayoutAttributes属性
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
//    NSLog(@"%s",__func__);
    //判断可见区域（即屏幕）在contentSize中的位置
    CGRect visibleRect;
    visibleRect.size = self.collectionView.frame.size;
    visibleRect.origin = self.collectionView.contentOffset;
    NSArray <UICollectionViewLayoutAttributes *> *array = [super layoutAttributesForElementsInRect:rect];
    
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (!CGRectIntersectsRect(visibleRect, attrs.frame))continue;
        //只对可见部分进行缩放
        NSLog(@"---%f", attrs.center.x);
        CGFloat itemCenterX = attrs.center.x;
        CGFloat scale = 2 - (ABS(itemCenterX - centerX) / (self.collectionView.frame.size.width * 0.5));
        attrs.transform3D = CATransform3DMakeScale(scale, scale, 1);
    }
    return array;
}


@end
