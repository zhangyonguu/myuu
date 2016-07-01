//
//  TRUIGestureRecognizer.m
//  摆动手势
//
//  Created by tarena on 16/3/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRUIGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>


CGFloat baseY;
CGFloat prevX;
NSInteger count;
NSUInteger prevDir;//定义手势方向

@implementation TRUIGestureRecognizer

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    baseY = point.y;
    prevX = point.x;
    count = 0;
    prevDir = 0;
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    if (fabs(currentPoint.y - baseY) > 10) {
        self.state = UIGestureRecognizerStateCancelled;
        return;
    }
    NSUInteger currentDirection = currentPoint.x > prevX ? 1 : 2;//1代表向右，2代表向左
    if (prevDir == 0) {
        prevDir = currentDirection;
    }
    if (prevDir != currentDirection) {
        count++;
        prevDir = currentDirection;
    }
    
    if (count >= _swingCount) {
        self.state = UIGestureRecognizerStateEnded;
    }
}

@end
