//
//  TRMouse.m
//  打地鼠
//
//  Created by tarena on 16/3/24.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRMouse.h"
#import "TRMouseDelegate.h"
@interface TRMouse()
{
    int count;
}
@end

@implementation TRMouse

//初始化，并开始计时生命
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        count = 3;
        self.backgroundColor = [UIColor redColor];
        [self setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateNormal];
        
        [self addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
        [NSThread detachNewThreadSelector:@selector(refresh) toTarget:self withObject:nil];
    }
    return self;
}


-(void)clicked
{
    [self removeFromSuperview];
    NSLog(@"%@被点掉",self);
   // self.tag = 1;
    [self.delegate changeScoreWithSuccess:YES];
}

//为每个TRMouse对象创建时钟
-(void)refresh
{
    for (int i = 0; i < 4; i++) {
        [self performSelectorOnMainThread:@selector(mouseDisappear) withObject:nil waitUntilDone:NO];
        [NSThread sleepForTimeInterval:1.0];
    }
}

//改变TRMouse上的计数，以及自动销毁
-(void)mouseDisappear
{
    self.titleLabel.text = [NSString stringWithFormat:@"%d",count];
    NSLog(@"%@ : count = %d",self, count);
    if (count == 0 && self.tag != 1) {
        [self removeFromSuperview];
        NSLog(@"%@消失",self);
        [self.delegate changeScoreWithSuccess:NO];
    }
   count--;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"Mouse no.%d",self->sn];
}

-(void)dealloc
{
    NSLog(@"%@ -------deallocated",self);
}
@end
