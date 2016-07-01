//
//  ViewController.m
//  摆动手势
//
//  Created by tarena on 16/3/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "TRUIGestureRecognizer.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *gv;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.label.numberOfLines = 0;
    self.gv.layer.borderWidth = 2;
    self.gv.layer.cornerRadius = 6;
    self.gv.userInteractionEnabled = YES;
    self.gv.multipleTouchEnabled = YES;
    
    TRUIGestureRecognizer *gesture = [[TRUIGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwing:)];
    gesture.swingCount = 2;
    [self.gv addGestureRecognizer:gesture];
    
}

-(void)handleSwing:(TRUIGestureRecognizer *)gesture
{
    NSUInteger touchNum = gesture.numberOfTouches;
    self.label.text = [NSString stringWithFormat:@"用户使用%lu个手指进行摆动",touchNum];
    [self.label performSelector:@selector(setText:) withObject:@"清除" afterDelay:2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
