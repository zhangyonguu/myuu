//
//  TRTgFooterView.m
//  团购
//
//  Created by tarena on 16/3/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRTgFooterView.h"

@interface TRTgFooterView ()
@property (weak, nonatomic) IBOutlet UIButton *loadMoreButton;
@property (weak, nonatomic) IBOutlet UIView *tipsView;

@end

@implementation TRTgFooterView

+(instancetype)footerView
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"TRTgFooterView" owner:nil options:nil];
    NSLog(@"%@",array);//只有一个对象
    return [array lastObject];
}

- (IBAction)loadMore
{
    NSLog(@"加载更多");
    NSLog(@"%g-----%g-----",self.loadMoreButton.frame.size.width,self.loadMoreButton.frame.size.height);
    //1.隐藏按钮
    self.loadMoreButton.hidden = YES;
    //2.显示提示视图
    self.tipsView.hidden = NO;
    
    
    //3.加载数据（从网络服务器加载，需要时间。。。）
    //view是用来显示数据的，用代理来实现！
           //判断代理是否实现了协议方法
        if([self.delegate respondsToSelector:@selector(tgFooterViewDidDownloadButtonClicked:)])
        {
            [self.delegate  tgFooterViewDidDownloadButtonClicked:self];
        }
    
    
    //4.加载完成数据
    
}

-(void)endRefresh
{
    self.loadMoreButton.hidden = NO;
    self.tipsView.hidden = YES;
}
@end
