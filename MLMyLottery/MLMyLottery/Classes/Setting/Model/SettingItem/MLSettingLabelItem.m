//
//  MLSettingLabelItem.m
//  MLMyLottery
//
//  Created by tarena on 16/4/22.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MLSettingLabelItem.h"
#import "MLSaveDataTool.h"

@implementation MLSettingLabelItem

-(void)setText:(NSString *)text
{
    _text = text;
    //设置时自动存储起来,外界不知道里面做了什么
    [MLSaveDataTool setObject:text forKey:self.title];
}

-(void)setTitle:(NSString *)title
{
    [super setTitle:title];
    //将取数据动作封装到模型中
    _text = [MLSaveDataTool objectForKey:self.title];
}
@end
