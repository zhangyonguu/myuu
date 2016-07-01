//
//  TRGreenView.m
//  hitTest练习
//
//  Created by tarena on 16/4/14.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRGreenView.h"

@implementation TRGreenView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@",self.class);
}

//-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    UIButton *button = self.superview.subviews[0];
//    CGPoint pointConverted = [self convertPoint:point toView:button];
//    if ([button pointInside:pointConverted withEvent:event]) {
//        return button;
//    }
//    return self;
//}
//修改hitTest或者pointInside
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    UIButton *button = self.superview.subviews[0];
    CGPoint pointConverted = [self convertPoint:point toView:button];
    if ([button pointInside:pointConverted withEvent:event]) {
        return NO;
    }
    return [super pointInside:point withEvent:event];

}
@end
