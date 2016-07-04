//
//  TRToolbar.h
//  xib的加载
//
//  Created by tarena on 16/4/7.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRToolbar : UIView
//xib中的控件必须是此处声明的类的父类（此处是UIView）或者其父类，如果不是，设置类名时会设置不上
+(instancetype)toolbar;
@end
