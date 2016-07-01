//
//  MyBar.m
//  NSKeyArchiver妙用
//
//  Created by tarena on 16/5/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyBar.h"

@implementation MyBar

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.layer.cornerRadius = 20;
    //默认是opaque black
    self.layer.borderColor = [UIColor blackColor].CGColor;
    //默认是0，如果要有特殊border显示，必须修改borderWidth
    self.layer.borderWidth = 5;
    self.backgroundColor = [UIColor greenColor];
}

@end
