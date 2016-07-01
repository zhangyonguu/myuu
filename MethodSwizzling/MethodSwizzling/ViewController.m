//
//  ViewController.m
//  MethodSwizzling
//
//  Created by tarena on 16/5/19.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "NSMutableArray+LoggingAddObject.h"
#import "TestObject.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    [arrayM addObject:@1];
    
    [arrayM logAddObject:@2];
    
    NSLog(@"%@",arrayM);
    
    
    TestObject *test = [[TestObject alloc] init];
    
    [test MissMethod];
    
    [test addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    test.name = @"he";
    
    NSLog(@"%@",self);
    // Do any additional setup after loading the view, typically from a nib.
}

@end
