//
//  SceneExaminationTableViewCell.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/5.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "SceneExaminationTableViewCell.h"

@implementation SceneExaminationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.starRatingView.maximumValue = 5;
    self.starRatingView.minimumValue = 0;
    self.starRatingView.spacing = 18;//间距，星星大小是去掉间距后计算的
    self.starRatingView.value = 4;
    self.starRatingView.tintColor = UIColorFromRGB(0x1eb0c1);//星星的颜色。
    self.starRatingView.allowsHalfStars = YES;//是否有半星
    self.starRatingView.emptyStarImage = [[UIImage imageNamed:@"星星（空）"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.starRatingView.filledStarImage = [[UIImage imageNamed:@"星星"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
