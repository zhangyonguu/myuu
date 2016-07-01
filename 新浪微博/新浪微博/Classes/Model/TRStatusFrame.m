//
//  TRStatusFrame.m
//  新浪微博
//
//  Created by tarena on 16/3/31.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRStatusFrame.h"
#import "TRStatus.h"
#import "NSString+tool.h"
#define kNameFont [UIFont systemFontOfSize:14]//姓名字体
#define kTextFont [UIFont systemFontOfSize:16]//正文字体

@implementation TRStatusFrame

-(void)setStatus:(TRStatus *)status
{
    _status = status;
    CGFloat padding = 10;
    //1.头像
    CGFloat iconX = padding;
    CGFloat iconY = padding;
    CGFloat iconW = 30;
    CGFloat iconH = 30;
    self.iconFrame = CGRectMake(iconX,iconY,iconW,iconH);
    
    //2.姓名
    /**iOS7新增方法，boundingRectWithSize:计算给定文本字符串所占区域,返回一个x,y等于0的CGRect,自动计算Width和Height，如果要计算多行的准确高度，需要传入NSStringDrawingUsesLineFragmentOrigin选项，dict用于指定字体相关属性的字典，在NSAttributedString.h中，（在UIKit.h中搜索attribute就出来了）*/
    
    
    //   UIFont *font = [UIFont systemFontOfSize:14];
    NSDictionary *nameDict = @{NSFontAttributeName:kNameFont};
    CGRect nameFrame =  [self.status.name boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:nameDict context:nil];
    nameFrame.origin.x = CGRectGetMaxX(self.iconFrame) + padding;
    nameFrame.origin.y = padding + (self.iconFrame.size.height - nameFrame.size.height)*0.5;
    self.nameFrame = nameFrame;
    
    //3.vip
    CGFloat vipX = CGRectGetMaxX(self.nameFrame) + padding;
    CGFloat vipY = self.nameFrame.origin.y;
    CGFloat vipW = 14;
    CGFloat vipH = 14;
    self.vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    
    //4.正文
    NSDictionary *textDict = @{NSFontAttributeName: kTextFont};
//    CGRect textFrame = [self.status.text boundingRectWithSize:CGSizeMake(380, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDict context:nil];
    CGRect textFrame = [self.status.text textRectWithSiza:CGSizeMake(380, CGFLOAT_MAX) attributes:textDict];
    textFrame.origin.x = padding;
    textFrame.origin.y = CGRectGetMaxY(self.iconFrame) + padding;
    self.textFrame = textFrame;
    
    //配图
    if(self.status.picture.length > 0)
    {
        CGFloat picX = 10;
        CGFloat picY = CGRectGetMaxY(self.textFrame) + padding;
        CGFloat picW = 100;
        CGFloat picH = 100;
        self.pictureFrame = CGRectMake(picX, picY, picW, picH);
        
        self.cellHeight = CGRectGetMaxY(self.pictureFrame) + padding;
    }
    
    else
    {
        self.cellHeight = CGRectGetMaxY(self.textFrame) + padding;
    }
}


+(NSArray *)statusFrames
{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"statuses.plist" ofType:nil]];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        
        TRStatus *status = [TRStatus statusWithDict:dict];
        
        TRStatusFrame *statusFrame = [[TRStatusFrame alloc] init];
        
        [statusFrame setStatus:status];
        
        [arrayM addObject:statusFrame];
    }
    return arrayM;

}
@end
