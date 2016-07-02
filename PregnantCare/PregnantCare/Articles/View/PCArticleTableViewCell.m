//
//  PCArticleTableViewCell.m
//  PregnantCare
//
//  Created by tarena on 16/6/6.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PCArticleTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface PCArticleTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *articleImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *watchImage;
@property (weak, nonatomic) IBOutlet UILabel *readLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end

@implementation PCArticleTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setArticle:(PCArticle *)article
{
    _article = article;
    [self.articleImage sd_setImageWithURL:[NSURL URLWithString:article.p] placeholderImage:[UIImage imageNamed:@"strategy_default"]];
    self.titleLabel.text = article.t;
    self.watchImage.image = [UIImage imageNamed:@"strategy_count"];
    self.readLabel.text = article.show;
    NSRange range = [article.date rangeOfString:@" "];
    self.dateLabel.text = [article.date substringToIndex:range.location];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
