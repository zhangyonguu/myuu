//
//  ViewController.m
//  倒计时重写
//
//  Created by tarena on 16/3/30.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ViewController
- (IBAction)stop
{
    NSLog(@"%s",__func__);
    
    self.countLabel.text = @"4";
    
    [self pause];
}


- (IBAction)pause
{
    NSLog(@"%s",__func__);

    [self.timer invalidate];
}


- (IBAction)start
{
    NSLog(@"%s",__func__);
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

}

-(void)updateTimer:(NSTimer *)timer
{
    int count = [self.countLabel.text intValue];
    
    if (--count < 0) {
        [self pause];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"once again" message:@"go....." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"cancel.....");
        }];
        
        UIAlertAction *startAction = [UIAlertAction actionWithTitle:@"start" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self stop];
            [self start];
        }];
        
        [alert addAction:cancelAction];
        [alert addAction:startAction];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }else
    {
        self.countLabel.text = [NSString stringWithFormat:@"%d",count];
    }
        
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
