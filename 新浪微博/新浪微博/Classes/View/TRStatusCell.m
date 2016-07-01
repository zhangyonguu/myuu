//
//  TRStatusCell.m
//  新浪微博
//
//  Created by tarena on 16/3/30.
//  Copyright © 2016年 tarena. All rights reserved.
//
/**1.创建自定义Cell，继承自UITableViewCell
   2.根据需求，确定控件
   3.用getter实例化控件,之创建并添加到视图,不处理位置
   4.定义一个模型属性，通过setter设置cell的显示*/

#import "TRStatusCell.h"
#import "TRStatus.h"
#import "TRStatusFrame.h"
#define kNameFont [UIFont systemFontOfSize:14]//姓名字体
#define kTextFont [UIFont systemFontOfSize:16]//正文字体

@interface TRStatusCell ()
@property (nonatomic, strong)UIImageView *iconView;
@property (nonatomic, strong)UILabel *nameView;
@property (nonatomic, strong)UIImageView *vipView;
@property (nonatomic, strong)UIImageView *pictureView;
@property (nonatomic, strong)UILabel *textView;
@end


@implementation TRStatusCell
-(UIImageView *)iconView
{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconView];
    }
    return _iconView;

}
-(UILabel *)nameView
{
    if (_nameView == nil) {
        _nameView = [[UILabel alloc] init];
        _nameView.font = kNameFont;
     //   _nameView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_nameView];
    }
    return _nameView;
}

-(UIImageView *)vipView
{
    if (_vipView == nil) {
        _vipView = [[UIImageView alloc] init];
        _vipView.image = [UIImage imageNamed:@"vip"];
        _vipView.hidden = YES;

        [self.contentView addSubview:_vipView];
    }
    return _vipView;
}

-(UIImageView *)pictureView
{
    if (_pictureView == nil) {
        _pictureView = [[UIImageView alloc] init];
        [self.contentView addSubview:_pictureView];
    }
    return _pictureView;
}

-(UILabel *)textView
{
    if (_textView == nil) {
        _textView = [[UILabel alloc] init];
        _textView.font = kTextFont;
        _textView.numberOfLines = 0;
        _textView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_textView];
    }
    return _textView;
}

-(void)setStatusFrame:(TRStatusFrame *)statusFrame
{
    
    _statusFrame = statusFrame;
    [self settingData];
    [self settingFrame];
}
//设置数据

-(void)settingData
{
    TRStatus *status = self.statusFrame.status;
    self.iconView.image = [UIImage imageNamed:status.icon];
    self.nameView.text = status.name;
    
    //优化：vip为可选参数
    if (status.vip) {
        self.vipView.hidden = NO;
        self.nameView.textColor = [UIColor redColor];
    }
    else
    {
        self.vipView.hidden = YES;//此句必须写，不然会使用从缓存池里面用可重用标识符取出的hidden数据。
        self.nameView.textColor = [UIColor blackColor];
    }
    
    self.textView.text = status.text;
    //当imageNamed：后面传入的值为nil是会有CUICatalog: Invalid asset name supplied: (null)错误
    
    //优化：picture是可选参数
    if(status.picture.length > 0){
        self.pictureView.hidden = NO;
    self.pictureView.image = [UIImage imageNamed:status.picture];
    }
    else
    {
        self.pictureView.hidden = YES;
    }

}

-(void)settingFrame
{
    self.iconView.frame = self.statusFrame.iconFrame;
    self.pictureView.frame = self.statusFrame.pictureFrame;
    self.textView.frame = self.statusFrame.textFrame;
    self.vipView.frame = self.statusFrame.vipFrame;
    self.nameView.frame = self.statusFrame.nameFrame;
    
}
@end
