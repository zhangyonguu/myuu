//
//  MyImageCell.m
//  自定义UICollectionView布局
//
//  Created by tarena on 16/4/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyImageCell.h"

@interface MyImageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation MyImageCell

-(void)setImageName:(NSString *)imageName
{
    _imageName = [imageName copy];
    self.imageView.image = [UIImage imageNamed:_imageName];
}
- (void)awakeFromNib {
    self.imageView.layer.borderWidth = 3;
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.layer.cornerRadius = 5;
    self.imageView.clipsToBounds = YES;
    NSLog(@"%@", NSStringFromCGRect(self.bounds));
}

@end
