//
//  MyAnimatedTransitioning.h
//  自定义UIPresentationController
//
//  Created by tarena on 16/4/27.
//  Copyright © 2016年 tarena. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface MyAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) BOOL presented;
@end
