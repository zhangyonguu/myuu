//
//  PCBaseViewController.h
//  PregnantCare
//
//  Created by tarena on 16/6/3.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCCategory.h"

@interface PCBaseViewController : UIViewController

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSArray<PCCategory *> *categoriesArray;

@property (nonatomic, strong) PCCategory *currentCategory;

@property (nonatomic, strong) UIScrollView *contentScrollView;

@end
