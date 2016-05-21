//
//  UIImage+Tool.m
//  MLMyLottery
//
//  Created by tarena on 16/4/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "UIImage+Tool.h"

@implementation UIImage (Tool)
+(instancetype)imageWithResizableImageName:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    return image;
}
@end
