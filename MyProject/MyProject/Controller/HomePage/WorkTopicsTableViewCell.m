//
//  WorkTopicsTableViewCell.m
//  MyProject
//
//  Created by jiaming yan on 2017/8/21.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "WorkTopicsTableViewCell.h"

@implementation WorkTopicsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.zanButton.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    self.commentButton.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
