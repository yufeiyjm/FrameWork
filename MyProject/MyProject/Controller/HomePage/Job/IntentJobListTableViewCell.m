//
//  IntentJobListTableViewCell.m
//  MyProject
//
//  Created by jiaming yan on 2017/8/29.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "IntentJobListTableViewCell.h"

@implementation IntentJobListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.selectButton setImage:IMAGE(@"未选中") forState:UIControlStateNormal];
    [self.selectButton setImage:IMAGE(@"选中") forState:UIControlStateSelected];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
