//
//  ViewController.m
//  打地鼠
//
//  Created by tarena on 16/3/24.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "TRMouse.h"
#import "TRMouseDelegate.h"
@interface ViewController ()

@property (strong, nonatomic) IBOutlet UILabel *successLabel;
@property (strong, nonatomic) IBOutlet UILabel *failLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NSThread detachNewThreadSelector:@selector(addMouse) toTarget:self withObject:nil];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)addMouse
{
    for (int i = 1; ; i++) {
        [NSThread sleepForTimeInterval:1];//每隔1s加一个
        [self performSelectorOnMainThread:@selector(addMouseView:) withObject:@(i) waitUntilDone:NO];
        if([self.failLabel.text intValue] == 5)
        {
         //   exit(0);//失败次数为5时，退出程序。
        }
    }
}

-(void)addMouseView:(NSString *)sn
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    TRMouse *mouse = [[TRMouse alloc] initWithFrame:CGRectMake(arc4random()%(int)(screenSize.width - 30), 50 + arc4random()%(int)(screenSize.height - 80), 30, 30)];
    mouse->sn = [sn intValue];
    mouse.delegate = self;
    [self.view addSubview:mouse];
}

-(void)changeScoreWithSuccess:(BOOL)isSuccess
{
    switch ((int)isSuccess) {
        case 0:
        {//“{”一定要写，不然count的作用域不明确
            int count = [self.failLabel.text intValue];
            self.failLabel.text = [NSString stringWithFormat:@"%d",++count];
        }
           
            break;
            
        case 1:
        {
            int count = [self.successLabel.text intValue];
            self.successLabel.text = [NSString stringWithFormat:@"%d",++count];
        }
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];

}

@end
