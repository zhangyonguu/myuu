//
//  MyPresentationController.m
//  自定义UIPresentationController
//
//  Created by tarena on 16/4/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyPresentationController.h"

//presentationController不能自定义动画
@implementation MyPresentationController

//-(CGRect)frameOfPresentedViewInContainerView
//{
//    NSLog(@"%s",__func__);
//
////   return CGRectMake(0, 50, self.containerView.frame.size.width, self.containerView.frame.size.height - 100);
//    return CGRectInset(self.containerView.bounds, 20, 50);
//
//}

-(void)presentationTransitionWillBegin
{
    
    NSLog(@"%s",__func__);
    //自定义动画需要自己控制整个过程
    self.presentedView.frame = self.containerView.bounds;
    [self.containerView addSubview:self.presentedView];
}

-(void)presentationTransitionDidEnd:(BOOL)completed
{
    NSLog(@"%s",__func__);
}

-(void)dismissalTransitionWillBegin
{
    NSLog(@"%s",__func__);
}


-(void)dismissalTransitionDidEnd:(BOOL)completed
{
    NSLog(@"%s",__func__);
    [self.presentedView removeFromSuperview];
}
@end
