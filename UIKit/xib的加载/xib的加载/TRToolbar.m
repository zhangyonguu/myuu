//
//  TRToolbar.m
//  xib的加载
//
//  Created by tarena on 16/4/7.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRToolbar.h"

@interface TRToolbar ()

@end
@implementation TRToolbar




+(instancetype)toolbar
{
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"TRToolbar" owner:nil options:nil];
    NSLog(@"%@",objs);
    return [objs firstObject];
}

@end
