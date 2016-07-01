//
//  NSString+tool.m
//  新浪微博
//
//  Created by tarena on 16/3/31.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "NSString+tool.h"

@implementation NSString (tool)
-(CGRect)textRectWithSiza:(CGSize)size attributes:(NSDictionary *)attributes
{
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
}
@end
