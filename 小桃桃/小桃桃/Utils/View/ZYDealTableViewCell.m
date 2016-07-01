//
//  ZYDealTableViewCell.m
//  小桃桃
//
//  Created by tarena on 16/5/26.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZYDealTableViewCell.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"

@interface ZYDealTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *dealImage;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *previousPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *discountButton;
@property (weak, nonatomic) IBOutlet UILabel *soldLabel;

@end

@implementation ZYDealTableViewCell

-(void)setDeal:(ZYDeal *)deal
{
    _deal = deal;
    
    self.descLabel.text = deal.title;
    self.currentPriceLabel.text = [NSString stringWithFormat:@"¥%g",[deal.current_price floatValue]];
    self.previousPriceLabel.text = [NSString stringWithFormat:@"原价:¥%g",[deal.list_price floatValue]];
    self.soldLabel.text = [NSString stringWithFormat:@"已售%@",deal.purchase_count];
    [self.discountButton setTitle:[NSString stringWithFormat:@"%.0f%%折扣", [deal.current_price floatValue] / [deal.list_price floatValue] * 100] forState:UIControlStateNormal];
    [self.dealImage sd_setImageWithURL:[NSURL URLWithString:deal.s_image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
