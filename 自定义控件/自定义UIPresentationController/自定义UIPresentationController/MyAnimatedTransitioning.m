//
//  MyAnimatedTransitioning.m
//  自定义UIPresentationController
//
//  Created by tarena on 16/4/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyAnimatedTransitioning.h"
#import "UIView+Extension.h"
@implementation MyAnimatedTransitioning

#pragma mark UIViewControllerAnimatedTransitioning

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 2.0;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    NSLog(@"%s",__func__);
    //此处完成动画
    //   UITransitionContextToViewKey
    //   UITransitionContextFromViewKey
    if (self.presented) {
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        toView.layer.transform = CATransform3DMakeRotation(M_PI_2, -1, 1, 0);
//        toView.x = toView.width;
        [UIView animateWithDuration:2.0 animations:^{
//            toView.x = 0;
            toView.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
            //必须说明动画已完成
            [transitionContext completeTransition:YES];
        }];
    }
    else
    {
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];

        [UIView animateWithDuration:2.0 animations:^{
//            fromView.x = fromView.width;
            fromView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 1, -1, 0);
        } completion:^(BOOL finished) {
            //必须说明动画已完成
            [transitionContext completeTransition:YES];
        }];

    }
    
}

@end
