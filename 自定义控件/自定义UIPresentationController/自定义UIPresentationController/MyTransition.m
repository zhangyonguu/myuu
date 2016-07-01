//
//  MyTransition.m
//  自定义UIPresentationController
//
//  Created by tarena on 16/4/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyTransition.h"
#import "MyPresentationController.h"
#import "MyAnimatedTransitioning.h"


@implementation MyTransition
SingletonM(Transition)
#pragma mark UIViewControllerTransitioningDelegate
-(UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return [[MyPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

//返回展示时的动画控制器
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    MyAnimatedTransitioning *animated = [[MyAnimatedTransitioning alloc] init];
    animated.presented = YES;
    return animated;
}

//返回销毁时的动画控制器
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    MyAnimatedTransitioning *animated = [[MyAnimatedTransitioning alloc] init];
    animated.presented = NO;
    return animated;
}


@end
