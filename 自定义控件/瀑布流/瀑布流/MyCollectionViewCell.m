 //
//  MyCollectionViewCell.m
//  瀑布流
//
//  Created by tarena on 16/5/3.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import "HMShop.h"
#import "UIImageView+WebCache.h"

@interface MyCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@end

@implementation MyCollectionViewCell

-(void)setShop:(HMShop *)shop
{
    _shop = shop;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    
    self.priceLabel.text = shop.price;
}
@end
