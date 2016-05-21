//
//  MLTabBarButton.m
//  MLMyLottery
//
//  Created by tarena on 16/4/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MLTabBarButton.h"

@implementation MLTabBarButton

-(void)setHighlighted:(BOOL)highlighted
{
    //NSLog(@"%s",__func__);
    //禁用系统自带点高亮会先从高亮到低亮到高亮的做法（根据输出怀疑变成了高亮->高亮->高亮）
   // return [super setHighlighted:highlighted];
}

@end
