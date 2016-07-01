//
//  MyView.m
//  触摸
//
//  Created by tarena on 16/4/13.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyView.h"

@implementation MyView

//只能在自定义类中重写
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"MyView is touched");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
