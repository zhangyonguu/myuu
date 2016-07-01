//
//  MyTransition.h
//  自定义UIPresentationController
//
//  Created by tarena on 16/4/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Singleton.h"
@interface MyTransition : NSObject<UIViewControllerTransitioningDelegate>
SingletonH(Transition)
@end
