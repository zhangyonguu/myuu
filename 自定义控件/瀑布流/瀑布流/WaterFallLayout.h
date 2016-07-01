//
//  WaterFallLayout.h
//  瀑布流
//
//  Created by tarena on 16/5/3.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterFallLayout;
@protocol  WaterFallLayoutDelegate <NSObject>

-(CGFloat)waterFallLayout:(WaterFallLayout *)waterFallLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

@end
@interface WaterFallLayout : UICollectionViewLayout
@property (nonatomic, assign) UIEdgeInsets sectionInset;
@property (nonatomic, assign) CGFloat columnMargin;
@property (nonatomic, assign) CGFloat rowMargin;
@property (nonatomic, assign) int columnCount;

@property (nonatomic, weak) id<WaterFallLayoutDelegate> delegate;
@end
