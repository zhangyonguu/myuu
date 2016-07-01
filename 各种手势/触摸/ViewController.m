//
//  ViewController.m
//  触摸
//
//  Created by tarena on 16/4/13.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "MyView.h"

@interface ViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    panGesture.delegate = self;
    
    [self.imageView addGestureRecognizer:panGesture];
    
    
    
    
}



#warning tap
-(void)addTap
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    [self.imageView addGestureRecognizer:tapGesture];
    //[self.label addGestureRecognizer:tapGesture];
    
    tapGesture.delegate = self;
}

-(void)addTapToCustomUIView//自定义视图加手势识别器
{
    //手势识别器在touchesBegan执行之后执行，与touchesBegan独立
    MyView *view = [[MyView alloc] initWithFrame:CGRectMake(100, 40, 100, 40)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    tapGesture.delegate = self;
    [view addGestureRecognizer:tapGesture];
    //[self.label addGestureRecognizer:tapGesture];
}

#warning longPress
-(void)addLongPress
{
    //长按默认执行两次方法，在生效之后和结束之后各执行一次
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    longPressGesture.allowableMovement = 1.0;
    longPressGesture.minimumPressDuration = 2.0;
    longPressGesture.delegate = self;
    [self.imageView addGestureRecognizer:longPressGesture];
}

#warning swipe
-(void)addSwipe
{
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    //默认是右边，一个手势只能识别一个方向
    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    swipeGesture.delegate = self;
    [self.imageView addGestureRecognizer:swipeGesture];
}

#warning rotation
-(void)addRotation
{
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    
   // rotationGesture.delegate = self;
    rotationGesture.delegate = self;
    [self.imageView addGestureRecognizer:rotationGesture];

}

#warning pinch
-(void)addPinch
{
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    pinchGesture.delegate = self;
    [self.imageView addGestureRecognizer:pinchGesture];
}

//多个手势识别器的代理都为self时，都会执行这个
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{

   CGPoint currentPoint = [touch locationInView:self.imageView];
   
    NSLog(@"-------%@---",NSStringFromCGPoint(currentPoint));
//    
//    if (0 < currentPoint.y && currentPoint.y < self.imageView.frame.size.height * 0.5) {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
    return YES;
   
}

//默认是不支持多个手势的，当你使用一个手势的时候就会调用
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    NSLog(@"Simultaneously");
    return YES;
}

-(void)tap:(UITapGestureRecognizer *)gesture
{
    NSLog(@"tapped");
}

-(void)longPress:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        NSLog(@"longPressedBegan");
    }
    else if(gesture.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"longPressedEnded");
    }
}

-(void)swipe:(UISwipeGestureRecognizer *)gesture
{
    NSLog(@"swiped");
}

-(void)rotation:(UIRotationGestureRecognizer *)gesture
{
//    NSLog(@"swiped");
    NSLog(@"%f",gesture.rotation);
  //  self.imageView.transform = CGAffineTransformMakeRotation(gesture.rotation);
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, gesture.rotation);
    gesture.rotation = 0;
    NSLog(@"%@",NSStringFromCGRect(self.imageView.frame));
}

-(void)pinch:(UIPinchGestureRecognizer *)gesture
{
    NSLog(@"pinched");
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, gesture.scale, gesture.scale);
    gesture.scale = 1;
}

-(void)pan:(UIPanGestureRecognizer *)gesture
{
    CGPoint translation = [gesture translationInView:self.imageView];
   
    
    self.imageView.transform = CGAffineTransformTranslate(self.imageView.transform, translation.x, translation.y);
    
    [gesture setTranslation:CGPointZero inView:self.imageView];
    
     NSLog(@"panned----%@",NSStringFromCGPoint(translation));
}
@end
