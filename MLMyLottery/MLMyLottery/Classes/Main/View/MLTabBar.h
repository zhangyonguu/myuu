//
//  MLTabBar.h
//  MLMyLottery
//
//  Created by tarena on 16/4/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MLTabBarBlock)(int selected);

@class MLTabBar;
@protocol MLTabBarDelegate <NSObject>

-(void)tabBar:(MLTabBar *)tabBar didSelectedIndex:(int)index;

@end
@interface MLTabBar : UIView

//@property (nonatomic, copy) MLTabBarBlock block;

@property (nonatomic, weak) id <MLTabBarDelegate> delegate;

-(void)addTabBarButtonWithName:(NSString *)name andSelName:(NSString *)selName;
@end
