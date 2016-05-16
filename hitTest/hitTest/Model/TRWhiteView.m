//
//  TRWhiteView.m
//  hitTest
//
//  Created by tarena on 16/4/14.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRWhiteView.h"

@implementation TRWhiteView
//当事件传递到一个View时，这个View就会调用，去寻找最适合的view（自己或者子类或者都不能）
//系统会调用2次hitTest方法（测试结果）,原因不明
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *fitView = [super hitTest:point withEvent:event];
    NSLog(@"%@",fitView);
    NSLog(@"%@---%@",self.class ,NSStringFromCGPoint(point));
    return fitView;
   // return self;
}

//判断点在不在方法调用者的坐标系上
//point:是方法调用者坐标系上的点
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    return NO;
}

@end
