//
//  DiagCategoryCell.m
//  PregnantCare
//
//  Created by tarena on 16/6/14.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "DiagCategoryCell.h"

@interface DiagCategoryCell ()
@property (weak, nonatomic) IBOutlet UIImageView *cateImage;
@property (weak, nonatomic) IBOutlet UILabel *cateNameLabel;
@end
@implementation DiagCategoryCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setCategory:(PCDiagnoseCategory *)category
{
    _category = category;
    self.cateImage.highlightedImage = [UIImage imageNamed:[NSString stringWithFormat:@"symptom%d_select",[_category.position intValue]]];
    self.cateImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"symptom%d",[_category.position intValue]]];
    self.cateNameLabel.text = _category.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
