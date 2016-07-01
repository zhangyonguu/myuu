//
//  MyNavigationController.m
//  通过手势移除控制器
//
//  Created by tarena on 16/4/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyNavigationController.h"

@interface MyNavigationController ()
//存放每一个控制器的全屏截图
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) UIImageView *lastVcView;
@property (nonatomic, strong) UIView *cover;

@end

@implementation MyNavigationController
-(UIImageView *)lastVcView
{
    if (_lastVcView == nil) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        _lastVcView = [[UIImageView alloc] init];
        _lastVcView.alpha = 0.5;
        _lastVcView.frame = window.bounds;
        [window insertSubview:self.lastVcView atIndex:0];
        [window insertSubview:self.cover aboveSubview:self.lastVcView];
    }
    return _lastVcView;
}

-(UIView *)cover
{
    if (_cover == nil) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        _cover = [[UIView alloc] init];
        _cover.backgroundColor = [UIColor grayColor];
        _cover.alpha = 0.5;
        _cover.frame = window.bounds;
    }
    return _cover;
}

-(NSMutableArray *)images
{
    if (_images == nil) {
        self.images = [[NSMutableArray alloc] init];
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//naviVC的view显示的当前push出来VC的view
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(draging:)];
    [self.view addGestureRecognizer:gesture];
}
/**
 bug:保存的是加载时的图片，不是跳转前的图片
 
 */
-(void)draging:(UIPanGestureRecognizer *)gesture
{
    if (self.viewControllers.count <= 1) {
        return;
    }
    CGFloat tx = [gesture translationInView:self.view].x;
    if (tx < 0) {
        //不允许左移
        return;
    }
    if(gesture.state == UIGestureRecognizerStateEnded ||gesture.state == UIGestureRecognizerStateCancelled)
    {
        CGFloat x = self.view.frame.origin.x;
        if (x >= self.view.frame.size.width * 0.5) {
            [UIView animateWithDuration:0.25 animations:^{
                self.view.transform = CGAffineTransformMakeTranslation(self.view.frame.size.width, 0);
            } completion:^(BOOL finished) {
                [self popViewControllerAnimated:NO];
                [self.images removeLastObject];
                [self.lastVcView removeFromSuperview];
                [self.cover removeFromSuperview];
                self.view.transform = CGAffineTransformIdentity;
            }];
        }
        else
        {
            [UIView animateWithDuration:0.25 animations:^{
                self.view.transform = CGAffineTransformIdentity;
            }];
        };
        
    }
    else
    {
    //移动view
    self.view.transform = CGAffineTransformMakeTranslation(tx, 0);
//添加截图到最后面
//    NSLog(@"%g",[gesture translationInView:self.view].x);
    self.lastVcView.image = self.images[self.images.count - 2];
    }
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    [self screenShot];
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%s",__func__);
    NSLog(@"%@",self.view.subviews);
    if (self.images.count > 0) {
        return;
    }
    [self screenShot];
}

-(void)screenShot
{
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, YES, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    //不会获取状态栏
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    [self.images addObject:image];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
