//
//  ViewController.m
//  UIPopoverPresentationController
//
//  Created by tarena on 16/4/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISlider *slide;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *item;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    SecondViewController *vc = [[SecondViewController alloc] init];
    //注意此处vc并没有presented，presentationController是懒加载的，调用self.presentation时会创建presentationController并将vc的modalPresentationStyle属性设置为默认值UIModalPresentationFullScreen，若调用self.popoverPresentationController则不同
    NSLog(@"%@  --- %@",self.presentationController,vc.popoverPresentationController);
 //UIPopoverController只能用在iPad上
//    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:vc];
//    
//    [popover presentPopoverFromRect:self.slide.bounds inView:self.slide permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    vc.modalPresentationStyle = UIModalPresentationFormSheet;
  //  vc.popoverPresentationController.sourceView = self.slide;
    vc.popoverPresentationController.barButtonItem = self.item;
    /**
     1.只要调用present，首先创建一个UIPresentationController，然后由UIPresentationController管理控制器的切换
     */
      //注意，presented是self的navigationController（后面的打印验证）
    [self presentViewController:vc animated:YES completion:nil];
    
    NSLog(@"%@----%@",self.popoverPresentationController, self.presentationController);
    NSLog(@"%@___%@", vc.popoverPresentationController,vc.presentationController);
  
    NSLog(@"%@+++++%@----%@---%@",self,vc.presentationController.presentingViewController,self.presentationController.presentedViewController, self.navigationController);
    
}
@end
