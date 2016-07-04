//
//  TRTgCell.m
//  团购
//
//  Created by tarena on 16/3/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRTgCell.h"
#import "TRTg.h"

@interface TRTgCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyCountLabel;

@end

@implementation TRTgCell

//隐藏Tg内部细节

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    //1.可重用标识符
    NSString *ID = @"cell";
    //2.查询缓存池
    TRTgCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //3.如果没有查询到，创建
    if (cell == nil) {
        NSLog(@"加载xib");
        //从xib加载自定义视图
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TRTgCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
}

-(void)setTg:(TRTg *)tg
{
    _tg = tg;
    self.titleLabel.text = tg.title;
    self.iconView.image = [UIImage imageNamed:tg.icon];
    self.priceLabel.text = tg.price;
    self.buyCountLabel.text = tg.buyCount;
}

//从xib加载之后，自动被调用,如果使用纯代码，不会被调用
- (void)awakeFromNib {
    // Initialization code
    NSLog(@"load xib");
  //  self.contentView.backgroundColor = [UIColor clearColor];
}

//cell被选中或者被取消选中时都会被调用
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    //如果是自定义cell控件，所有的子控件都应该添加到contentView中
   if(selected)
   {
       self.contentView.backgroundColor = [UIColor redColor];
   }
    else
    {
        self.contentView.backgroundColor = [UIColor blueColor];
    }
}

@end
