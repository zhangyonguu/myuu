//
//  MLProductCell.m
//  MLMyLottery
//
//  Created by tarena on 16/4/22.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MLProductCell.h"
#import "MLProduct.h"

@interface MLProductCell()
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productLabel;

@end
@implementation MLProductCell

-(void)setProduct:(MLProduct *)product
{
    _product = product;
    _productImage.image = [UIImage imageNamed:_product.icon];
    _productLabel.text = _product.title;
}

-(void)awakeFromNib
{
    _productImage.layer.cornerRadius = 10;
    _productImage.clipsToBounds = YES;
    //_productImage.layer.masksToBounds = YES;
}
@end
