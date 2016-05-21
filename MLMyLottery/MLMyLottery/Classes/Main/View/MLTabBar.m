//
//  MLTabBar.m
//  MLMyLottery
//
//  Created by tarena on 16/4/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MLTabBar.h"
#import "MLTabBarButton.h"

@interface MLTabBar ()
@property (nonatomic, weak) MLTabBarButton *selectedButton;//为什么用weak？？？

@end

@implementation MLTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
    if (self) {
  
    }
    return self;
}

-(void)addTabBarButtonWithName:(NSString *)name andSelName:(NSString *)selName
{
    MLTabBarButton *button = [MLTabBarButton buttonWithType:UIButtonTypeCustom];
    
    [button setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    
    //注意highlighted和selected区别，highlighted是指按下去时，selected是指按下去又上来时
    [button setBackgroundImage:[UIImage imageNamed:selName] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = self.subviews.count;
    [self addSubview:button];
    
    if (button.tag == 0) {
        [self buttonClicked:button];
    }

}

-(void)buttonClicked:(MLTabBarButton *)sender
{
    //先取消原选中
    _selectedButton.selected = NO;
    
    sender.selected = YES;
    
    _selectedButton = sender;
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedIndex:)]) {
        [self.delegate tabBar:self didSelectedIndex:(int)sender.tag];
    }
    

    
    //切换控制器
//    if (_block) {
//        _block((int)sender.tag);
//    }
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat buttonWidth = self.bounds.size.width / self.subviews.count;
    CGFloat buttonHeight = self.bounds.size.height;
    for (int i = 0; i < self.subviews.count; i++) {
        MLTabBarButton *button = self.subviews[i];
        button.frame = CGRectMake(i * buttonWidth, 0, buttonWidth, buttonHeight);
    }

}
@end
