//
//  ViewController.m
//  队列组
//
//  Created by tarena on 16/4/5.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"

/**
 1.分别下载2张图片
 2.合并2张图片
 3.显示到一个imageView身上
 */
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIImage *image1;
@property (nonatomic, strong) UIImage *image2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1.队列组
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    __block UIImage *image1 = nil;
    dispatch_group_async(group, queue, ^{
        NSURL *url1 = [NSURL URLWithString:@"http://tmooc.cn/web/library/tu_new/UID/Web界面设计/自适应banner焦点图案例.jpg"];
        NSData *data1 = [NSData dataWithContentsOfURL:url1];
        
        image1 = [UIImage imageWithData:data1];
    });
    
    __block UIImage *image2 = nil;
    dispatch_group_async(group, queue, ^{
        //下载第二张
        NSURL *url2 = [NSURL URLWithString:@"http://tmooc.cn/web/library/tu_new/UID/UI设计/标志设计-界美装饰.jpg"];
        NSData *data2 = [NSData dataWithContentsOfURL:url2];
        image2 = [UIImage imageWithData:data2];

    });
    
    //等组里所有任务执行完毕，再执行notify
    dispatch_group_notify(group, queue, ^{
        //开启一个位图上下文
        UIGraphicsBeginImageContextWithOptions(image1.size, NO, 0.0);
        //绘制第一张图片
        [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
        //绘制第二张图片
        [image2 drawInRect:CGRectMake(0, 0, image2.size.width * 0.5, image2.size.height * 0.5)];
        //得到上下文中的图片
        UIImage *fullImage = UIGraphicsGetImageFromCurrentImageContext();
        //结束上下文
        UIGraphicsEndImageContext();
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = fullImage;
        });

    });
    

}

-(void)bindImages
{
    if (self.image1 == nil || nil == self.image2) {
        return;
    }
    //合并图片
    //开启一个位图上下文
    UIGraphicsBeginImageContextWithOptions(self.image1.size, NO, 0.0);
    //绘制第一张图片
    [self.image1 drawInRect:CGRectMake(0, 0, self.image1.size.width, self.image1.size.height)];
    //绘制第二张图片
    [self.image2 drawInRect:CGRectMake(0, 0, self.image2.size.width * 0.5, self.image2.size.height * 0.5)];
    //得到上下文中的图片
    UIImage *fullImage = UIGraphicsGetImageFromCurrentImageContext();
    //结束上下文
    UIGraphicsEndImageContext();
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.imageView.image = fullImage;
    });
}




-(void)test1
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //下载第一张
        NSURL *url1 = [NSURL URLWithString:@"http://tmooc.cn/web/library/tu_new/UID/Web界面设计/自适应banner焦点图案例.jpg"];
        NSData *data1 = [NSData dataWithContentsOfURL:url1];
        
        UIImage *image1 = [UIImage imageWithData:data1];
        
        //下载第二张
        NSURL *url2 = [NSURL URLWithString:@"http://tmooc.cn/web/library/tu_new/UID/UI设计/标志设计-界美装饰.jpg"];
        NSData *data2 = [NSData dataWithContentsOfURL:url2];
        UIImage *image2 = [UIImage imageWithData:data2];
        
        //合并图片
        //开启一个位图上下文
        UIGraphicsBeginImageContextWithOptions(image1.size, NO, 0.0);
        //绘制第一张图片
        [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
        //绘制第二张图片
        [image2 drawInRect:CGRectMake(0, 0, image2.size.width * 0.5, image2.size.height * 0.5)];
        //得到上下文中的图片
        UIImage *fullImage = UIGraphicsGetImageFromCurrentImageContext();
        //结束上下文
        UIGraphicsEndImageContext();
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = fullImage;
        });
        
    });
}

-(void)test2
{
    //下载第一张
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url1 = [NSURL URLWithString:@"http://tmooc.cn/web/library/tu_new/UID/Web界面设计/自适应banner焦点图案例.jpg"];
        NSData *data1 = [NSData dataWithContentsOfURL:url1];
        UIImage *image1 = [UIImage imageWithData:data1];
        [self bindImages];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //下载第二张
        NSURL *url2 = [NSURL URLWithString:@"http://tmooc.cn/web/library/tu_new/UID/UI设计/标志设计-界美装饰.jpg"];
        NSData *data2 = [NSData dataWithContentsOfURL:url2];
        UIImage *image2 = [UIImage imageWithData:data2];
        [self bindImages];
    });
}
@end
