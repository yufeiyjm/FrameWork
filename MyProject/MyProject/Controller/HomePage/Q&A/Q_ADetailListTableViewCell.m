//
//  Q_ADetailListTableViewCell.m
//  MyProject
//
//  Created by jiaming yan on 2017/8/22.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "Q_ADetailListTableViewCell.h"

@implementation Q_ADetailListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.zanButton.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
