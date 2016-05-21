//
//  MLTitleButton.m
//  MLMyLottery
//
//  Created by tarena on 16/4/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MLTitleButton.h"

@implementation MLTitleButton

-(void)awakeFromNib
{
    self.imageView.contentMode = UIViewContentModeCenter;
//    self.imageView.backgroundColor = [UIColor greenColor];
//    self.titleLabel.backgroundColor = [UIColor purpleColor];
}

//不能使用self.titleLabel,因为会调用titleRectForContentRect造成死循环
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
    CGFloat titleW = [self.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.width;

    CGFloat titleH = contentRect.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = 30;
    CGFloat imageH = contentRect.size.height;
    CGFloat imageX = contentRect.size.width - imageW;
    CGFloat imageY = 0;
    return CGRectMake(imageX, imageY, imageW, imageH);
}
@end
