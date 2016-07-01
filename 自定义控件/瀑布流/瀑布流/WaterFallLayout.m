//
//  WaterFallLayout.m
//  瀑布流
//
//  Created by tarena on 16/5/3.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "WaterFallLayout.h"


@interface WaterFallLayout ()
/**用来存储每一列最大的Y值*/
@property (nonatomic, strong) NSMutableDictionary *maxYDict;
@property (nonatomic, strong) NSMutableArray *attrsArray;

@end

@implementation WaterFallLayout

-(NSMutableArray *)attrsArray
{
    if (_attrsArray == nil) {
        self.attrsArray = [[NSMutableArray alloc] init];
    }
    return _attrsArray;
}

-(NSMutableDictionary *)maxYDict
{
    if (!_maxYDict) {
        self.maxYDict = [NSMutableDictionary dictionary];
        for (int i = 0; i < self.columnCount; i++) {
            NSString *column = [NSString stringWithFormat:@"%d",i];
            self.maxYDict[column] = @0;
        }
    }
    return _maxYDict;
}

-(void)prepareLayout
{
//    NSLog(@"%s",__func__);
    [super prepareLayout];
    //清空最大Y值
    for (int i = 0; i < self.columnCount; i++) {
        NSString *column = [NSString stringWithFormat:@"%d",i];
        self.maxYDict[column] = @(self.sectionInset.top);
    }
    //计算所有cell的属性
    [self.attrsArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int  i = 0; i < count; i++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attrsArray addObject:attrs];
    }

    
}
-(CGSize)collectionViewContentSize
{
    __block NSString *maxColumn = @"0";
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString * column, NSNumber *maxY, BOOL * _Nonnull stop) {
        if ([maxY floatValue] > [self.maxYDict[maxColumn] floatValue]) {
            maxColumn = column;
        }
    }];
    return CGSizeMake(0, [self.maxYDict[maxColumn] floatValue] + self.sectionInset.bottom);
}

-(instancetype)init
{
    if (self = [super init]) {
        self.columnMargin = 10;
        self.rowMargin = 10;
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.columnCount = 3;
    }
    return self;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    __block NSString *minColumn = @"0";
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString * column, NSNumber *maxY, BOOL * _Nonnull stop) {
        if ([maxY floatValue] < [self.maxYDict[minColumn] floatValue]) {
            minColumn = column;
        }
    }];
    /**计算size*/
    CGFloat width = (self.collectionView.frame.size.width - self.sectionInset.right - self.sectionInset.left - (self.columnCount - 1) * self.columnMargin)/self.columnCount;
    CGFloat height = [self.delegate waterFallLayout:self heightForWidth:width atIndexPath:indexPath];
    /**计算位置*/
    CGFloat x = self.sectionInset.left + [minColumn intValue] * (width + self.columnMargin);
    CGFloat y = [self.maxYDict[minColumn] floatValue]+ self.rowMargin;
    /**更新这一列最大Y值*/
    self.maxYDict[minColumn] = @(y + height);
    
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.frame = CGRectMake(x, y, width, height);
    return attrs;
}

//会执行2次
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
//    NSLog(@"%s",__func__);
    return self.attrsArray;
}
@end
