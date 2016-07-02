//
//  PCMinePage.m
//  PregnantCare
//
//  Created by tarena on 16/6/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PCMinePage.h"
#import "PCSettings.h"
@interface PCMinePage ()
@property (weak, nonatomic) IBOutlet UIView *containView;

@end

@implementation PCMinePage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PCSettings *settings = [[PCSettings alloc] init];
    [self.containView addSubview:settings.view];
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
