//
//  UIImageView+roundImage.m
//  酷跑
//
//  Created by tarena on 16/6/15.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "UIImageView+roundImage.h"

@implementation UIImageView (roundImage)
- (void)setRoundLayer{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.bounds.size.width * 0.5;
    self.layer.borderWidth = 2;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
}
@end








