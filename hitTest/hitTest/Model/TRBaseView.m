//
//  TRBaseView.m
//  hitTest
//
//  Created by tarena on 16/4/12.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRBaseView.h"

@implementation TRBaseView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"----%@",self.class);
//   NSLog(@"++++%s",__func__);//打印出的方法的调用者是方法定义所在的类，不是真正调用者的类
    
}

/**
 1.看自己能否接收事件（从窗口开始传递起），如果不能return nil；自己不能接收事件，则无法传递给子控件
 2.若能则判断点是不是在窗口上，如果能则意味着自己可以接收并响应时间
 3.传递下去，即调用hitTest方法
 */

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
   // NSLog(@"%@ hitTest",self.class);
    //1.判断自己能否接收事件
    /**不能响应的3种情况
     1.关闭了用户交互
     2.隐藏了
     3.alpha <= 0.01
     */
    if (self.userInteractionEnabled == NO || self.hidden == YES || self.alpha <= 0.01) {
        return nil;
    }
    //2.判断点在不在当前控件上
    if (![self pointInside:point withEvent:event]) {
        return nil;
    }
    
    //3.从后往前，遍历子控件，找有没有比自己更适合的子控件
    NSInteger count = self.subviews.count;
    for (NSInteger i = count - 1; i >= 0; i--) {
//        NSLog(@"%ld",i);
        UIView *childView = self.subviews[i];
        //转换坐标系,把自己坐标系上的店转换成子控件坐标系上的点
        CGPoint childPoint = [self convertPoint:point toView:childView];
        //这一步会找出该子控件以及其递归子控件中最合适的view
        UIView *fitView = [childView hitTest:childPoint withEvent:event];
        if (fitView) {
            return fitView;
        }
    }
    //没有找到比自己更合适的
    return self;
}

@end
